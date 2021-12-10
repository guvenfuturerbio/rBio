import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../model/model.dart';
import '../../resources/resources.dart';
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
