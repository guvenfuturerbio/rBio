part of '../abstract/app_config.dart';

class OneDoseConfig extends IAppConfig {
  OneDoseConfig()
      : super(
          productType: ProductType.oneDose,
          theme: OneDoseTheme(),
          functionality: OneDoseFunctionality(),
          endpoints: OneDoseEndpoints(),
        );
}
