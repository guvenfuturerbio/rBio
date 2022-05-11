part of 'app_config.dart';

abstract class IAppPlatformConfig {
  FirebaseOptions? options;
  IAppPlatformConfig(this.options);
  Widget runApp(String initialRoute);
}

abstract class IAppWebPlatformConfig {
  Widget runApp(String initialRoute) {
    return WebApp(myApp: WebMyApp(initialRoute: initialRoute));
  }
}

abstract class IAppMobilePlatformConfig {
  Widget runApp(String initialRoute) {
    return MobileApp(myApp: MobileMyApp(initialRoute: initialRoute));
  }
}
