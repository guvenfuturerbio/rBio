import 'package:flutter/material.dart';

import '../core.dart';

class LocaleNotifier with ChangeNotifier {
  late Locale current;

  Future<void> init() async {
    final sharedValue = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.selectedLocale);
    if (sharedValue == null) {
      current = supportedLocales.first;
    } else {
      current = getLocaleByLanguageCode(sharedValue);
    }

    changeLocale(current);
  }

  Future<void> changeLocale(Locale locale) async {
    await LocaleProvider.delegate.load(locale);
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.selectedLocale, locale.languageCode);
    current = locale;
    notifyListeners();
  }

  // -------- -------- -------- --------

  static const _trLocal = const Locale('tr', 'TR');
  static const _enLocal = const Locale('en', 'US');
  final List<Locale> supportedLocales = [_trLocal, _enLocal];
  Locale getLocaleByLanguageCode(String value) {
    if (value == _trLocal.languageCode) {
      return _trLocal;
    } else if (value == _enLocal.languageCode) {
      return _enLocal;
    }

    return _enLocal;
  }

  String get getLocaleStr {
    if (current.languageCode == _trLocal.languageCode) {
      return 'tr_TR';
    } else if (current.languageCode == _enLocal.languageCode) {
      return 'en_US';
    }

    return 'tr_TR';
  }
}
