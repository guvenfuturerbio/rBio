import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core.dart';
import 'guven_date_picker.dart';

class GuvenDateRange extends StatelessWidget {
  DateTime startCurrentDate;
  DateTime? startMinDate;
  DateTime? startMaxDate;
  final void Function(DateTime date) onStartDateChange;

  DateTime endCurrentDate;
  DateTime? endMinDate;
  DateTime? endMaxDate;
  final void Function(DateTime date) onEndDateChange;

  GuvenDateRange({
    Key? key,
    required this.startCurrentDate,
    this.startMinDate,
    this.startMaxDate,
    required this.onStartDateChange,
    required this.endCurrentDate,
    this.endMinDate,
    this.endMaxDate,
    required this.onEndDateChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 15,
      children: [
        //
        InkWell(
          onTap: () async {
            final result = await showGuvenDatePicker(
              context,
              startMinDate ?? DateTime(2000, 1, 1),
              startMaxDate ?? now,
              startCurrentDate,
              LocaleProvider.of(context).select_day_from,
            );

            if (result != null) {
              onStartDateChange(result);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: getIt<ITheme>().cardBackgroundColor,
              borderRadius: R.sizes.borderRadiusCircular,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat.yMMMd(Intl.getCurrentLocale())
                      .format(startCurrentDate),
                  textAlign: TextAlign.center,
                  style: context.xHeadline3,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: R.sizes.iconSize2,
                )
              ],
            ),
          ),
        ),

        //
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Text(
            "-",
            textAlign: TextAlign.center,
            style: context.xHeadline1,
          ),
        ),

        //
        InkWell(
          onTap: () async {
            final result = await showGuvenDatePicker(
              context,
              endMinDate ?? now,
              endMaxDate ?? DateTime(now.year + 1, now.month, now.day),
              endCurrentDate,
              LocaleProvider.of(context).select_day_to,
            );

            if (result != null) {
              onEndDateChange(result);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: getIt<ITheme>().cardBackgroundColor,
              borderRadius: R.sizes.borderRadiusCircular,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat.yMMMd(Intl.getCurrentLocale())
                      .format(endCurrentDate),
                  textAlign: TextAlign.center,
                  style: context.xHeadline3,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: R.sizes.iconSize2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
