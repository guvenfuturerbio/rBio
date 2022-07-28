import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'config/config.dart';
import 'core/core.dart';

Future<void> bootstrap(IAppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: appConfig.platform.options);
  await initializeLocator(appConfig);
  appConfig.platform.adjustManager?.initializeAdjust();
  timeago.setLocaleMessages('tr', timeago.TrMessages());
  RegisterPlatformViews.instance.initialize();
  await appConfig.platform.sendFirstOpenFirebaseEvent(
    getIt<ISharedPreferencesManager>(),
    getIt<FirebaseAnalyticsManager>(),
    appConfig.platform.adjustManager,
  );
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
    appConfig.platform.sentryManager.captureException(
      details.exception,
      stackTrace: details.stack,
    );
  };

  var jailbroken = false;
  if (!Atom.isWeb) {
    jailbroken = await FlutterJailbreakDetection.jailbroken;
  }

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
                    initialRoute: appConfig.utils.getInitialRoute(getIt()),
                    jailbroken: jailbroken,
                    initialTheme: appConfig.utils.getInitialTheme(getIt()),
                  ),
                ),
              ),
            ),
            blocObserver: AppBlocObserver(),
          );
        },
        getIt<GuvenSettings>().appVersion,
        getIt<KeyManager>().get(Keys.sentryDsn),
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
