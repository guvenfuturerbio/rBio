import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../model/model.dart';
import 'patient_appointments_vm.dart';

class PatientAppointmentsScreen extends StatefulWidget {
  final bool showAppbar;
  String roomId;

  PatientAppointmentsScreen(this.showAppbar);

  @override
  _PatientAppointmentsScreenState createState() =>
      _PatientAppointmentsScreenState();
}

class _PatientAppointmentsScreenState extends State<PatientAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PatientAppointmentsScreenVm>(
      create: (context) => PatientAppointmentsScreenVm(context: context),
      child: Consumer<PatientAppointmentsScreenVm>(builder: (
        BuildContext context,
        PatientAppointmentsScreenVm value,
        Widget child,
      ) {
        return Scaffold(
          appBar: widget.showAppbar
              ? MainAppBar(
                  context: context,
                  title: getTitleBar(context),
                  leading: ButtonBackWhite(context),
                  actions: getActions(context),
                )
              : null,
          body: _buildBody(value),
        );
      }),
    );
  }

  List<Widget> getActions(BuildContext context) {
    return [
      IconButton(
        icon: SvgPicture.asset(
          R.image.ic_all_files_grey,
          color: R.color.white,
        ),
        onPressed: () => {openAllFiles(context)},
      )
    ];
  }

  Widget _buildBody(PatientAppointmentsScreenVm value) {
    return value.progress == LoadingProgress.LOADING
        ? loadingDialog()
        : value.progress == LoadingProgress.DONE
            ? LoadingOverlay(
                child: _buildPosts(context, value.patientAppointments, value),
                isLoading: value.showProgressOverlay,
                progressIndicator: loadingDialog(),
                opacity: 0,
              )
            : Container();
  }

  Widget _buildPosts(
    BuildContext context,
    List<PatientAppointmentsResponse> posts,
    PatientAppointmentsScreenVm value,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: kIsWeb
            ? EdgeInsets.only(
                top: 50,
                left: Atom.size.width < 800
                    ? Atom.size.width * 0.03
                    : Atom.size.width * 0.10,
                right: Atom.size.width < 800
                    ? Atom.size.width * 0.03
                    : Atom.size.width * 0.10,
              )
            : EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 12),
              child: Text(
                LocaleProvider.current.date_filter,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(left: 8, top: 8, right: 8),
              child: GuvenDateRange(
                startCurrentDate: value.startDate,
                onStartDateChange: (date) {
                  value.setStartDate(date);
                },
                endCurrentDate: value.endDate,
                onEndDateChange: (date) {
                  value.setEndDate(date);
                },
              ),
            ),

            //
            ListView.builder(
              shrinkWrap: true,
              itemCount: posts.length,
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              itemBuilder: (context, index) {
                return _ItemInsurrance(context, posts[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(title: LocaleProvider.of(context).my_appointments);
  }

  Widget _ItemInsurrance(
      BuildContext context, PatientAppointmentsResponse data) {
    return Consumer<PatientAppointmentsScreenVm>(
        builder: (context, value, child) {
      return
          //
       RbioCardAppoCard.appointment(
                  tenantName: data.tenant,
                  doctorName: data.resources[0].resource,
                  departmentName: data.resources[0].department,
                  date: _getFormattedDate(data.from.substring(0, 10)),
                  time: data.from.substring(11, 16),
                  icon: Icon(Icons.cancel),

      );
    });
  }

  String _getHospitalName(
      BuildContext context, PatientAppointmentsResponse data) {
    if (data.type == R.dynamicVar.onlineAppointmentType) {
      return (LocaleProvider.current.online_appo);
    } else if (data.tenantId == R.dynamicVar.tenantAyranciId) {
      return (LocaleProvider.current.guven_hospital_ayranci);
    } else if (data.tenantId == R.dynamicVar.tenantCayyoluId) {
      return (LocaleProvider.current.guven_cayyolu_campus);
    }

    return "";
  }

  String _getHospitalIconConst(
      BuildContext context, PatientAppointmentsResponse data) {
    return data.type == R.dynamicVar.onlineAppointmentType
        ? R.image.online_appo_icon
        : data.tenantId == R.dynamicVar.tenantAyranciId
            ? R.image.ayranci_hospital_icon
            : data.tenantId == R.dynamicVar.tenantCayyoluId
                ? R.image.cayyolu_hospital_icon
                : R.image.hospital_grey;
  }

  String _getFormattedDate(String date) {
    var parsedDate = DateTime.parse(date);
    String textDate = new DateFormat("d MMMM yyyy").format(parsedDate);
    return textDate;
  }

  Widget _onlineAppoActions({String picture, String text, Function onPressed}) {
    return Consumer<PatientAppointmentsScreenVm>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            onPressed();
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              gradient: LinearGradient(colors: [
                R.color.online_appointment,
                R.color.light_online_appointment
              ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
            ),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(picture),
                SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void openAllFiles(BuildContext context) {
    Atom.to(PagePaths.ALL_FILES);
  }
}
