import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../../generated/l10n.dart';
import '../../../model/model.dart';
import '../resources/resources.dart';
import '../services/measurement_service.dart';

double tabTextSize = 16;
double mainAppBarTextSize = 18;

Widget mainAppBar(
        {BuildContext context,
        Widget leading,
        Widget title,
        List<Widget> actions,
        Widget bottom}) =>
    PreferredSize(
        child: Container(
          //padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Center(
            child: Stack(
              children: <Widget>[
                Center(
                  child: SvgPicture.asset(
                    R.image.appbar,
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  child: leading == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top),
                          child: leading,
                        ),
                  left: 16,
                  top: (MediaQuery.of(context).size.height * 0.025),
                ),
                Center(
                    child: title == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: (MediaQuery.of(context).size.height *
                                        0.15) /
                                    2,
                                top: MediaQuery.of(context).padding.top),
                            child: title,
                          )),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 0, top: MediaQuery.of(context).padding.top),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions == null ? [] : actions,
                    ),
                  ),
                  right: 8,
                  top: (MediaQuery.of(context).size.height * 0.025),
                ),
              ],
            ),
          ),
          /*decoration: BoxDecoration(
              gradient: appBarGradient()),*/
        ),
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.15));

Widget titleAppBarWhite({String title, TextOverflow flow}) => Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Text(
        title,
        overflow: flow,
        style: TextStyle(
            fontSize: mainAppBarTextSize,
            color: Colors.white,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );

Widget tabButton({BuildContext context, String text, bool isSelected}) =>
    Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.05,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: tabTextSize,
            color: isSelected ? R.color.white : R.color.mainColor),
      ),
      decoration: isSelected ? activeDecoration() : decoration(),
    );

BoxDecoration activeDecoration() {
  return BoxDecoration(
    color: R.color.regularBlue,
    gradient: LinearGradient(
        colors: [R.color.mainColor, R.color.mainColor],
        begin: Alignment.bottomLeft,
        end: Alignment.centerRight),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withAlpha(50),
          blurRadius: 15,
          spreadRadius: 0,
          offset: Offset(5, 10))
    ],
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  );
}

BoxDecoration decoration() {
  return BoxDecoration(
    color: R.color.regularBlue,
    gradient: LinearGradient(
        colors: [Colors.white, Colors.white],
        begin: Alignment.bottomLeft,
        end: Alignment.centerRight),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withAlpha(50),
          blurRadius: 15,
          spreadRadius: 0,
          offset: Offset(5, 10))
    ],
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  );
}

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

Widget appointmentInfo(
    {BuildContext context,
    Appointment appointment,
    Function startAppointment}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 20),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                //width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              LocaleProvider.current.name_surname,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            LocaleProvider.current.identity_passport,
                            style:
                                TextStyle(color: R.color.title, fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              appointment?.patient?.user?.name ?? "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            appointment?.patient?.user?.identificationNumber ??
                                "-",
                            style: TextStyle(
                                color: R.color.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              LocaleProvider.current.phone_number,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            LocaleProvider.current.time,
                            style:
                                TextStyle(color: R.color.title, fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              appointment?.patient?.user?.phoneNumber ?? "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            appointment?.availability?.startTime
                                    ?.substring(0, 5) ??
                                "-",
                            style: TextStyle(
                                color: R.color.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: button(
                                text:
                                    LocaleProvider.current.files.toUpperCase(),
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.015),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                              child: button(
                                  onPressed: () {
                                    startAppointment(
                                        appointment.webConsultAppId);
                                  },
                                  text: LocaleProvider.current.start
                                      .toUpperCase(),
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height: MediaQuery.of(context).size.height *
                                      0.015))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.navigate_next)
      ],
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white,
        ], begin: Alignment.topLeft, end: Alignment.topRight),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(5, 10))
        ]),
  );
}

Widget patientInfo({
  BuildContext context,
  DoctorPatientModel patient,
  Function onPressed,
}) {
  return InkWell(
    onTap: () {
      onPressed(patient.id);
    },
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        LocaleProvider.current.name_surname,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: R.color.title,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        LocaleProvider.current.diabet_type,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: R.color.title,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        patient?.name ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: R.color.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        patient?.diabetType?.name ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: R.color.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            LocaleProvider.current.last_bg,
                            style: TextStyle(
                                color: R.color.text,
                                fontWeight: FontWeight.w600),
                          ),
                          measurementBox(context: context, patient: patient)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            LocaleProvider.current.hypo,
                            style: TextStyle(
                                color: R.color.text,
                                fontWeight: FontWeight.w600),
                          ),
                          hypo(context: context, patient: patient)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            LocaleProvider.current.hyper,
                            style: TextStyle(
                                color: R.color.text,
                                fontWeight: FontWeight.w600),
                          ),
                          hyper(context: context, patient: patient)
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    hungaryState(
                        context: context,
                        image: R.image.beforeMeal,
                        count: patient?.type1Count ?? 0),
                    hungaryState(
                        context: context,
                        image: R.image.afterMeal,
                        count: patient?.type2Count ?? 0),
                    hungaryState(
                        context: context,
                        image: R.image.other,
                        count: patient?.type3Count ?? 0),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                )
              ],
            ),
          ),
          Icon(Icons.navigate_next)
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(colors: [
            Colors.white,
            Colors.white,
          ], begin: Alignment.topLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(5, 10))
          ]),
    ),
  );
}

Widget hungaryState({BuildContext context, String image, int count}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SvgPicture.asset(image,
          width: MediaQuery.of(context).size.width * 0.05,
          height: MediaQuery.of(context).size.width * 0.05),
      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
      Text(count?.toString() ?? "", style: TextStyle(color: R.color.text))
    ],
  );
}

Widget hypo({
  BuildContext context,
  int width,
  int height,
  DoctorPatientModel patient,
}) {
  return Container(
    alignment: Alignment.center,
    width: width ?? MediaQuery.of(context).size.width * 0.15,
    height: height ?? MediaQuery.of(context).size.width * 0.15,
    child: Text(
      (((patient?.hypo ?? "-") == "-" || (patient?.hypo ?? "") == "")
              ? "-"
              : patient.hypo) +
          "\nmg/dL",
      style: TextStyle(color: R.color.text, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16)),
        gradient: LinearGradient(colors: [
          ((patient?.hypo ?? "-") == "-" || (patient?.hypo ?? "") == "")
              ? Colors.white
              : MeasurementService().fetchMeasurementColor(
                  measurement: toIntFunc(patient?.hypo ?? ""),
                  criticMin: patient?.alertMin ?? 0,
                  criticMax: patient?.alertMax ?? 0,
                  targetMax: patient?.normalMax ?? 0,
                  targetMin: patient?.normalMin ?? 0),
          ((patient?.hypo ?? "-") == "-" || (patient?.hypo ?? "") == "")
              ? Colors.white
              : MeasurementService().fetchMeasurementColor(
                  measurement: toIntFunc(patient?.hypo ?? ""),
                  criticMin: patient?.alertMin ?? 0,
                  criticMax: patient?.alertMax ?? 0,
                  targetMax: patient?.normalMax ?? 0,
                  targetMin: patient?.normalMin ?? 0),
        ], begin: Alignment.topLeft, end: Alignment.topRight),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(5, 10))
        ]),
  );
}

toIntFunc(String text) {
  if (text == null) {
    return 0;
  } else if (text.length > 0) {
    return int.parse(text);
  } else {
    return 0;
  }
}

Widget hyper({
  BuildContext context,
  int width,
  int height,
  DoctorPatientModel patient,
}) {
  return Container(
    alignment: Alignment.center,
    width: width ?? MediaQuery.of(context).size.width * 0.15,
    height: height ?? MediaQuery.of(context).size.width * 0.15,
    child: Text(
      (((patient?.hyper ?? "-") == "-" || (patient?.hyper ?? "") == "")
              ? "-"
              : patient.hyper) +
          "\nmg/dL",
      style: TextStyle(color: R.color.text, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16)),
        gradient: LinearGradient(colors: [
          ((patient?.hyper ?? "-") == "-" || (patient?.hyper ?? "") == "")
              ? Colors.white
              : MeasurementService().fetchMeasurementColor(
                  measurement: toIntFunc(patient?.hyper ?? ""),
                  criticMin: patient?.alertMin ?? 0,
                  criticMax: patient?.alertMax ?? 0,
                  targetMax: patient?.normalMax ?? 0,
                  targetMin: patient?.normalMin ?? 0),
          ((patient?.hyper ?? "-") == "-" || (patient?.hyper ?? "") == "")
              ? Colors.white
              : MeasurementService().fetchMeasurementColor(
                  measurement: toIntFunc(patient?.hyper ?? ""),
                  criticMin: patient?.alertMin ?? 0,
                  criticMax: patient?.alertMax ?? 0,
                  targetMax: patient?.normalMax ?? 0,
                  targetMin: patient?.normalMin ?? 0),
        ], begin: Alignment.topLeft, end: Alignment.topRight),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(5, 10))
        ]),
  );
}

Widget measurementBox({
  BuildContext context,
  int width,
  int height,
  DoctorPatientModel patient,
}) {
  return Container(
    alignment: Alignment.center,
    width: width ?? MediaQuery.of(context).size.width * 0.15,
    height: height ?? MediaQuery.of(context).size.width * 0.15,
    child: Text(
      (((patient?.lastBg ?? "-") == "-" || (patient?.lastBg ?? "") == "")
              ? "-"
              : patient.lastBg) +
          "\nmg/dL",
      style: TextStyle(color: R.color.text, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(colors: [
          ((patient?.lastBg ?? "-") == "-" || (patient?.lastBg ?? "") == "")
              ? Colors.white
              : MeasurementService().fetchMeasurementColor(
                  measurement: toIntFunc(patient?.lastBg ?? ""),
                  criticMin: patient?.alertMin ?? 0,
                  criticMax: patient?.alertMax ?? 0,
                  targetMax: patient?.normalMax ?? 0,
                  targetMin: patient?.normalMin ?? 0),
          ((patient?.lastBg ?? "-") == "-" || (patient?.lastBg ?? "") == "")
              ? Colors.white
              : MeasurementService().fetchMeasurementColor(
                  measurement: toIntFunc(patient?.lastBg ?? ""),
                  criticMin: patient?.alertMin ?? 0,
                  criticMax: patient?.alertMax ?? 0,
                  targetMax: patient?.normalMax ?? 0,
                  targetMin: patient?.normalMin ?? 0),
        ], begin: Alignment.topLeft, end: Alignment.topRight),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(5, 10))
        ]),
  );
}

/// MG20
Widget patientDetail({
  BuildContext context,
  DoctorPatientDetailModel patientDetail,

  /// MG8
  /// MG18
  Function targetRangePresses,
  Function hypoEdit,
  Function hyperEdit,
}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 20),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                //width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              LocaleProvider.current.name_surname,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            LocaleProvider.current.date_of_birth,
                            style:
                                TextStyle(color: R.color.title, fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              patientDetail?.name ?? "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            patientDetail?.birthDay ?? "-",
                            style: TextStyle(
                                color: R.color.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              LocaleProvider.current.identity_passport,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            LocaleProvider.current.height,
                            style:
                                TextStyle(color: R.color.title, fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            patientDetail?.height ?? "-",
                            style: TextStyle(
                                color: R.color.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              LocaleProvider.current.diabet_type,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            LocaleProvider.current.weight,
                            style:
                                TextStyle(color: R.color.title, fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              patientDetail?.diabetType?.name ?? "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            patientDetail?.weight ?? "-",
                            style: TextStyle(
                                color: R.color.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  LocaleProvider.current.normal_range,
                                  style: TextStyle(
                                      color: R.color.title, fontSize: 16),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () {
                                    targetRangePresses();
                                  },
                                  child: SvgPicture.asset(
                                    R.image.other,
                                    color: R.color.mainColor,
                                    width: 20,
                                    height: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Text(
                            LocaleProvider.current.last_hba1c,
                            style:
                                TextStyle(color: R.color.title, fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              (patientDetail?.rangeMin ?? "").toString() +
                                  "-" +
                                  (patientDetail?.rangeMax ?? "").toString() +
                                  (" mg/dL"),
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            "-",
                            style: TextStyle(
                                color: R.color.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  LocaleProvider.current.hypo,
                                  style: TextStyle(
                                      color: R.color.title, fontSize: 16),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () {
                                    hypoEdit();
                                  },
                                  child: SvgPicture.asset(
                                    R.image.other,
                                    color: R.color.mainColor,
                                    width: 20,
                                    height: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Text(
                            LocaleProvider.current.year_of_diagnosis,
                            style:
                                TextStyle(color: R.color.title, fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              (patientDetail?.hypo ?? "-").toString() +
                                  " mg/dL",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            (patientDetail?.yearOfDiagnosis ?? "-").toString(),
                            style: TextStyle(
                                color: R.color.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  LocaleProvider.current.hyper,
                                  style: TextStyle(
                                      color: R.color.title, fontSize: 16),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () {
                                    hyperEdit();
                                  },
                                  child: SvgPicture.asset(
                                    R.image.other,
                                    color: R.color.mainColor,
                                    width: 20,
                                    height: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Text(
                            LocaleProvider.current.smoking,
                            style:
                                TextStyle(color: R.color.title, fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              (patientDetail?.hyper ?? "-").toString() +
                                  " mg/dL",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            patientDetail?.smoker != null
                                ? patientDetail.smoker
                                    ? LocaleProvider.current.yes
                                    : LocaleProvider.current.no
                                : "-",
                            style: TextStyle(
                                color: R.color.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              LocaleProvider.current.medicines,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            LocaleProvider.current.strip_number,
                            style:
                                TextStyle(color: R.color.title, fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            (patientDetail?.stripCount ?? "-").toString(),
                            style: TextStyle(
                                color: R.color.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white,
        ], begin: Alignment.topLeft, end: Alignment.topRight),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(5, 10))
        ]),
  );
}

GradientButton button(
        {text: String, Function onPressed, double height, double width}) =>
    GradientButton(
      increaseHeightBy: height ?? 16,
      increaseWidthBy: width ?? 200,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      callback: onPressed,
      gradient: BlueGradient(),
      shadowColor: Colors.black,
    );

Gradient BlueGradient() => LinearGradient(
    colors: [R.color.mainColor, R.color.mainColor],
    begin: Alignment.bottomLeft,
    end: Alignment.centerRight);

TextStyle inputTextStyle() => TextStyle(fontSize: 16, color: R.color.text);

InputDecoration inputImageDecoration({image: String, hintText: String}) =>
    InputDecoration(
        contentPadding: EdgeInsets.all(0),
        prefixIcon: SvgPicture.asset(
          image,
          fit: BoxFit.none,
          color: R.color.text,
        ),
        focusedBorder: _borderTextField(),
        border: _borderTextField(),
        enabledBorder: _borderTextField(),
        hintText: hintText,
        hoverColor: R.color.mainColor,
        focusColor: R.color.mainColor,
        fillColor: Colors.white,
        hintStyle: hintStyle());

InputBorder _borderTextField() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(200),
      borderSide:
          BorderSide(width: 0, style: BorderStyle.solid, color: R.color.text),
    );

TextStyle hintStyle() => TextStyle(fontSize: 16, color: R.color.title);

BoxDecoration inputBoxDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(200)),
      gradient: LinearGradient(colors: [
        Colors.white,
        Colors.white,
      ], begin: Alignment.topLeft, end: Alignment.topRight),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 15,
            spreadRadius: 0,
            offset: Offset(5, 10))
      ]);
}

Widget progress({
  Key key,
  double value,
  Color backgroundColor,
  Animation valueColor,
  String semanticsLabel,
  String semanticsValue,
}) =>
    ShakeAnimatedWidget(
      enabled: true,
      duration: Duration(milliseconds: 1500),
      shakeAngle: Rotation.deg(z: 10),
      curve: Curves.linear,
      child: Container(
        width: 80,
        height: 80,
        child: SvgPicture.asset(R.image.stethoscope),
      ),
    );

Widget progressState({
  Key key,
  double value,
  String image,
  Color backgroundColor,
  Animation valueColor,
  String semanticsLabel,
  String semanticsValue,
}) =>
    ShakeAnimatedWidget(
      enabled: true,
      duration: Duration(milliseconds: 1500),
      shakeAngle: Rotation.deg(z: 10),
      curve: Curves.linear,
      child: Container(
        width: 80,
        height: 80,
        child: SvgPicture.asset(image),
      ),
    );

Widget buildMarker(
    {List<Appointment> appointments, DateTime date, BuildContext context}) {
  int count = 0;
  for (var data in appointments) {
    if (date == DateTime.parse(data.availability.dateTime.substring(0, 10))) {
      count++;
    }
  }
  return count > 0
      ? AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: R.color.mainColor),
          width: MediaQuery.of(context).size.width * 0.043,
          height: MediaQuery.of(context).size.width * 0.043,
          constraints:
              BoxConstraints(maxWidth: 800 * 0.043, maxHeight: 800 * 0.043),
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                '${count}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      : AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          width: MediaQuery.of(context).size.width * 0.043,
          height: MediaQuery.of(context).size.width * 0.043,
          constraints:
              BoxConstraints(maxWidth: 800 * 0.043, maxHeight: 800 * 0.043),
          child: Center(),
        );
}

LinearProgressIndicator linearProgress({
  Key key,
  double value,
  Color backgroundColor,
  Animation valueColor,
  String semanticsLabel,
  String semanticsValue,
}) =>
    LinearProgressIndicator(
      backgroundColor: backgroundColor,
    );
