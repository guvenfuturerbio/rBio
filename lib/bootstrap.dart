import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app/app.dart';
import 'core/core.dart';

Future<void> bootstrap(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();

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
      initialRoute = PagePaths.introduction;
    }
  }

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          AppInheritedWidget(
            child: BlocProvider<BluetoothBloc>(
              lazy: false,
              create: (context) => BluetoothBloc(
                getIt<BleScanner>(),
                getIt<BleConnector>(),
                getIt<BleDeviceManager>(),
              )..add(const BluetoothEvent.init()),
              child: MyApp(initialRoute: initialRoute),
            ),
          ),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
