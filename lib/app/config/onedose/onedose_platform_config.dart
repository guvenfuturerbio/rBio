part of '../abstract/app_config.dart';

abstract class IOneDosePlatformConfig extends IAppPlatformConfig {
  IOneDosePlatformConfig(
    FirebaseOptions? options,
    AdjustManager? adjustManager,
    RecaptchaManager? recaptchaManager,
    GeolocatorManager? geolocatorManager,
  ) : super(
          options,
          adjustManager,
          recaptchaManager,
          OneDoseSentryManagerImpl(),
          geolocatorManager,
        );
}

class OneDoseMobilePlatformConfig extends IOneDosePlatformConfig
    with IAppMobilePlatformConfig {
  OneDoseMobilePlatformConfig()
      : super(null, OneDoseAdjustManagerImpl(), null, null);

  @override
  String getInitialRoute(ISharedPreferencesManager sharedPreferencesManager) {
    String initialRoute = PagePaths.login;
    final mobileIntroduction =
        sharedPreferencesManager.getBool(SharedPreferencesKeys.firstLaunch) ??
            false;
    if (!mobileIntroduction) {
      initialRoute = PagePaths.onboarding;
    }
    return initialRoute;
  }

  @override
  bool checkDevices() => true;

  @override
  bool checkMedimender() => true;
}

class OneDoseWebPlatformConfig extends IOneDosePlatformConfig
    with IAppWebPlatformConfig {
  OneDoseWebPlatformConfig()
      : super(
            const FirebaseOptions(
              apiKey: "AIzaSyDtXrBmkyb9UvBH_fU6Tz4MKfZijqDVKLo",
              authDomain: "rbio-ec8b1.firebaseapp.com",
              projectId: "rbio-ec8b1",
              storageBucket: "rbio-ec8b1.appspot.com",
              messagingSenderId: "265636530937",
              appId: "1:265636530937:web:5d18cdcf7fd03242263028",
              measurementId: "G-BYWQLYEVVW",
            ),
            null,
            null,
            null);

  @override
  bool checkDevices() => false;

  @override
  bool checkMedimender() => false;
}
