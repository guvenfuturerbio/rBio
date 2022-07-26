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
  Widget runApp({
    required String initialRoute,
    required bool jailbroken,
    required AppThemeTypes initialTheme,
  });
  Future<void> sendFirstOpenFirebaseEvent(
    ISharedPreferencesManager sharedPreferencesManager,
    FirebaseAnalyticsManager firebaseAnalyticsManager,
    AdjustManager? adjustManager,
  );
  bool checkDevices();
  bool checkMedimender();
}

abstract class IAppWebPlatformConfig {
  Widget runApp({
    required String initialRoute,
    required bool jailbroken,
    required AppThemeTypes initialTheme,
  }) {
    return WebApp(
      myApp: WebMyApp(
        initialRoute: initialRoute,
        initialTheme: initialTheme,
      ),
    );
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
  Widget runApp({
    required String initialRoute,
    required bool jailbroken,
    required AppThemeTypes initialTheme,
  }) {
    return MobileApp(
      myApp: MobileMyApp(
        initialRoute: initialRoute,
        initialTheme: initialTheme,
      ),
      jailbroken: jailbroken,
    );
  }

  Future<void> sendFirstOpenFirebaseEvent(
    ISharedPreferencesManager sharedPreferencesManager,
    FirebaseAnalyticsManager firebaseAnalyticsManager,
    AdjustManager? adjustManager,
  ) async {
    if (sharedPreferencesManager.get(SharedPreferencesKeys.appDownload) ==
        null) {
      await sharedPreferencesManager.setBool(
          SharedPreferencesKeys.appDownload, false);
      firebaseAnalyticsManager.logEvent(NewDownloadEvent());
      adjustManager?.trackEvent(NewDownloadsEvent());
    }
  }
}
