import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/extension/size_extension.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../models/appointment_models/PatientAppointment.dart';
import '../../../widgets/utils.dart';
import '../appointment_page/appointment_page_view_model.dart';
import 'patient_appointment_page_view_model.dart';

class PatientAppointmentPage extends StatefulWidget {
  @override
  _PatientAppointmentPageState createState() => _PatientAppointmentPageState();
}

class _PatientAppointmentPageState extends State<PatientAppointmentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: CustomAppBar(
          preferredSize: Size.fromHeight(context.HEIGHT * .18),
          title: TitleAppBarWhite(title: LocaleProvider.current.appointments),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      extendBodyBehindAppBar: true,
      body: ChangeNotifierProvider(
        create: (context) => PatientAppointmentPageViewModel(context: context),
        child: Consumer<PatientAppointmentPageViewModel>(
          builder: (context, value, child) {
            return Container(
              child: Container(
                margin: EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      value.stage == Stage.LOADING
                          ? _shimmer(context)
                          : value.stage == Stage.ERROR
                              ? Container()
                              : _buildPosts(context, value.appointments),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.DEPARTMENTS),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withAlpha(50),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                  offset: Offset(5, 5))
                            ],
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [R.btnDarkBlue, R.btnLightBlue]),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          margin: EdgeInsets.only(bottom: 22),
                          child: Text(
                            '${LocaleProvider.current.new_appointment}',
                            style: TextStyle(
                                color: R.color.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _shimmer(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: 8,
          padding: EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Shimmer.fromColors(
                  child: appointmentInfo(
                    context: context,
                  ),
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                ),
              ],
            );
          },
        ))
      ],
    );
  }

  ListView _buildPosts(
      BuildContext context, List<PatientAppointment> appointments) {
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return Consumer<PatientAppointmentPageViewModel>(
          builder: (context, value, child) {
            return Column(
              children: [
                appointmentInfo(
                    startAppointment: () {
                      value.startAppointment(
                          value.appointments[index].webConsultAppId);
                    },
                    openFiles: () {
                      Navigator.of(context).pushNamed(Routes.FILES,
                          arguments: value.appointments[index].webConsultAppId);
                    },
                    context: context,
                    availability: value.appointments[index].availability,
                    doctor: value.appointments[index].availability.part.doctor,
                    department: value
                        ?.appointments[index]
                        ?.doctorHospitalDepartment
                        ?.hospitalDepartment
                        ?.department),
                index + 1 == appointments.length
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      )
                    : Container()
              ],
            );
          },
        );
      },
    );
  }
}
