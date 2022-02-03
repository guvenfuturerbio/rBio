import 'package:flutter/material.dart';

import '../core.dart';

class ThemeNotifier extends ChangeNotifier {
  late ITheme theme;
  late TextScaleType textScale;

  ThemeNotifier() {
    final sharedTheme = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.THEME);
    if (sharedTheme != null) {
      final sharedThemeKey = sharedTheme.xTheme;
      theme = sharedThemeKey!.xGetTheme;
    } else {
      theme = GreenTheme();
    }

    final sharedTextScale = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.TEXT_SCALE);
    if (sharedTextScale != null) {
      textScale = sharedTextScale.xTextScaleKeys!;
    } else {
      textScale = TextScaleType.small;
    }

    getIt.registerSingleton<ITheme>(theme);
  }

  Future<void> changeTheme(ThemeType type) async {
    theme = type.xGetTheme;
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.THEME, type.xRawValue);
    getIt.unregister<ITheme>();
    getIt.registerSingleton<ITheme>(theme);
    notifyListeners();
  }

  Future<void> changeTextScale() async {
    textScale = textScale.getNextType();
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.TEXT_SCALE, textScale.xRawValue);
    getIt.unregister<ITheme>();
    getIt.registerSingleton<ITheme>(theme);
    notifyListeners();
  }
}
