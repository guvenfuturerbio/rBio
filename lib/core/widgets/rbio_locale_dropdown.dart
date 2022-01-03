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
          borderRadius: BorderRadius.circular(12.0),
          color: getIt<ITheme>().cardBackgroundColor,
        ),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              value: null,
              hint: getLocaleWidget(
                  context.read<LocaleNotifier>().current, context),
              items: LocaleProvider.delegate.supportedLocales.map(
                (Locale localeValue) {
                  return DropdownMenuItem<Locale>(
                      value: localeValue,
                      child: getLocaleWidget(localeValue, context));
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

  Widget getLocaleWidget(Locale localeValue, BuildContext context) {
    if ('tr' == localeValue.languageCode) {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          R.image.tr_flag,
          width: 30,
        ),
        R.sizes.wSizer4,
        Text(
          'TR',
          style: context.xHeadline5,
        ),
      ]);
    } else {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          R.image.eng_flag,
          width: 30,
        ),
        R.sizes.wSizer4,
        Text('EN', style: context.xHeadline5),
      ]);
    }
  }
}
