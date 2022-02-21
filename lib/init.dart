import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'core/core.dart';

class AppInit {
  AppInit._();

  static Future<void> initialize(AppConfig appConfig) async {
    await SecretUtils.instance.setup(Environment.prod);
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
  }
}
