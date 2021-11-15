import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../core/utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../core/utils/date_range_picker/date_range_picker.dart';
import '../extension/size_extension.dart';
import '../helper/resources.dart';
import 'utils/time_period_filters.dart';

class LandScapeGraphWidget extends StatelessWidget {
  const LandScapeGraphWidget({
    Key key,
    this.graph,
    this.filterAction,
    this.changeGraphAction,
    this.value,
  }) : super(key: key);
  final value;
  final Widget graph;
  final Function() filterAction;
  final Function() changeGraphAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: DateRangePicker(
              height: (context.WIDTH * .039) * context.TEXTSCALE,
              endDate: value.endDate,
              startDate: value.startDate,
              nextDate: value.nextDate,
              previousDate: value.previousDate,
              selected: value.selected,
              setSelectedItem: value.setSelectedItem,
              setEndDate: value.changeEndDate,
              setStartDate: value.changeStartDate,
            )),
        Flexible(
          flex: 6,
          child: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: R.color.chart_gray,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: Offset(5, 5))
                ]),
            child: Stack(
              children: [
                graph,
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(left: 40, top: 45),
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: SvgPicture.asset(
                        R.image.grafik_arkasi,
                      )),
                ),
              ],
            ),
          ),
        ),
        BottomActionsOfGraph(
          value: value,
        ),
      ],
    );
  }

  Row _dateTimePicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<TimePeriodFilter>(
          value: value.selected,
          icon: Icon(
            Icons.arrow_downward,
            color: R.color.black,
          ),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 2,
            color: R.color.black,
          ),
          onChanged: (TimePeriodFilter newValue) {
            value.setSelectedItem(newValue);
          },
          items: value.items.map<DropdownMenuItem<TimePeriodFilter>>(
              (TimePeriodFilter value) {
            return DropdownMenuItem<TimePeriodFilter>(
              value: value,
              child: Text(
                value.toShortString(),
              ),
            );
          }).toList(),
        ),
        value.selected == TimePeriodFilter.SPECIFIC
            ? Row(
                children: [
                  FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2000, 1, 1),
                            maxTime: DateTime.now(),
                            onChanged: (date) {}, onConfirm: (date) {
                          value.setStartDate(date);
                        }, currentTime: DateTime.now(), locale: LocaleType.tr);
                      },
                      child: Text(DateFormat.yMMMd(Intl.getCurrentLocale())
                          .format(value.startDate))),
                  FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: value.startDate,
                            maxTime: DateTime.now(),
                            onChanged: (date) {}, onConfirm: (date) {
                          value.setEndDate(date);
                        }, currentTime: DateTime.now(), locale: LocaleType.tr);
                      },
                      child: Text(DateFormat.yMMMd(Intl.getCurrentLocale())
                          .format(value.endDate))),
                ],
              )
            : value.selected != TimePeriodFilter.DAILY
                ? Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(Icons.arrow_back),
                          onTap: () {
                            value.previousDate();
                          },
                        ),
                        Text(DateFormat.yMMMd(Intl.getCurrentLocale())
                            .format(value.startDate)),
                        Text(" - "),
                        Text(DateFormat.yMMMd(Intl.getCurrentLocale())
                            .format(value.endDate)),
                        InkWell(
                          child: Icon(Icons.arrow_forward),
                          onTap: () {
                            value.nextDate();
                          },
                        )
                      ],
                    ),
                  )
                : Container(),
      ],
    );
  }
}
