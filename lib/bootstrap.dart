import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app/app.dart';
import 'app/bluetooth_v2/bluetooth_v2.dart';
import 'app/bluetooth_v2/presentation/bloc/accu_chek_ops/accu_chek_ops_cubit.dart';
import 'core/core.dart';

Future<void> bootstrap(IAppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: appConfig.platform.options);
  await initializeLocator(appConfig);
  appConfig.platform.adjustManager?.initializeAdjust();
  timeago.setLocaleMessages('tr', timeago.TrMessages());
  RegisterViews.instance.initialize();
  await appConfig.platform.sendFirstOpenFirebaseEvent(
      getIt<ISharedPreferencesManager>(),
      getIt<FirebaseAnalyticsManager>(),
      appConfig.platform.adjustManager);
  await appConfig.platform.recaptchaManager?.init();

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
    appConfig.platform.sentryManager.captureException(
      details.exception,
      stackTrace: details.stack,
    );
  };

  runZonedGuarded(
    () async {
      appConfig.platform.sentryManager.init(
        () async {
          await BlocOverrides.runZoned(
            () async => runApp(
              appConfig.platform.sentryManager.wrapBundle(
                AppInheritedWidget(
                  localNotificationManager: getIt(),
                  child: appConfig.platform.runApp(
                    appConfig.platform.getInitialRoute(
                      getIt<ISharedPreferencesManager>(),
                    ),
                  ),
                ),
              ),
            ),
            blocObserver: AppBlocObserver(),
          );
        },
        '1.0.32+48',
      );
    },
    (error, stackTrace) async {
      log(error.toString(), stackTrace: stackTrace);
      await appConfig.platform.sentryManager.captureException(
        error,
        stackTrace: stackTrace,
      );
    },
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

                //
                BlocProvider<AccuChekOpsCubit>(
                  create: (context) => AccuChekOpsCubit(getIt()),
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
