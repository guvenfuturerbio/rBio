import 'package:flutter/material.dart';

import '../core.dart';
import 'main_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ITheme theme;

  ThemeNotifier() {
    final sharedTheme = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.THEME);
    if (sharedTheme != null) {
      final sharedThemeKey = sharedTheme.xTheme;
      theme = sharedThemeKey.xGetTheme;
    } else {
      theme = GreenTheme();
    }

    getIt.registerSingleton<ITheme>(theme);
  }

  // context.read<ThemeNotifier>().changeTheme(ThemeType.Burgundy);
  Future<void> changeTheme(ThemeType type) async {
    theme = type.xGetTheme;
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.THEME, type.xRawValue);
    getIt.unregister<ITheme>();
    getIt.registerSingleton<ITheme>(theme);
    notifyListeners();
  }
}
