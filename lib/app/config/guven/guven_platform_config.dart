part of '../abstract/app_config.dart';

abstract class IGuvenPlatformConfig extends IAppPlatformConfig {
  IGuvenPlatformConfig(
    FirebaseOptions? options,
    AdjustManager? adjustManager,
    RecaptchaManager? recaptchaManager,
    GeolocatorManager? geolocatorManager,
  ) : super(
          options,
          adjustManager,
          recaptchaManager,
          GuvenOnlineSentryManagerImpl(),
          GeolocatorManagerImpl(),
        );
}

class GuvenMobilePlatformConfig extends IGuvenPlatformConfig
    with IAppMobilePlatformConfig {
  GuvenMobilePlatformConfig()
      : super(null, GuvenOnlineAdjustManagerImpl(), null,
            GeolocatorManagerImpl());

  @override
  String getInitialRoute(ISharedPreferencesManager sharedPreferencesManager) {
    return PagePaths.login;
  }

  @override
  bool checkDevices() => false;

  @override
  bool checkMedimender() => false;
}

class GuvenWebPlatformConfig extends IGuvenPlatformConfig
    with IAppWebPlatformConfig {
  GuvenWebPlatformConfig()
      : super(
          const FirebaseOptions(
            apiKey: "AIzaSyDIBBWq-SOe1_hZy43VIzKiAD5lN3jrQ0o",
            authDomain: "guven-mobile-7c512.firebaseapp.com",
            databaseURL: "https://guven-mobile-7c512.firebaseio.com",
            projectId: "guven-mobile-7c512",
            storageBucket: "guven-mobile-7c512.appspot.com",
            messagingSenderId: "647411760545",
            appId: "1:647411760545:web:20b622784c0cb600259fe0",
            measurementId: "G-GPMMZ6Y733",
          ),
          null,
          GuvenRecaptchaManagerImpl(),
          GeolocatorManagerImpl(),
        );
  @override
  bool checkDevices() => false;

  @override
  bool checkMedimender() => false;
}
