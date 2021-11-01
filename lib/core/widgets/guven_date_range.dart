import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core.dart';
import 'guven_date_picker.dart';

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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              children: [
                //
                Text(
                  LocaleProvider.current.start,
                  style: TextStyle(
                    color: R.color.blue,
                    fontSize: 16,
                  ),
                ),

                //
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 30,
                    ),
                    child: InkWell(
                      onTap: () async {
                        final result = await showGuvenDatePicker(
                          context,
                          startMinDate ?? DateTime(2000, 1, 1),
                          startMaxDate ?? now,
                          startCurrentDate,
                        );

                        if (result != null) {
                          onStartDateChange(result);
                        }
                      },
                      child: Text(
                        DateFormat.yMMMd(Intl.getCurrentLocale())
                            .format(startCurrentDate),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            "_",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: R.color.blue,
              fontSize: 32,
            ),
          ),
        ),

        //
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Text(
                  LocaleProvider.current.end,
                  style: TextStyle(
                    color: R.color.blue,
                    fontSize: 16,
                  ),
                ),

                //
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 30,
                    ),
                    child: InkWell(
                      onTap: () async {
                        final result = await showGuvenDatePicker(
                          context,
                          endMinDate ?? now,
                          endMaxDate ??
                              DateTime(now.year + 1, now.month, now.day),
                          endCurrentDate,
                        );

                        if (result != null) {
                          onEndDateChange(result);
                        }
                      },
                      child: Text(
                        DateFormat.yMMMd(Intl.getCurrentLocale())
                            .format(endCurrentDate),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
