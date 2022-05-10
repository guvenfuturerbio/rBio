import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app/app.dart';
import 'app/bluetooth_v2/bluetooth_v2.dart';
import 'core/core.dart';

Future<void> bootstrap(IAppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
            apiKey: "AIzaSyDtXrBmkyb9UvBH_fU6Tz4MKfZijqDVKLo",
            authDomain: "rbio-ec8b1.firebaseapp.com",
            projectId: "rbio-ec8b1",
            storageBucket: "rbio-ec8b1.appspot.com",
            messagingSenderId: "265636530937",
            appId: "1:265636530937:web:5d18cdcf7fd03242263028",
            measurementId: "G-BYWQLYEVVW",
          )
        : null,
  );
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
            child: kIsWeb
                ? MyApp(initialRoute: initialRoute)
                : BlocProvider<BluetoothBloc>(
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
                                    BluetoothStatusCubit(getIt())
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
