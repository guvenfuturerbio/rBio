import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/extension/size_extension.dart';

import '../core/utils/date_range_picker/date_range_picker.dart';
import '../helper/resources.dart';

class GraphHeader extends StatelessWidget {
  const GraphHeader({
    Key key,
    this.value,
    this.title,
    this.callBack,
  }) : super(key: key);
  final value;
  final String title;
  final Function() callBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: DateRangePicker(
              endDate: value.endDate,
              startDate: value.startDate,
              nextDate: value.nextDate,
              previousDate: value.previousDate,
              selected: value.selected,
              setSelectedItem: value.setSelectedItem,
              setEndDate: value.changeEndDate,
              setStartDate: value.changeStartDate,
            )
            // _dateTimePicker(context),
            ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _graph(context),
          ),
        ),
      ],
    );
  }

  Container _graph(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: R.color.chart_gray,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 5,
                spreadRadius: 0,
                offset: Offset(5, 4))
          ]),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              value.currentGraph,
              IgnorePointer(
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.slowMiddle,
                    margin: EdgeInsets.only(left: 40, top: 45),
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: SvgPicture.asset(
                      R.image.grafik_arkasi,
                      alignment: Alignment.centerRight,
                    )),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => callBack(),
            child: Icon(
              Icons.keyboard_arrow_up,
              size: 52 * context.TEXTSCALE,
            ),
          )
        ],
      ),
    );
  }

  /* Column _dateTimePicker(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: value.selected == TimePeriodFilter.DAILY
              ? context.HEIGHT * .05
              : context.HEIGHT * .1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: R.color.grey.withOpacity(.1)),
          child: Column(
            children: [
              Container(
                height: context.HEIGHT * .05,
                child: Row(
                  children: [
                    ...(value.items as List).map<Widget>((e) => Expanded(
                        child: GestureDetector(
                            onTap: () => value.setSelectedItem(e),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: e == (value.selected as TimePeriodFilter)
                                    ? R.color.white
                                    : null,
                                boxShadow: e ==
                                        (value.selected as TimePeriodFilter)
                                    ? [
                                        BoxShadow(
                                            color: Colors.black.withAlpha(50),
                                            blurRadius: 5,
                                            spreadRadius: 0,
                                            offset: Offset(3, 3))
                                      ]
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                (e as TimePeriodFilter).toShortString(),
                                textAlign: TextAlign.center,
                              ),
                            )))),
                  ],
                ),
              ),
              if (value.selected != TimePeriodFilter.DAILY)
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
                            if (value.selected == TimePeriodFilter.SPECIFIC)
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          '${LocaleProvider.current.start_time}:'),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              primary: R.color.black),
                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(2000, 1, 1),
                                                maxTime: DateTime.now(),
                                                onChanged: (date) {},
                                                onConfirm: (date) {
                                              value.setStartDate(date);
                                            },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.tr);
                                          },
                                          child: Text(DateFormat.yMMMd(
                                                  Intl.getCurrentLocale())
                                              .format(value.startDate))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          '${LocaleProvider.current.end_time}:'),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              primary: R.color.black),
                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: value.startDate,
                                                maxTime: DateTime.now(),
                                                onChanged: (date) {},
                                                onConfirm: (date) {
                                              value.setEndDate(date);
                                            },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.tr);
                                          },
                                          child: Text(DateFormat.yMMMd(
                                                  Intl.getCurrentLocale())
                                              .format(value.endDate))),
                                    ],
                                  ),
                                ],
                              );
                            else
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                              );
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
            ],
          ),
        ),
      ],
    );
  }
   */ /* Row _dateTimePicker(BuildContext context) {
    return Row(
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
  } */

}
