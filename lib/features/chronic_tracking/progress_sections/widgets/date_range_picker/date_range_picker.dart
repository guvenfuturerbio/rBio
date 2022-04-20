import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../../core/core.dart';
import 'package:provider/provider.dart';

part 'date_range_picker_vm.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker(
      {Key? key,
      required this.selected,
      required this.setSelectedItem,
      required this.setStartDate,
      required this.setEndDate,
      required this.endDate,
      required this.startDate,
      required this.nextDate,
      required this.previousDate,
      this.height})
      : super(key: key);
  final TimePeriodFilter selected;

  final DateTime startDate;
  final DateTime endDate;

  final Function(TimePeriodFilter) setSelectedItem;

  final Function(DateTime) setStartDate;
  final Function(DateTime) setEndDate;

  final double? height;

  final Function() nextDate;
  final Function() previousDate;

  List<TimePeriodFilter> get items => [
        TimePeriodFilter.daily,
        TimePeriodFilter.weekly,
        TimePeriodFilter.monthly,
        TimePeriodFilter.monthlyThree,
        TimePeriodFilter.spesific
      ];

  @override
  Widget build(BuildContext context) {
    bool hasOverflow = false;

    for (var i = 0; i < items.length; i++) {
      if (hasOverflow) {
        break;
      } else {
        var _current = Locale(intl.Intl.getCurrentLocale());
        bool _isRtl =
            _current == const Locale('ar') || _current == const Locale('fa');
        final span = TextSpan(text: (items[i]).toShortString());
        final painter = TextPainter(
            text: span,
            maxLines: 1,
            textDirection: _isRtl ? TextDirection.rtl : TextDirection.ltr,
            textScaleFactor: context.textScale);

        painter.layout();

        hasOverflow = painter.size.width >= (context.width - 16) / items.length;
      }
    }

    return ChangeNotifierProvider(
      create: (_) =>
          DateRangePickerVm(context: context, items: items, selected: selected),
      child: Consumer<DateRangePickerVm>(
        builder: (_, value, __) => LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: height ??
                  (context.height * .05) *
                      (context.textScale > 1 ? (context.textScale / 2) : 1),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: getIt<IAppConfig>().theme.chartGray,
              ),
              child: Row(
                children: [
                  //
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: value.focusType == _SelectionState.focused &&
                            selected != TimePeriodFilter.daily
                        ? (context.xMediaQuery.size.width / items.length)
                        : constraints.maxWidth,
                    child: (value.focusType == _SelectionState.focused &&
                            selected != TimePeriodFilter.daily)
                        ? singleSelectedItem(context, value)
                        : itemList(value, hasOverflow, constraints),
                  ),

                  //
                  if (value.focusType == _SelectionState.focused &&
                      selected != TimePeriodFilter.daily)
                    Expanded(
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            getRangeSelector(context),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget singleSelectedItem(
    BuildContext context,
    DateRangePickerVm value,
  ) {
    return GestureDetector(
      onTap: () {
        value.changeFocusedType();
      },
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: context.width / items.length,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getIt<IAppConfig>().theme.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 5,
              spreadRadius: 0,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: AutoSizeText(
          (selected).toShortString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget itemList(
    DateRangePickerVm value,
    bool hasOverflow,
    BoxConstraints constraints,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: items
            .map<Widget>(
              (e) => GestureDetector(
                onTap: () {
                  if (selected != TimePeriodFilter.daily) {
                    value.changeFocusedType();
                  }
                  if (selected != e) {
                    setSelectedItem(e);
                  }
                },
                child: Container(
                  width:
                      hasOverflow ? null : constraints.maxWidth / items.length,
                  alignment: Alignment.center,
                  padding: hasOverflow
                      ? const EdgeInsets.symmetric(horizontal: 10)
                      : null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: e == selected ? getIt<IAppConfig>().theme.white : null,
                    boxShadow: e == selected
                        ? [
                            BoxShadow(
                              color: Colors.black.withAlpha(50),
                              blurRadius: 5,
                              spreadRadius: 0,
                              offset: const Offset(3, 3),
                            ),
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
    if (selected == TimePeriodFilter.spesific) {
      return Row(
        children: [
          //
          GestureDetector(
            onTap: () => DatePicker.showDatePicker(
              context,
              showTitleActions: true,
              minTime: DateTime(2000, 1, 1),
              maxTime: DateTime.now(),
              onChanged: (date) {},
              onConfirm: setStartDate,
              currentTime: startDate,
              locale: LocaleType.tr,
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  width: 8 * context.textScale,
                  height: 8 * context.textScale,
                ),
                AutoSizeText(intl.DateFormat.yMMMd(intl.Intl.getCurrentLocale())
                    .format(startDate)),
              ],
            ),
          ),

          //
          SizedBox(
            width: context.width * .06,
          ),

          //
          GestureDetector(
            onTap: () => DatePicker.showDatePicker(
              context,
              showTitleActions: true,
              minTime: startDate,
              maxTime: DateTime.now(),
              onChanged: (date) {},
              onConfirm: (date) {
                setEndDate(date);
              },
              currentTime: endDate,
              locale: LocaleType.tr,
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  width: 8 * context.textScale,
                  height: 8 * context.textScale,
                ),
                AutoSizeText(intl.DateFormat.yMMMd(
                  intl.Intl.getCurrentLocale(),
                ).format(endDate)),
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //
          InkWell(
            child: Icon(
              Icons.arrow_back,
              size: IconTheme.of(context).size! * context.textScale,
            ),
            onTap: previousDate,
          ),

          //
          AutoSizeText(intl.DateFormat.yMMMd(intl.Intl.getCurrentLocale())
              .format(startDate)),

          //
          const AutoSizeText(" - "),

          //
          AutoSizeText(intl.DateFormat.yMMMd(intl.Intl.getCurrentLocale())
              .format(endDate)),

          //
          InkWell(
            child: Icon(
              Icons.arrow_forward,
              size: IconTheme.of(context).size! * context.textScale,
            ),
            onTap: nextDate,
          ),
        ],
      );
    }
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