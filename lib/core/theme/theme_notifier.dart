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

  Future<void> changeTheme(ITheme theme) async {
    this.theme = theme;
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.THEME, theme.type.xRawValue);
    getIt.registerSingleton<ITheme>(theme);
    notifyListeners();
  }
}
