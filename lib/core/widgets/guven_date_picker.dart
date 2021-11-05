import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'package:intl/intl.dart';

import '../core.dart';

Future<DateTime> showGuvenDatePicker(
  BuildContext context,
  DateTime firstDate,
  DateTime lastDate,
  DateTime initialDate,
) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    helpText: LocaleProvider.of(context).select_birth_date,
    cancelText: LocaleProvider.of(context).btn_cancel,
    confirmText: LocaleProvider.of(context).btn_confirm,
    locale: Locale(Intl.getCurrentLocale().toLowerCase()),
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: getIt<ITheme>().mainColor,
          ),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child,
      );
    },
  );
}
