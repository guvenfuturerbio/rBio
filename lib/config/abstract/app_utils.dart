part of 'app_config.dart';

abstract class IAppUtils {
  AppThemeTypes getInitialTheme(ISharedPreferencesManager manager);
  IAppTheme getThemeByType(AppThemeTypes type);
  String getInitialRoute(ISharedPreferencesManager sharedPreferencesManager);
}
