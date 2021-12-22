import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../core.dart';

class RbioLocaleDropdown extends StatelessWidget {
  const RbioLocaleDropdown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          border: Border.all(
            color: getIt<ITheme>().mainColor,
          ),
        ),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              hint: Text(
                getHint(context),
                style: context.xHeadline4,
              ),
              items: LocaleProvider.delegate.supportedLocales.map(
                (Locale localeValue) {
                  return DropdownMenuItem<Locale>(
                    value: localeValue,
                    child: Text(localeValue.languageCode.toUpperCase()),
                  );
                },
              ).toList(),
              onChanged: (valueLocale) {
                getIt<LocaleNotifier>().changeLocale(valueLocale);
              },
            ),
          ),
        ),
      ),
    );
  }

  String getHint(BuildContext context) =>
      "${LocaleProvider.of(context).select_language} : ${getLocaleText(context)}";

  String getLocaleText(BuildContext context) {
    final supportedList = context.read<LocaleNotifier>().supportedLocales;
    final locale = getIt<LocaleNotifier>().current;
    if (locale.languageCode == supportedList.first.languageCode) {
      return 'TR';
    } else {
      return 'EN';
    }
  }
}
