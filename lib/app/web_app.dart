import 'package:flutter/material.dart';

import '../config/config.dart';
import 'my_app.dart';
import 'my_app_common.dart';

class WebApp extends StatelessWidget {
  final MyApp myApp;

  const WebApp({
    Key? key,
    required this.myApp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myApp.setJailbroken(false);
    return myApp.build(context);
  }
}

class WebMyApp extends StatelessWidget with MyApp {
  final String initialRoute;
  final AppThemeTypes initialTheme;

  WebMyApp({
    Key? key,
    required this.initialRoute,
    required this.initialTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAppCommon(
      initialRoute: initialRoute,
      initialTheme: initialTheme,
    );
  }
}
