part of 'app_config.dart';

abstract class IAppPlatformConfig {
  FirebaseOptions? options;
  AdjustManager? adjustManager;
  RecaptchaManager? recaptchaManager;
  late SentryManager sentryManager;
  IAppPlatformConfig(
    this.options,
    this.adjustManager,
    this.recaptchaManager,
    this.sentryManager,
  );
  Widget runApp(String initialRoute, bool jailbroken);
  String getInitialRoute(ISharedPreferencesManager sharedPreferencesManager);
  Future<void> sendFirstOpenFirebaseEvent(
    ISharedPreferencesManager sharedPreferencesManager,
    FirebaseAnalyticsManager firebaseAnalyticsManager,
    AdjustManager? adjustManager,
  );
  bool checkDevices();
  bool checkMedimender();
}

abstract class IAppWebPlatformConfig {
  Widget runApp(String initialRoute, bool jailbroken) {
    return WebApp(myApp: WebMyApp(initialRoute: initialRoute));
  }

  String getInitialRoute(ISharedPreferencesManager sharedPreferencesManager) {
    return PagePaths.login;
  }

  Future<void> sendFirstOpenFirebaseEvent(
    ISharedPreferencesManager sharedPreferencesManager,
    FirebaseAnalyticsManager firebaseAnalyticsManager,
    AdjustManager? adjustManager,
  ) async {
    //
  }
}

abstract class IAppMobilePlatformConfig {
  Widget runApp(String initialRoute, bool jailbroken) {
    return MobileApp(
      myApp: MobileMyApp(
        initialRoute: initialRoute,
      ),
      jailbroken: jailbroken,
    );
  }

  Future<void> sendFirstOpenFirebaseEvent(
    ISharedPreferencesManager sharedPreferencesManager,
    FirebaseAnalyticsManager firebaseAnalyticsManager,
    AdjustManager? adjustManager,
  ) async {
    if (sharedPreferencesManager.get(SharedPreferencesKeys.appDownload) == null) {
      await sharedPreferencesManager.setBool(SharedPreferencesKeys.appDownload, false);
      firebaseAnalyticsManager.logEvent(NewDownloadEvent());
      adjustManager?.trackEvent(NewDownloadsEvent());
    }
  }
}
