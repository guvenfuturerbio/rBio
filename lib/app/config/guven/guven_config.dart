part of '../abstract/app_config.dart';

class GuvenConfig extends IAppConfig<IGuvenPlatformConfig> {
  GuvenConfig()
      : super(
          title: 'One Dose Healt',
          productType: ProductType.oneDose,
          theme: OneDoseTheme(),
          functionality: GuvenFunctionality(),
          constants: GuvenConstants(),
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
