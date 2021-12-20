import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core.dart';

class LocaleNotifier with ChangeNotifier {
  String current;
  LocaleNotifier() {
    current = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.SELECTED_LOCALE);
    if (current != null) {
      LoggerUtils.instance.i('Current locale = $current.');
      changeLocale(current);
    } else {
      current = Intl.getCurrentLocale().toLowerCase();
      changeLocale(current);
    }
  }

  Future<void> changeLocale(String locale) async {
    if (LocaleProvider.delegate.isSupported(Locale(locale.toLowerCase()))) {
      LocaleProvider.delegate.load(Locale(locale.toLowerCase()));
      await getIt<ISharedPreferencesManager>().setString(
          SharedPreferencesKeys.SELECTED_LOCALE, locale.toLowerCase());
      current = locale.toLowerCase();
    } else {
      throw Exception("Unsupported Language !!");
    }
    notifyListeners();
  }
}
