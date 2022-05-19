// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/core/core.dart';

import '../../../../../app/config/abstract/app_config.dart';
import '../../../../locator.dart';
import '../customization/header_style.dart';
import '../shared/utils.dart' show CalendarFormat, DayBuilder;
import 'custom_icon_button.dart';

class CalendarHeader extends StatelessWidget {
  final dynamic locale;
  final DateTime focusedMonth;
  final CalendarFormat calendarFormat;
  final HeaderStyle headerStyle;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final VoidCallback onHeaderTap;
  final VoidCallback onHeaderLongPress;
  final ValueChanged<CalendarFormat> onFormatButtonTap;
  final Map<CalendarFormat, String> availableCalendarFormats;
  final DayBuilder? headerTitleBuilder;

  const CalendarHeader({
    Key? key,
    this.locale,
    required this.focusedMonth,
    required this.calendarFormat,
    required this.headerStyle,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.onHeaderTap,
    required this.onHeaderLongPress,
    required this.onFormatButtonTap,
    required this.availableCalendarFormats,
    this.headerTitleBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = headerStyle.titleTextFormatter?.call(focusedMonth, locale) ??
        DateFormat.yMMMM(locale).format(focusedMonth);

    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: R.sizes.radiusCircular,
      ),
      child: Container(
        decoration: headerStyle.decoration,
        margin: headerStyle.headerMargin,
        padding: headerStyle.headerPadding,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (headerStyle.leftChevronVisible) ...[
              CustomIconButton(
                icon: headerStyle.leftChevronIcon,
                onTap: onLeftChevronTap,
                margin: headerStyle.leftChevronMargin,
                padding: headerStyle.leftChevronPadding,
              ),
            ],

            //
            Expanded(
              child: Center(
                child: headerTitleBuilder?.call(context, focusedMonth) ??
                    GestureDetector(
                      onTap: onHeaderTap,
                      onLongPress: onHeaderLongPress,
                      child: Text(
                        text,
                        style: headerStyle.titleTextStyle.copyWith(
                          color: getIt<IAppConfig>().theme.textContrastColor,
                        ),
                        textAlign: headerStyle.titleCentered
                            ? TextAlign.center
                            : TextAlign.start,
                      ),
                    ),
              ),
            ),

            //
            if (headerStyle.rightChevronVisible)
              CustomIconButton(
                icon: headerStyle.rightChevronIcon,
                onTap: onRightChevronTap,
                margin: headerStyle.rightChevronMargin,
                padding: headerStyle.rightChevronPadding,
              ),
          ],
        ),
      ),
    );
  }
}
