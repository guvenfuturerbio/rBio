part of '../abstract/app_config.dart';

class GuvenUtils extends IAppUtils {
  @override
  AppThemeTypes getInitialTheme(ISharedPreferencesManager manager) {
    final sharedTheme = manager.getString(SharedPreferencesKeys.theme);
    return (sharedTheme ?? AppThemeTypes.guvenLight.xRawValue).xThemeKeys ??
        AppThemeTypes.guvenLight;
  }

  @override
  IAppTheme getThemeByType(AppThemeTypes type) {
    return GuvenTheme();
  }

  @override
  String getInitialRoute(ISharedPreferencesManager sharedPreferencesManager) {
    return PagePaths.login;
  }
}
