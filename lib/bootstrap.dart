import 'dart:async';
import 'dart:developer';

import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_repository/scale_repository.dart';
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

  LoggerUtils.instance.i(Utils.instance.getAge());

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          AppInheritedWidget(
            child: BlocProvider<BluetoothBloc>(
              create: (context) => BluetoothBloc(
                getIt<BluetoothConnector>(),
                getIt<BleReactorOps>(),
                getIt<ProfileStorageImpl>(),
                getIt<ScaleRepository>(),
              )
                ..add(const BluetoothEvent.gotPairedDevices())
                ..add(const BluetoothEvent.deviceConnected()),
              child: const MyApp(),
            ),
          ),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
