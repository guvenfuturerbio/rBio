import 'package:flutter/material.dart';

import '../../../model/model.dart';

double tabTextSize = 16;
double mainAppBarTextSize = 18;

Widget titleAppBarWhite({
  String title,
  TextOverflow flow,
}) =>
    Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Text(
        title,
        overflow: flow,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: mainAppBarTextSize,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

Widget tableCalendar({
  Map<DateTime, List> events,
  BuildContext context,
  Function onPressed,
  List<Appointment> appointmentList,
  Function onVisibleDayChanged,
  // CalendarController calendarController
}) {
  return Container(color: Colors.red);

  // return TableCalendar(
  //   initialCalendarFormat: CalendarFormat.twoWeeks,
  //   events: events,
  //   onVisibleDaysChanged: onVisibleDayChanged,
  //   calendarStyle: CalendarStyle(
  //       contentPadding: EdgeInsets.only(top: 8),
  //       holidayStyle: TextStyle(color: Colors.white),
  //       todayColor: Colors.transparent,
  //       weekendStyle: TextStyle(color: R.color.black),
  //       selectedColor: Color(0xFF66c791),
  //       todayStyle: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 18.0,
  //           color: R.color.regularBlue)),
  //   headerStyle: HeaderStyle(
  //       rightChevronIcon: new Icon(Icons.chevron_right, color: R.color.white),
  //       leftChevronIcon: new Icon(Icons.chevron_left, color: R.color.white),
  //       titleTextStyle: TextStyle(color: R.color.white),
  //       centerHeaderTitle: true,
  //       formatButtonDecoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(20.0),
  //       ),
  //       formatButtonTextStyle: TextStyle(color: R.color.mainColor),
  //       formatButtonShowsNext: false,
  //       decoration: BoxDecoration(
  //           color: R.color.mainColor,
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(12), topRight: Radius.circular(12)))),
  //   startingDayOfWeek: StartingDayOfWeek.monday,
  //   daysOfWeekStyle: DaysOfWeekStyle(
  //       weekdayStyle: TextStyle(color: R.color.regularBlue),
  //       weekendStyle: TextStyle(color: R.color.regularBlue)),
  //   onDaySelected: (date, events, holidays) {
  //     onPressed(date);
  //   },
  //   calendarController: calendarController,
  //   availableCalendarFormats: {
  //     CalendarFormat.month: LocaleProvider.current.month,
  //     CalendarFormat.twoWeeks: LocaleProvider.current.two_week,
  //     CalendarFormat.week: LocaleProvider.current.week,
  //   },
  //   builders: CalendarBuilders(
  //     markersBuilder: (context, date, events, holidays) {
  //       final children = <Widget>[];
  //       if (events.isNotEmpty) {
  //         children.add(Positioned(
  //           top: 0,
  //           child: Container(
  //             margin: EdgeInsets.all(15),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   child: buildMarker(
  //                       appointments: appointmentList,
  //                       context: context,
  //                       date: date),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ));
  //       }
  //       return children;
  //     },
  //     dayBuilder: (context, date, events) => Container(
  //         margin: const EdgeInsets.all(4.0),
  //         alignment: Alignment.bottomCenter,
  //         decoration: BoxDecoration(
  //             border: Border.all(color: R.color.regularBlue),
  //             borderRadius: BorderRadius.circular(
  //                 MediaQuery.of(context).size.width > 800
  //                     ? 16
  //                     : MediaQuery.of(context).size.width * 0.018)),
  //         child: Text(
  //           date.day.toString(),
  //           style: TextStyle(
  //               color: Colors.black,
  //               fontSize: MediaQuery.of(context).size.width * 0.04),
  //         )),
  //     selectedDayBuilder: (context, date, events) => Container(
  //         margin: const EdgeInsets.all(4.0),
  //         alignment: Alignment.bottomCenter,
  //         decoration: BoxDecoration(
  //             color: R.color.regularBlue,
  //             borderRadius: BorderRadius.circular(
  //                 MediaQuery.of(context).size.width > 800
  //                     ? 16
  //                     : MediaQuery.of(context).size.width * 0.018)),
  //         child: Text(
  //           date.day.toString(),
  //           style: TextStyle(
  //               color: Colors.white,
  //               fontSize: MediaQuery.of(context).size.width * 0.04),
  //         )),
  //     todayDayBuilder: (context, date, events) => Container(
  //         margin: const EdgeInsets.all(4.0),
  //         alignment: Alignment.bottomCenter,
  //         decoration: BoxDecoration(
  //             color: Colors.transparent,
  //             borderRadius: BorderRadius.circular(10.0)),
  //         child: Text(
  //           date.day.toString(),
  //           style: TextStyle(
  //               color: R.color.regularBlue,
  //               fontSize: MediaQuery.of(context).size.width * 0.04),
  //         )),
  //   ),
  // );

  // --------

  // return TableCalendar(
  //   initialCalendarFormat: CalendarFormat.twoWeeks,
  //   events: events,
  //   calendarStyle: CalendarStyle(
  //       contentPadding: EdgeInsets.only(top: 8),
  //       holidayStyle: TextStyle(color: Colors.white),
  //       todayColor: Colors.transparent,
  //       weekendStyle: TextStyle(
  //           color: R.color.text,
  //           fontSize: MediaQuery.of(context).size.width * 0.04),
  //       selectedColor: Theme.of(context).primaryColor,
  //       weekdayStyle:
  //           TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
  //       todayStyle:
  //           TextStyle(fontWeight: FontWeight.bold, color: R.color.regularBlue)),
  //   headerStyle: HeaderStyle(
  //     rightChevronIcon: new Icon(Icons.chevron_right, color: R.color.white),
  //     leftChevronIcon: new Icon(Icons.chevron_left, color: R.color.white),
  //     titleTextStyle: TextStyle(color: R.color.white),
  //     centerHeaderTitle: true,
  //     formatButtonDecoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20.0),
  //     ),
  //     formatButtonTextStyle: TextStyle(color: R.color.regularBlue),
  //     formatButtonShowsNext: false,
  //   ),
  //   startingDayOfWeek: StartingDayOfWeek.monday,
  //   daysOfWeekStyle: DaysOfWeekStyle(
  //       weekdayStyle: TextStyle(color: R.color.white),
  //       weekendStyle: TextStyle(color: R.color.white)),
  //   onDaySelected: (date, events, holiday) {
  //     onPressed(date);
  //   },
  //   builders: CalendarBuilders(
  //     markersBuilder: (context, date, events, holidays) {
  //       final children = <Widget>[];
  //       if (events.isNotEmpty) {
  //         children.add(Positioned(
  //           top: 0,
  //           child: Container(
  //             margin: EdgeInsets.all(4.5),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   child: buildMarker(
  //                       appointments: appointmentList,
  //                       context: context,
  //                       date: date),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ));
  //       }
  //       return children;
  //     },
  //     dayBuilder: (context, date, events) => Container(
  //         margin: const EdgeInsets.all(4.0),
  //         alignment: Alignment.bottomCenter,
  //         decoration: BoxDecoration(
  //             border: Border.all(color: R.color.regularBlue),
  //             borderRadius: BorderRadius.circular(
  //                 MediaQuery.of(context).size.width > 800
  //                     ? 16
  //                     : MediaQuery.of(context).size.width * 0.018)),
  //         child: Text(
  //           date.day.toString(),
  //           style: TextStyle(
  //               color: Colors.black,
  //               fontSize: MediaQuery.of(context).size.width * 0.04),
  //         )),
  //     selectedDayBuilder: (context, date, events) => Container(
  //         margin: const EdgeInsets.all(4.0),
  //         alignment: Alignment.bottomCenter,
  //         decoration: BoxDecoration(
  //             color: R.color.regularBlue,
  //             borderRadius: BorderRadius.circular(
  //                 MediaQuery.of(context).size.width > 800
  //                     ? 16
  //                     : MediaQuery.of(context).size.width * 0.018)),
  //         child: Text(
  //           date.day.toString(),
  //           style: TextStyle(
  //               color: Colors.white,
  //               fontSize: MediaQuery.of(context).size.width * 0.04),
  //         )),
  //     todayDayBuilder: (context, date, events) => Container(
  //         margin: const EdgeInsets.all(4.0),
  //         alignment: Alignment.bottomCenter,
  //         decoration: BoxDecoration(
  //             color: Colors.transparent,
  //             borderRadius: BorderRadius.circular(10.0)),
  //         child: Text(
  //           date.day.toString(),
  //           style: TextStyle(
  //               color: R.color.regularBlue,
  //               fontSize: MediaQuery.of(context).size.width * 0.04),
  //         )),
  //   ),
  //   calendarController: calendarController,
  //   onVisibleDaysChanged: (first, last, format) {
  //     onVisibleDayChanged(first, last, format);
  //   },
  //   availableCalendarFormats: {
  //     CalendarFormat.month: LocaleProvider.current.month,
  //     CalendarFormat.twoWeeks: LocaleProvider.current.two_Week,
  //     CalendarFormat.week: LocaleProvider.current.week,
  //   },
  // );
}
