part of '../abstract/app_config.dart';

class OneDoseConfig implements IAppConfig {
  @override
  IAppTheme get theme => OneDoseTheme();

  @override
  IAppFunctionality get functionality => OneDoseFunctionality();

  @override
  IAppEndpoints get endpoints => OneDoseEndpoints();
}
