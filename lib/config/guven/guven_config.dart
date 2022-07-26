part of '../abstract/app_config.dart';

class GuvenConfig extends IAppConfig<IGuvenPlatformConfig> {
  GuvenConfig()
      : super(
          title: 'Güven Online',
          productType: ProductType.guven,
          functionality: GuvenFunctionality(),
          constants: GuvenConstants(),
          utils: GuvenUtils(),
        ) {
    setDeviceConfig();
  }

  @override
  void setDeviceConfig() {
    if (kIsWeb) {
      super.platform = GuvenWebPlatformConfig();
    } else {
      super.platform = GuvenMobilePlatformConfig();
    }
  }

  @override
  IProductDashboard getDashboard() {
    return GuvenDashboardNavigation();
  }

  @override
  void setEndpoints() {
    super.endpoints = GuvenEndpoints();
  }
}
