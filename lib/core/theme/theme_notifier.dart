import 'package:flutter/material.dart';

import '../core.dart';

class ThemeNotifier extends ChangeNotifier {
  TextScaleType textScale = TextScaleType.small;
  late final ISharedPreferencesManager sharedPreferencesManager;

  ThemeNotifier(this.sharedPreferencesManager) {
    final sharedTextScale = sharedPreferencesManager.getString(
      SharedPreferencesKeys.textScale,
    );
    if (sharedTextScale != null) {
      textScale = sharedTextScale.xTextScaleKeys!;
    }
  }

  Future<void> changeTextScale() async {
    textScale = textScale.getNextType();
    await sharedPreferencesManager.setString(
      SharedPreferencesKeys.textScale,
      textScale.xRawValue,
    );
    notifyListeners();
  }
}
