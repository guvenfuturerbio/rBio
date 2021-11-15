import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/doctor/models/appointment.dart';
import 'package:onedosehealth/doctor/models/appointment_filter.dart';
import 'package:onedosehealth/doctor/pages/appointment_page/appointment_page_view_model.dart';
import 'package:onedosehealth/doctor/pages/patients_page/patient_page_view_model.dart';
import 'package:onedosehealth/doctor/resources/resources.dart';
import 'package:onedosehealth/doctor/utils/widgets.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

/// MG10
class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  var formatter = new DateFormat('yyyy-MM-dd');
  CalendarController _calendarController = CalendarController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppointmentPageViewModel(context: context),
      child: Consumer<AppointmentPageViewModel>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: tableCalendar(
                          context: context,
                          calendarController: _calendarController,
                          onVisibleDayChanged: (first, last, format) {
                            value.setYearlyAppointments(AppointmentFilter(
                                type: "c",
                                start: formatter.format(first),
                                end: formatter.format(last)));
                          },
                          onPressed: (pressedDay) {
                            value.setDailyAppointments(AppointmentFilter(
                                type: "d",
                                end: formatter.format(pressedDay),
                                start: formatter.format(pressedDay)));
                          },
                          appointmentList: value.yearlyAppointments,
                          events: value.calendarEvents,
                        ),
                      ),
                      value.stateProcess == StateProcess.DONE
                          ? (value.dailyAppointments.length > 0
                              ? _buildPosts(context, value.dailyAppointments)
                              : Text(
                                  LocaleProvider.current.no_appointment,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03),
                                ))
                          : value.stateProcess == StateProcess.ERROR
                              ? Text(
                                  LocaleProvider.current.sorry_dont_transaction,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03),
                                )
                              : Container(
                                  constraints: BoxConstraints(maxWidth: 800),
                                  child: Center(
                                    child: linearProgress(
                                        backgroundColor: R.color.mainColor),
                                  ),
                                )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ListView _buildPosts(BuildContext context, List<Appointment> appointments) {
    return ListView.builder(
      itemCount: appointments.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Consumer<AppointmentPageViewModel>(
            builder: (context, value, child) {
          return appointmentInfo(
              context: context,
              appointment: appointments[index],
              startAppointment: (webConsultantAppId) {
                value.startAppointments(webConsultantAppId.toString());
              });
        });
      },
    );
  }
}
