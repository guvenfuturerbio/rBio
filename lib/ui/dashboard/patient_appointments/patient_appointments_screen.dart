import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

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
                left: Atom.size.width < 800
                    ? Atom.size.width * 0.03
                    : Atom.size.width * 0.10,
                right: Atom.size.width < 800
                    ? Atom.size.width * 0.03
                    : Atom.size.width * 0.10)
            : EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 8, top: 8),
                    child: Row(
                      children: [
                        Text(LocaleProvider.current.date_filter),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    child: InkWell(
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(2000, 1, 1),
                                        maxTime: value.endDate,
                                        onChanged: (date) {},
                                        onConfirm: (date) {
                                      value.setStartDate(date);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.tr);
                                  },
                                  child: Text(
                                    DateFormat.yMMMd(Intl.getCurrentLocale())
                                        .format(value.startDate),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )),
                                Text(" - "),
                                Container(
                                    child: InkWell(
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: value.startDate,
                                        maxTime: DateTime.now()
                                            .add(Duration(days: 365)),
                                        onChanged: (date) {},
                                        onConfirm: (date) {
                                      value.setEndDate(date);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.tr);
                                  },
                                  child: Text(
                                    DateFormat.yMMMd(Intl.getCurrentLocale())
                                        .format(value.endDate),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(
                          _getHospitalIconConst(context, data),
                          height: 25,
                          width: 25,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            _getHospitalName(context, data),
                            style: TextStyle(
                                color: R.color.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),

                  //
                  Card(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //
                          Text(
                            LocaleProvider.of(context).hint_doctor,
                            style: TextStyle(
                              color: R.color.grey,
                              fontSize: 16,
                            ),
                          ),

                          //
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Text(
                              data.resources[0].resource,
                              style: TextStyle(
                                color: R.color.black,
                                fontSize: 18,
                              ),
                            ),
                          ),

                          //
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    LocaleProvider.of(context).department,
                                    style: TextStyle(
                                        color: R.color.grey, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    data.resources[0].department,
                                    style: TextStyle(
                                        color: R.color.black, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    LocaleProvider.of(context).hint_date,
                                    style: TextStyle(
                                      color: R.color.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  LocaleProvider.of(context).hint_time,
                                  style: TextStyle(
                                    color: R.color.grey,
                                    fontSize: 16,
                                  ),
                                ))
                              ],
                            ),
                          ),

                          //
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    _getFormattedDate(
                                        data.from.substring(0, 10)),
                                    style: TextStyle(
                                      color: R.color.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  data.from.substring(11, 16) +
                                      "-" +
                                      data.to.substring(11, 16),
                                  style: TextStyle(
                                    color: R.color.black,
                                    fontSize: 18,
                                  ),
                                ))
                              ],
                            ),
                          ),

                          //
                          data.type == R.dynamicVar.onlineAppointmentType
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: _onlineAppoActions(
                                        text: "",
                                        onPressed: () async {
                                          Uint8List fileBytes =
                                              await value.getSelectedFile();

                                          if (fileBytes != null) {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return GuvenAlert(
                                                  title: Text(
                                                    LocaleProvider()
                                                        .upload_file_question,
                                                    style: TextStyle(
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  actions: [
                                                    button(
                                                      text: LocaleProvider.of(
                                                              context)
                                                          .confirm,
                                                      onPressed: () async {
                                                        await value.uploadFile(
                                                            fileBytes);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                  content: SizedBox(),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        picture: R.image.ic_upload,
                                      ),
                                    ),
                                    Expanded(
                                      child: _onlineAppoActions(
                                        onPressed: () {
                                          value.showTranslatorSelector(
                                              data.id.toString());
                                        },
                                        text: "",
                                        picture: R.image.ic_translator,
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          value.showRateDialog(data.id);
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            gradient: LinearGradient(
                                                colors: [
                                                  R.color.online_appointment,
                                                  R.color
                                                      .light_online_appointment
                                                ],
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.centerRight),
                                          ),
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star_rate_sharp,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                LocaleProvider.current.rate,
                                                maxLines: 2,
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  color: R.color.white,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),

                          //
                          data.type == R.dynamicVar.onlineAppointmentType
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocaleProvider.of(context).cancel_call_appo,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: data.type ==
                                              R.dynamicVar.onlineAppointmentType
                                          ? R.color.online_appointment
                                          : data.tenantId ==
                                                  R.dynamicVar.tenantAyranciId
                                              ? R.color.ayranci
                                              : R.color.cayyolu,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //
              Visibility(
                visible: data.type != R.dynamicVar.onlineAppointmentType &&
                        DateTime.parse(data.from).isBefore(DateTime.now())
                    ? false
                    : true,
                child: Positioned(
                  top: 10,
                  right: 15,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          value.handleAppointment(data);
                        },
                        child: Container(
                          child: SvgPicture.asset(
                            data.type == R.dynamicVar.onlineAppointmentType
                                ? R.image.start_video_call_icon
                                : data.tenantId == R.dynamicVar.tenantAyranciId
                                    ? R.image.question_suyesili
                                    : data.tenantId ==
                                            R.dynamicVar.tenantCayyoluId
                                        ? R.image.question_turuncu
                                        : R.image.question_grey,
                            height: 45,
                            width: 45,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: data.type ==
                                        R.dynamicVar.onlineAppointmentType
                                    ? R.color.online_appointment.withAlpha(60)
                                    : data.type == R.dynamicVar.tenantAyranciId
                                        ? R.color.ayranci.withAlpha(60)
                                        : data.type ==
                                                R.dynamicVar.tenantCayyoluId
                                            ? R.color.cayyolu.withAlpha(60)
                                            : R.color.black.withAlpha(50),
                                blurRadius: 25,
                                offset: Offset(0, 2),
                              ),
                              BoxShadow(
                                color: R.color.dark_black.withAlpha(50),
                                blurRadius: 25,
                                spreadRadius: -10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
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
