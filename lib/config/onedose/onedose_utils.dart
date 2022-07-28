part of '../abstract/app_config.dart';

class OneDoseUtils extends IAppUtils {
  @override
  AppThemeTypes getInitialTheme(ISharedPreferencesManager manager) {
    final sharedTheme = manager.getString(SharedPreferencesKeys.theme);
    return (sharedTheme ?? AppThemeTypes.oneDoseLight.xRawValue).xThemeKeys ??
        AppThemeTypes.oneDoseLight;
  }

  @override
  IAppTheme getThemeByType(AppThemeTypes type) {
    switch (type) {
      case AppThemeTypes.oneDoseDark:
        return OneDoseDarkTheme();

      case AppThemeTypes.oneDoseLight:
      default:
        return OneDoseTheme();
    }
  }

  @override
  String getInitialRoute(ISharedPreferencesManager sharedPreferencesManager) {
    String initialRoute = PagePaths.login;
    final mobileIntroduction =
        sharedPreferencesManager.getBool(SharedPreferencesKeys.firstLaunch) ??
            false;
    if (!mobileIntroduction) {
      initialRoute = PagePaths.onboarding;
    }
    return initialRoute;
  }
}
