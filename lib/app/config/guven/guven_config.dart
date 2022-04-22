part of '../abstract/app_config.dart';

class GuvenConfig extends IAppConfig {
  GuvenConfig()
      : super(
          theme: GuvenTheme(),
          functionality: GuvenFunctionality(),
          endpoints: GuvenEndpoints(),
        );
}
