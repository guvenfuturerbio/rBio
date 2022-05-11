import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app/app.dart';
import 'app/bluetooth_v2/bluetooth_v2.dart';
import 'core/core.dart';

Future<void> bootstrap(IAppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  AdjustConfig adjustConfig =
      AdjustConfig('1vvx05nbpkio', AdjustEnvironment.production);
  adjustConfig.setAppSecret(1, 492801584, 1304692510, 331550936, 2085469560);

  Adjust.start(adjustConfig);

  adjustConfig.logLevel = AdjustLogLevel.verbose;

  await Firebase.initializeApp();
  await setupLocator(appConfig);
  timeago.setLocaleMessages('tr', timeago.TrMessages());
  RegisterViews.instance.init();
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

  String initialRoute = PagePaths.login;
  if (!Atom.isWeb) {
    final mobileIntroduction = getIt<ISharedPreferencesManager>()
            .getBool(SharedPreferencesKeys.firstLaunch) ??
        false;
    if (!mobileIntroduction) {
      initialRoute = PagePaths.onboarding;
    }
  }

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          AppInheritedWidget(
            localNotificationManager: getIt(),
            child: BlocProvider<BluetoothBloc>(
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
                          create: (context) => BluetoothStatusCubit(getIt())
                            ..listenStateOfBluetooth(),
                        ),
                        BlocProvider<DeviceSearchCubit>(
                          create: (context) =>
                              DeviceSearchCubit(getIt(), getIt()),
                        ),
                        BlocProvider<DeviceSelectedCubit>(
                          create: (context) => DeviceSelectedCubit(
                            context.read<MiScaleStatusCubit>(),
                            getIt(),
                            getIt(),
                            getIt(),
                            getIt(),
                          ),
                        ),
                        BlocProvider<MiScaleOpsCubit>(
                          create: (context) =>
                              MiScaleOpsCubit(getIt(), getIt()),
                        ),
                      ],
                      child: MyApp(initialRoute: initialRoute),
                    );
                  },
                ),
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
