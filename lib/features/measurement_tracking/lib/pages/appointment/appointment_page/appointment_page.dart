import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/extension/size_extension.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/models/appointment_models/Appointment.dart';
import 'package:onedosehealth/models/appointment_models/doctor.dart';
import 'package:onedosehealth/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:onedosehealth/widgets/utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

import 'appointment_page_view_model.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  CalendarController _calendarController = CalendarController();
  Doctor doctor;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    doctor = ModalRoute.of(context).settings.arguments as Doctor;
    return Scaffold(
      appBar: CustomAppBar(
          preferredSize: Size.fromHeight(context.HEIGHT * .18),
          title: TitleAppBarWhite(title: LocaleProvider.current.department),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      extendBodyBehindAppBar: true,
      body: ChangeNotifierProvider(
        create: (context) => AppointmentPageViewModel(
            context: context, id: doctor.id.toString()),
        child: Consumer<AppointmentPageViewModel>(
          builder: (context, value, child) {
            return Container(
              padding: EdgeInsets.only(top: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: context.HEIGHT * .18,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 16),
                        ),
                        CustomCircleAvatar(
                            size: 100,
                            child: SvgPicture.asset(
                              R.image.doctor_avatar,
                              fit: BoxFit.fill,
                              color: R.btnDarkBlue,
                            )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        doctor.employee.user.name,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: R.color.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 12),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child:
                            /* Stack(
                          children: <Widget>[
                            Container(
                              height: 90,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: R.btnDarkBlue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12))),
                            ),
                            calendarCollapse(
                                context: context,
                                calendarController: _calendarController,
                                selectedDate: DateTime.parse(value.date),
                                daySelected: (date, events, holidays) {
                                  value.setDate(date.toString());
                                })
                          ],
                        ), */
                            calendarCollapse(
                          context: context,
                          calendarController: _calendarController,
                          selectedDate: DateTime.parse(value.date),
                          daySelected: (date, events, holidays) {
                            value.setDate(date.toString());
                          },
                        ),
                      ),
                    ),
                    value.stage == Stage.LOADING
                        ? Container(
                            child: _shimmer(context),
                            margin: EdgeInsets.all(10))
                        : value.stage == Stage.DONE
                            ? (value.appointments.length > 0
                                ? Container(
                                    child: _buildPosts(
                                        context, value.appointments),
                                    margin: EdgeInsets.all(10),
                                  )
                                : value.closestAppointments.length > 0
                                    ? Column(
                                        children: [
                                          Text(LocaleProvider
                                              .current.no_suitable_appo),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(LocaleProvider.current
                                              .closest_available_appointments),
                                          closestAppointment(
                                              context: context,
                                              date: DateFormat.yMMMMEEEEd(
                                                      Intl.getCurrentLocale())
                                                  .format(DateTime.parse(value
                                                      .closestAppointments[0]
                                                      .date)),
                                              selected: (date) {
                                                _calendarController
                                                    .setSelectedDay(
                                                        DateTime.parse(value
                                                            .closestAppointments[
                                                                0]
                                                            .date));
                                                value.setDate(value
                                                    .closestAppointments[0]
                                                    .date);
                                              }),
                                        ],
                                      )
                                    : SizedBox(
                                        height: context.HEIGHT * .22,
                                        child: Center(
                                          child: Text(LocaleProvider
                                              .current.no_suitable_appo),
                                        ),
                                      ))
                            : Container(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  GridView _shimmer(BuildContext context) {
    return GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 2.0,
        children: List.generate(20, (index) {
          return Center(
            child: Shimmer.fromColors(
                child: buttonAppointment(),
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100]),
          );
        }));
  }

  GridView _buildPosts(BuildContext context, List<Appointment> appointments) {
    return GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 2.0,
        children: List<Widget>.generate(appointments.length, (index) {
          return Center(
            child: buttonAppointment(
                appointment: appointments[index],
                selected: (appointment) {
                  var selectedAppo = appointment as Appointment;
                  Navigator.of(context).pushNamed(Routes.APPOINTMENT_SUMMARY,
                      arguments: [selectedAppo, doctor]);
                }),
          );
        }));
  }
}
