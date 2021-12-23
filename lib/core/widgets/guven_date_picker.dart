import 'package:flutter/material.dart';

import '../core.dart';

Future<DateTime> showGuvenDatePicker(
  BuildContext context,
  DateTime firstDate,
  DateTime lastDate,
  DateTime initialDate,
  String helpText,
) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    helpText: helpText,
    cancelText: LocaleProvider.of(context).btn_cancel,
    confirmText: LocaleProvider.of(context).btn_confirm,
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
