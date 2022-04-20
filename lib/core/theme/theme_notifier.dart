import 'package:flutter/material.dart';

import '../core.dart';

class ThemeNotifier extends ChangeNotifier {
  late IAppTheme theme;
  late TextScaleType textScale;

  ThemeNotifier() {
    final sharedTheme = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.theme);
    if (sharedTheme != null) {
      final sharedThemeKey = sharedTheme.xTheme;
      theme = sharedThemeKey!.xGetTheme;
    } else {
      theme = OneDoseTheme();
    }

    final sharedTextScale = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.textScale);
    if (sharedTextScale != null) {
      textScale = sharedTextScale.xTextScaleKeys!;
    } else {
      textScale = TextScaleType.small;
    }

    getIt.registerSingleton<IAppTheme>(theme);
  }

  Future<void> changeTheme(ThemeType type) async {
    theme = type.xGetTheme;
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.theme, type.xRawValue);
    getIt.unregister<IAppTheme>();
    getIt.registerSingleton<IAppTheme>(theme);
    notifyListeners();
  }

  Future<void> changeTextScale() async {
    textScale = textScale.getNextType();
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.textScale, textScale.xRawValue);
    getIt.unregister<IAppTheme>();
    getIt.registerSingleton<IAppTheme>(theme);
    notifyListeners();
  }
}
