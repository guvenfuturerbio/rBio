part of '../abstract/app_config.dart';

class GuvenConfig extends IAppConfig<IOneDosePlatformConfig> {
  GuvenConfig()
      : super(
          title: 'One Dose Health',
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
      super.platform = OneDoseWebPlatformConfig();
    } else {
      super.platform = OneDoseMobilePlatformConfig();
    }
  }

  @override
  IProductDashboard getDashboard() {
    return DashboardNavigation();
  }

  @override
  void setEndpoints() {
    super.endpoints = GuvenEndpoints();
  }
}
