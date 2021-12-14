import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/model/doctor/appointment/appointment_model.dart';
import 'package:onedosehealth/model/doctor/doctor_patient_detail_model.dart';

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
