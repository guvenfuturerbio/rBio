import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:onedosehealth/core/core.dart';
import 'package:provider/provider.dart';

import '../../../lib/extension/size_extension.dart';
import '../../../lib/widgets/utils/time_period_filters.dart';

part 'date_range_picker_vm.dart';

class DateRangePicker extends StatelessWidget {
  DateRangePicker(
      {Key key,
      this.selected,
      this.setSelectedItem,
      this.setStartDate,
      this.setEndDate,
      this.endDate,
      this.startDate,
      this.nextDate,
      this.previousDate,
      this.height})
      : super(key: key);
  final TimePeriodFilter selected;

  final DateTime startDate;
  final DateTime endDate;

  final Function(TimePeriodFilter) setSelectedItem;

  final Function(DateTime) setStartDate;
  final Function(DateTime) setEndDate;

  final double height;

  final Function() nextDate;
  final Function() previousDate;

  List<TimePeriodFilter> get items => [
        TimePeriodFilter.DAILY,
        TimePeriodFilter.WEEKLY,
        TimePeriodFilter.MONTHLY,
        TimePeriodFilter.MONTHLY_THREE,
        TimePeriodFilter.SPECIFIC
      ];

  @override
  Widget build(BuildContext context) {
    bool hasOverflow = false;

    for (var i = 0; i < items.length; i++) {
      if (hasOverflow) {
        break;
      } else {
        var _current = Locale(intl.Intl.getCurrentLocale());
        bool _isRtl = _current == Locale('ar') || _current == Locale('fa');
        final span = TextSpan(text: (items[i]).toShortString());
        final painter = TextPainter(
            text: span,
            maxLines: 1,
            textDirection: _isRtl ? TextDirection.rtl : TextDirection.ltr,
            textScaleFactor: context.TEXTSCALE);

        painter.layout();

        hasOverflow = painter.size.width >= (context.WIDTH - 16) / items.length;
      }
    }

    return ChangeNotifierProvider(
      create: (_) => DateRangePickerVm(context: context, items: items),
      child: Consumer<DateRangePickerVm>(
        builder: (_, value, __) => Container(
          height: height ??
              (context.HEIGHT * .05) *
                  (context.TEXTSCALE > 1 ? (context.TEXTSCALE / 2) : 1),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: R.color.chart_gray),
          child: Row(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: value.focusType == _SelectionState.FOCUSED &&
                        selected != TimePeriodFilter.DAILY
                    ? (context.xMediaQuery.size.width / items.length)
                    : context.WIDTH -
                        (R.sizes.screenPadding(Atom.context).right * 3),
                child: (value.focusType == _SelectionState.FOCUSED &&
                        selected != TimePeriodFilter.DAILY)
                    ? singleSelectedItem(value, context)
                    : itemList(value, hasOverflow),
              ),
              if (value.focusType == _SelectionState.FOCUSED &&
                  selected != TimePeriodFilter.DAILY)
                Expanded(
                    child: Center(
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [getRangeSelector(context)]),
                ))
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector singleSelectedItem(
      DateRangePickerVm value, BuildContext context) {
    print(selected);
    return GestureDetector(
        onTap: () {
          value.changeFocusedType();
        },
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: context.WIDTH / items.length,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: R.color.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(3, 3))
            ],
          ),
          child: AutoSizeText(
            (selected).toShortString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ));
  }

  Widget itemList(DateRangePickerVm value, hasOverflow) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: items
            .map<Widget>(
              (e) => GestureDetector(
                onTap: () {
                  if (selected != TimePeriodFilter.DAILY) {
                    value.changeFocusedType();
                  }
                  if (selected != e) {
                    setSelectedItem(e);
                  }
                },
                child: Container(
                  width: hasOverflow
                      ? null
                      : (value.context.WIDTH -
                              R.sizes.screenPadding(Atom.context).right * 2) /
                          items.length,
                  alignment: Alignment.center,
                  padding:
                      hasOverflow ? EdgeInsets.symmetric(horizontal: 10) : null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: e == selected ? R.color.white : null,
                    boxShadow: e == selected
                        ? [
                            BoxShadow(
                                color: Colors.black.withAlpha(50),
                                blurRadius: 5,
                                spreadRadius: 0,
                                offset: Offset(3, 3))
                          ]
                        : null,
                  ),
                  child: Text(
                    (e).toShortString(),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget getRangeSelector(BuildContext context) {
    if (selected == TimePeriodFilter.SPECIFIC)
      return Row(
        children: [
          GestureDetector(
            onTap: () => DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(2000, 1, 1),
                maxTime: DateTime.now(),
                onChanged: (date) {},
                onConfirm: setStartDate,
                currentTime: startDate,
                locale: LocaleType.tr),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  width: 8 * context.TEXTSCALE,
                  height: 8 * context.TEXTSCALE,
                ),
                AutoSizeText(intl.DateFormat.yMMMd(intl.Intl.getCurrentLocale())
                    .format(startDate)),
              ],
            ),
          ),
          SizedBox(
            width: context.WIDTH * .06,
          ),
          GestureDetector(
            onTap: () => DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: startDate,
                maxTime: DateTime.now(),
                onChanged: (date) {}, onConfirm: (date) {
              setEndDate(date);
            }, currentTime: endDate, locale: LocaleType.tr),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  width: 8 * context.TEXTSCALE,
                  height: 8 * context.TEXTSCALE,
                ),
                AutoSizeText(intl.DateFormat.yMMMd(intl.Intl.getCurrentLocale())
                    .format(endDate)),
              ],
            ),
          ),
        ],
      );
    else
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Icon(
              Icons.arrow_back,
              size: IconTheme.of(context).size * context.TEXTSCALE,
            ),
            onTap: previousDate,
          ),
          AutoSizeText(intl.DateFormat.yMMMd(intl.Intl.getCurrentLocale())
              .format(startDate)),
          AutoSizeText(" - "),
          AutoSizeText(intl.DateFormat.yMMMd(intl.Intl.getCurrentLocale())
              .format(endDate)),
          InkWell(
            child: Icon(
              Icons.arrow_forward,
              size: IconTheme.of(context).size * context.TEXTSCALE,
            ),
            onTap: nextDate,
          )
        ],
      );
  }
}

/* 
 if (selected != TimePeriodFilter.DAILY)
                Expanded(
                  child: Column(
                    children: [
                      Divider(
                        endIndent: 0,
                        height: 1,
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future:
                              Future.delayed(Duration(milliseconds: 300), () {
                            
                          }),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data;
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
             */