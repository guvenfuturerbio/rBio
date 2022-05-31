part of 'app_config.dart';

abstract class IAppPlatformConfig {
  FirebaseOptions? options;
  AdjustManager? adjustManager;
  IAppPlatformConfig(this.options, this.adjustManager);
  Widget runApp(String initialRoute);
  String getInitialRoute(ISharedPreferencesManager sharedPreferencesManager);
  Future<void> sendFirstOpenFirebaseEvent(
    ISharedPreferencesManager sharedPreferencesManager,
    FirebaseAnalyticsManager firebaseAnalyticsManager,
    AdjustManager adjustManager,
  );
  bool checkDevices();
  bool checkMedimender();
}

abstract class IAppWebPlatformConfig {
  Widget runApp(String initialRoute) {
    return WebApp(myApp: WebMyApp(initialRoute: initialRoute));
  }

  String getInitialRoute(ISharedPreferencesManager sharedPreferencesManager) {
    return PagePaths.login;
  }

  Future<void> sendFirstOpenFirebaseEvent(
    ISharedPreferencesManager sharedPreferencesManager,
    FirebaseAnalyticsManager firebaseAnalyticsManager,
    AdjustManager adjustManager,
  ) async {
    //
  }
}

abstract class IAppMobilePlatformConfig {
  Widget runApp(String initialRoute) {
    return MobileApp(myApp: MobileMyApp(initialRoute: initialRoute));
  }

  Future<void> sendFirstOpenFirebaseEvent(
    ISharedPreferencesManager sharedPreferencesManager,
    FirebaseAnalyticsManager firebaseAnalyticsManager,
    AdjustManager adjustManager,
  ) async {
    if (sharedPreferencesManager.get(SharedPreferencesKeys.appDownload) ==
        null) {
      await sharedPreferencesManager.setBool(
          SharedPreferencesKeys.appDownload, false);
      firebaseAnalyticsManager.logEvent(NewDownloadEvent());
      adjustManager.trackEvent(NewDownloadsEvent());
    }
  }
}
