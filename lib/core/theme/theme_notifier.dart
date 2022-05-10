import 'package:flutter/material.dart';

import '../core.dart';

class ThemeNotifier extends ChangeNotifier {
  late TextScaleType textScale;

  ThemeNotifier() {
    final sharedTextScale = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.textScale);
    if (sharedTextScale != null) {
      textScale = sharedTextScale.xTextScaleKeys!;
    } else {
      textScale = TextScaleType.small;
    }
  }

  Future<void> changeTextScale() async {
    textScale = textScale.getNextType();
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.textScale, textScale.xRawValue);
    notifyListeners();
  }
}
