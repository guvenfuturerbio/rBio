part of '../abstract/app_config.dart';

abstract class IOneDosePlatformConfig extends IAppPlatformConfig {
  IOneDosePlatformConfig(FirebaseOptions? options) : super(options);
}

class OneDoseMobilePlatformConfig extends IOneDosePlatformConfig
    with IAppMobilePlatformConfig {
  OneDoseMobilePlatformConfig() : super(null);
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
        );
}
