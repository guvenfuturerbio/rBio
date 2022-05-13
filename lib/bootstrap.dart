import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app/app.dart';
import 'app/bluetooth_v2/bluetooth_v2.dart';
import 'core/core.dart';

Future<void> bootstrap(IAppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: appConfig.platform.options);
  await initializeLocator(appConfig);
  appConfig.platform.initializeAdjust(getIt<AdjustManager>());
  timeago.setLocaleMessages('tr', timeago.TrMessages());
  RegisterViews.instance.initialize();
  await appConfig.platform.sendFirstOpenFirebaseEvent(
    getIt<ISharedPreferencesManager>(),
    getIt<FirebaseAnalyticsManager>(),
    getIt<AdjustManager>(),
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          AppInheritedWidget(
            localNotificationManager: getIt(),
            child: appConfig.platform.runApp(
              appConfig.platform.getInitialRoute(
                getIt<ISharedPreferencesManager>(),
              ),
            ),
          ),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class WebApp extends StatelessWidget {
  final MyApp myApp;

  const WebApp({
    Key? key,
    required this.myApp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return myApp.build(context);
  }
}

class MobileApp extends StatelessWidget {
  final MyApp myApp;

  const MobileApp({
    Key? key,
    required this.myApp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BluetoothBloc>(
      lazy: false,
      create: (context) => BluetoothBloc(
        getIt<BleScanner>(),
        getIt<BleConnector>(),
        getIt<BleDeviceManager>(),
      )..add(const BluetoothEvent.init()),
      child: BlocProvider<MiScaleStatusCubit>(
        lazy: false,
        create: (context) => MiScaleStatusCubit(getIt()),
        child: Builder(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<BluetoothStatusCubit>(
                  lazy: false,
                  create: (context) =>
                      BluetoothStatusCubit(getIt())..listenStateOfBluetooth(),
                ),

                //
                BlocProvider<DeviceSearchCubit>(
                  create: (context) => DeviceSearchCubit(getIt(), getIt()),
                ),

                //
                BlocProvider<DeviceSelectedCubit>(
                  create: (context) => DeviceSelectedCubit(
                    context.read<MiScaleStatusCubit>(),
                    getIt(),
                    getIt(),
                    getIt(),
                    getIt(),
                  ),
                ),

                //
                BlocProvider<MiScaleOpsCubit>(
                  create: (context) => MiScaleOpsCubit(getIt(), getIt()),
                ),
              ],
              child: myApp.build(context),
            );
          },
        ),
      ),
    );
  }
}
