part of 'app_config.dart';

abstract class IAppPlatformConfig {
  FirebaseOptions? options;
  IAppPlatformConfig(this.options);
  Widget runApp(String initialRoute);
  void initializeAdjust(AdjustManager manager);
  String getInitialRoute(ISharedPreferencesManager sharedPreferencesManager);
  Future<void> sendFirstOpenFirebaseEvent(
    ISharedPreferencesManager sharedPreferencesManager,
    FirebaseAnalyticsManager firebaseAnalyticsManager,
  );
}

abstract class IAppWebPlatformConfig {
  Widget runApp(String initialRoute) {
    return WebApp(myApp: WebMyApp(initialRoute: initialRoute));
  }

  void initializeAdjust(AdjustManager manager) {
    //
  }

  String getInitialRoute(ISharedPreferencesManager sharedPreferencesManager) {
    return PagePaths.login;
  }

  Future<void> sendFirstOpenFirebaseEvent(
    ISharedPreferencesManager sharedPreferencesManager,
    FirebaseAnalyticsManager firebaseAnalyticsManager,
  ) async {
    //
  }
}

abstract class IAppMobilePlatformConfig {
  Widget runApp(String initialRoute) {
    return MobileApp(myApp: MobileMyApp(initialRoute: initialRoute));
  }

  void initializeAdjust(AdjustManager manager) {
    manager.initializeAdjust();
  }

  Future<void> sendFirstOpenFirebaseEvent(
    ISharedPreferencesManager sharedPreferencesManager,
    FirebaseAnalyticsManager firebaseAnalyticsManager,
  ) async {
    if (sharedPreferencesManager.get(SharedPreferencesKeys.appDownload) ==
        null) {
      await sharedPreferencesManager.setBool(
          SharedPreferencesKeys.appDownload, false);
      firebaseAnalyticsManager.logEvent(NewDownloadEvent());
    }
  }
}
