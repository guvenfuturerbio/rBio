part of '../abstract/app_config.dart';

class OneDoseConfig extends IAppConfig<IOneDosePlatformConfig> {
  OneDoseConfig()
      : super(
          productType: ProductType.oneDose,
          theme: OneDoseTheme(),
          functionality: OneDoseFunctionality(),
          endpoints: OneDoseEndpoints(),
          constants: OneDoseConstants(),
        ) {
    setDeviceConfig();
  }

  @override
  void setDeviceConfig() {
    if (kIsWeb) {
      super.platform = OneDoseWebPlatformConfig();
    } else {
      super.platform = OneDoseMobilePlatformConfig();
    }
  }
}
