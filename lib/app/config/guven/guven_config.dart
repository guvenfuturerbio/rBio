part of '../abstract/app_config.dart';

class GuvenConfig extends IAppConfig {
  GuvenConfig()
      : super(
          productType: ProductType.guven,
          theme: GuvenTheme(),
          functionality: GuvenFunctionality(),
          endpoints: GuvenEndpoints(),
        );
}
