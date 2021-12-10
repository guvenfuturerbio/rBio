import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../utils/hypo_hyper_edit/hypo_hyper_edit_view_model.dart';
import '../../utils/widgets.dart';
import 'doctor_appointment_vm.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({Key key}) : super(key: key);

  @override
  _DoctorAppointmentScreenState createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  var formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DoctorAppointmentVm>(
      create: (context) => DoctorAppointmentVm(context: context),
      child: Consumer<DoctorAppointmentVm>(
        builder: (
          BuildContext context,
          DoctorAppointmentVm value,
          Widget child,
        ) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                //
                Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: tableCalendar(
                        context: context,
                        events: value.calendarEvents,
                        appointmentList: value.yearlyAppointments,
                        onVisibleDayChanged: (first, last, format) {
                          value.setYearlyAppointments(
                            AppointmentFilter(
                              type: "c",
                              start: formatter.format(first),
                              end: formatter.format(last),
                            ),
                          );
                        },
                        onPressed: (pressedDay) {
                          value.setDailyAppointments(
                            AppointmentFilter(
                              type: "d",
                              end: formatter.format(pressedDay),
                              start: formatter.format(pressedDay),
                            ),
                          );
                        },
                      ),
                    ),

                    //
                    value.stateProcess == StateProcess.DONE
                        ? (value.dailyAppointments.length > 0
                            ? _buildPosts(context, value.dailyAppointments)
                            : Text(
                                LocaleProvider.current.no_appointment,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                              ))
                        : value.stateProcess == StateProcess.ERROR
                            ? Text(
                                LocaleProvider.current.sorry_dont_transaction,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                              )
                            : Container(
                                constraints: BoxConstraints(maxWidth: 800),
                                child: Center(
                                  child: linearProgress(
                                    backgroundColor: R.color.mainColor,
                                  ),
                                ),
                              ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
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

  Widget _buildPosts(BuildContext context, List<Appointment> appointments) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      physics: NeverScrollableScrollPhysics(),
      itemCount: appointments.length,
      itemBuilder: (BuildContext context, int index) {
        return Consumer<DoctorAppointmentVm>(
          builder: (
            BuildContext context,
            DoctorAppointmentVm value,
            Widget child,
          ) {
            return appointmentInfo(
              context: context,
              appointment: appointments[index],
              startAppointment: (webConsultantAppId) {
                value.startAppointments(webConsultantAppId.toString());
              },
            );
          },
        );
      },
    );
  }
}

GradientButton button({
  text: String,
  Function onPressed,
  double height,
  double width,
}) =>
    GradientButton(
      increaseHeightBy: height ?? 16,
      increaseWidthBy: width ?? 200,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      callback: onPressed,
      gradient: LinearGradient(
        colors: [
          R.color.mainColor,
          R.color.mainColor,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.centerRight,
      ),
      shadowColor: Colors.black,
    );

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
                              appointment
                                      ?.patient?.user?.identificationNumber ??
                                  "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
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
      gradient: LinearGradient(
        colors: [
          Colors.white,
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.topRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(50),
          blurRadius: 15,
          spreadRadius: 0,
          offset: Offset(5, 10),
        ),
      ],
    ),
  );
}
