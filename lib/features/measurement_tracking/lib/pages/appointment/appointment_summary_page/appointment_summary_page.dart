import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/models/appointment_models/Appointment.dart';
import 'package:onedosehealth/models/appointment_models/doctor.dart';
import 'package:onedosehealth/pages/appointment/appointment_summary_page/appointment_summary_page_view_model.dart';
import 'package:onedosehealth/widgets/utils.dart';
import 'package:provider/provider.dart';

class AppointmentSummaryPage extends StatefulWidget {
  @override
  _AppointmentSummaryPageState createState() => _AppointmentSummaryPageState();
}

class _AppointmentSummaryPageState extends State<AppointmentSummaryPage> {
  Doctor doctor;
  Appointment appointment;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final args = ModalRoute.of(context).settings.arguments as List<Object>;
    doctor = args[1] as Doctor;
    appointment = args[0] as Appointment;
    return ChangeNotifierProvider(
      create: (context) => AppointmentSummaryPageViewModel(context: context),
      child: Consumer<AppointmentSummaryPageViewModel>(
        builder: (context, value, child) {
          return Scaffold(
              appBar: MainAppBar(
                  context: context,
                  title: TitleAppBarWhite(
                      title: LocaleProvider.current.appointment_details),
                  leading: InkWell(
                      child: SvgPicture.asset(R.image.back_icon),
                      onTap: () => Navigator.of(context).pop())),
              body: SingleChildScrollView(
                child: Container(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.all(8),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  LocaleProvider
                                                      .current.hint_doctor,
                                                  style: TextStyle(
                                                      color: R.color.grey,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                LocaleProvider
                                                    .current.department,
                                                style: TextStyle(
                                                    color: R.color.grey,
                                                    fontSize: 16),
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
                                                  doctor?.employee?.user
                                                          ?.name ??
                                                      "",
                                                  style: TextStyle(
                                                      color: R.color.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                doctor
                                                        ?.doctorHospitalDepartment
                                                        ?.hospitalDepartment
                                                        ?.department ??
                                                    "-",
                                                style: TextStyle(
                                                    color: R.color.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                  LocaleProvider
                                                      .current.hint_date,
                                                  style: TextStyle(
                                                      color: R.color.grey,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                LocaleProvider.current.time,
                                                style: TextStyle(
                                                    color: R.color.grey,
                                                    fontSize: 16),
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
                                                  DateFormat("dd/MM/yyyy")?.format(
                                                      DateTime.parse(appointment
                                                              ?.part
                                                              ?.startDateTime ??
                                                          "-")),
                                                  style: TextStyle(
                                                      color: R.color.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                appointment?.startTime
                                                    ?.substring(0, 5),
                                                style: TextStyle(
                                                    color: R.color.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withAlpha(50),
                                    blurRadius: 15,
                                    spreadRadius: 0,
                                    offset: Offset(5, 10))
                              ]),
                        ),
                        _feeInfo(),
                        SizedBox(height: 32),
                        button(
                            text: LocaleProvider.current.use_voucher,
                            onPressed: () {}),
                        SizedBox(height: 32),
                        button(
                            text: LocaleProvider.current.payment,
                            onPressed: () {
                              value.hasIdentificationNumber
                                  ? Navigator.pushNamed(
                                      context, Routes.CREDIT_CARD,
                                      arguments: [appointment, doctor])
                                  : Navigator.pushNamed(
                                      context, Routes.ADDITIONAL_INFO,
                                      arguments: [appointment, doctor]);
                            })
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget _feeInfo() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: Text(
                  LocaleProvider.current.fee_information,
                  style: TextStyle(
                      color: R.color.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Divider(
                height: 1,
                color: R.color.dark_white,
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          appointment.part.type.name,
                          style: TextStyle(color: R.color.grey, fontSize: 16),
                        ),
                      ],
                    )),
                    Text(
                      doctor.onlineAppointmentFee.toString() + " " + "TL",
                      style: TextStyle(color: R.color.black, fontSize: 18),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: R.color.dark_white,
              ),
              Container(
                margin: EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        LocaleProvider.current.total,
                        style: TextStyle(
                            color: R.color.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      doctor.onlineAppointmentFee.toString() + " " + "TL",
                      style: TextStyle(
                          color: R.color.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
          ),
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
            ]));
  }
}
