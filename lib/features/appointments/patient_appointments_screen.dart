import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
        return RbioScaffold(
          appbar: widget.showAppbar
              ? RbioAppBar(
                  title: RbioAppBar.textTitle(
                      context, LocaleProvider.of(context).my_appointments),
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
      InkWell(
        child: SvgPicture.asset(
          R.image.ic_all_files_grey,
          color: R.color.white,
        ),
        onTap: () {
          Atom.to(PagePaths.ALL_FILES);
        },
      ),

      //
      SizedBox(width: Atom.isWeb ? Atom.width * 0.01 : Atom.width * 0.04),
    ];
  }

  Widget _buildBody(PatientAppointmentsScreenVm value) {
    switch (value.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return RbioLoadingOverlay(
          child: _buildPosts(context, value.patientAppointments, value),
          isLoading: value.showProgressOverlay,
          progressIndicator: RbioLoading.progressIndicator(),
          opacity: 0,
        );

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }

  Widget _buildPosts(
    BuildContext context,
    List<PatientAppointmentsResponse> posts,
    PatientAppointmentsScreenVm value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        Text(
          LocaleProvider.current.date_filter,
          style: context.xHeadline1,
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
        SizedBox(height: 12.0),

        //
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return _buildCard(context, posts[index], value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context,
    PatientAppointmentsResponse data,
    PatientAppointmentsScreenVm value,
  ) {
    return Consumer<PatientAppointmentsScreenVm>(
      builder: (
        BuildContext context,
        PatientAppointmentsScreenVm value,
        Widget child,
      ) {
        return RbioCardAppoCard.appointment(
          bannerColor: DateTime.parse(data.from).isAfter(DateTime.now())
              ? getIt<ITheme>().mainColor
              : null,
          tenantName: data.tenant,
          doctorName: data.resources[0].resource,
          departmentName: data.resources[0].department,
          date: _getFormattedDate(data.from.substring(0, 10)),
          time: data.from.substring(11, 16),
          suffix: data.type != R.dynamicVar.onlineAppointmentType &&
                  DateTime.parse(data.from).isAfter(DateTime.now())
              ? InkWell(
                  onTap: () {
                    value.handleAppointment(data);
                  },
                  child: Container(
                    color: Colors.red,
                    height: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      LocaleProvider.current.cancel,
                      style: context.xHeadline1.copyWith(color: R.color.white),
                    ),
                  ),
                )
              : SizedBox(),
          bottomButtons: data.type == R.dynamicVar.onlineAppointmentType
              ? DateTime.parse(data.from).isBefore(DateTime.now())
                  ? [
                      RbioElevatedButton(
                          title: "\tRate\t",
                          onTap: () {
                            value.showRateDialog(data.id);
                          })
                    ]
                  : [
                      RbioElevatedButton(
                        title: "Upload\nFile",
                        onTap: () async {
                          Uint8List fileBytes = await value.getSelectedFile();

                          if (fileBytes != null) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return GuvenAlert(
                                  backgroundColor: Colors.white,
                                  title: GuvenAlert.buildTitle(
                                    LocaleProvider().upload_file_question,
                                  ),
                                  actions: [
                                    GuvenAlert.buildMaterialAction(
                                      LocaleProvider.of(context).confirm,
                                      () async {
                                        await value.uploadFile(fileBytes);
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
                      ),
                      RbioElevatedButton(
                        title: "Request\nTranslator",
                        onTap: () {
                          value.showTranslatorSelector(data.id.toString());
                        },
                      ),
                      RbioElevatedButton(
                        title: "Start\nMeeting",
                        onTap: () {
                          value.handleAppointment(data);
                        },
                      )
                    ]
              : [],
        );
      },
    );
  }

  String _getFormattedDate(String date) {
    var parsedDate = DateTime.parse(date);
    String textDate = new DateFormat("d MMMM yyyy").format(parsedDate);
    return textDate;
  }
}
