part of '../abstract/app_config.dart';

class GuvenConfig implements IAppConfig {
  @override
  IAppTheme get theme => GuvenTheme();

  @override
  IAppFunctionality get functionality => GuvenFunctionality();

  @override
  IAppEndpoints get endpoints => GuvenEndpoints();
}
