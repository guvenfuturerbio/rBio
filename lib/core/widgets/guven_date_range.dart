import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core.dart';
import 'guven_date_picker.dart';

// ignore: must_be_immutable
class GuvenDateRange extends StatelessWidget {
  DateTime startCurrentDate;
  DateTime startMinDate;
  DateTime startMaxDate;
  final void Function(DateTime date) onStartDateChange;

  DateTime endCurrentDate;
  DateTime endMinDate;
  DateTime endMaxDate;
  final void Function(DateTime date) onEndDateChange;

  GuvenDateRange({
    @required this.startCurrentDate,
    this.startMinDate,
    this.startMaxDate,
    @required this.onStartDateChange,
    @required this.endCurrentDate,
    this.endMinDate,
    this.endMaxDate,
    @required this.onEndDateChange,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
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
            child: Text(
              DateFormat.yMMMd(Intl.getCurrentLocale())
                  .format(startCurrentDate),
              textAlign: TextAlign.center,
              style: context.xHeadline3,
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
            child: Text(
              DateFormat.yMMMd(Intl.getCurrentLocale()).format(endCurrentDate),
              textAlign: TextAlign.center,
              style: context.xHeadline3,
            ),
          ),
        ),
      ],
    );
  }
}
