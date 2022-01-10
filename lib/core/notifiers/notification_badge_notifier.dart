import 'package:flutter/material.dart';

import '../core.dart';

class NotificationBadgeNotifier extends ChangeNotifier {
  bool value = false;

  void init() {
    final initValue = getIt<ISharedPreferencesManager>()
            .getBool(SharedPreferencesKeys.CHAT_NOTIFICATION) ??
        false;
    changeValue(initValue);
  }

  Future<void> changeValue(bool newValue) async {
    value = newValue;
    await getIt<ISharedPreferencesManager>()
        .setBool(SharedPreferencesKeys.CHAT_NOTIFICATION, value);
    notifyListeners();
  }
}
