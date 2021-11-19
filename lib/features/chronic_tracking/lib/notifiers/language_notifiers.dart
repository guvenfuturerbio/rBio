import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onedosehealth/generated/l10n.dart';

import 'shared_pref_notifiers.dart';

class AppLanguage extends ChangeNotifier {
  AppLanguage({this.langCode});
  String langCode;
  Future<void> changeLanguage(type) async {
    if (LocaleProvider.delegate.isSupported(Locale(type.toLowerCase()))) {
      LocaleProvider lp =
          await LocaleProvider.delegate.load(Locale(type.toLowerCase()));
      LocaleProvider.current = lp;
      SharedPrefNotifiers().setPreferedLang(type);
    }

    notifyListeners();
  }
}
