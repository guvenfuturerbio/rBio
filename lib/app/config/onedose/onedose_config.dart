part of '../abstract/app_config.dart';

class OneDoseConfig extends IAppConfig {
  OneDoseConfig()
      : super(
          productType: ProductType.oneDose,
          theme: GuvenTheme(),
          functionality: OneDoseFunctionality(),
          endpoints: OneDoseEndpoints(),
        );
}
