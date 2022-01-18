import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../model/model.dart';
import 'appointment_list_vm.dart';

class AppointmentListScreen extends StatefulWidget {
  AppointmentListScreen();

  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppointmentListVm>(
      create: (context) => AppointmentListVm(context: context),
      child: Consumer<AppointmentListVm>(
        builder: (
          BuildContext context,
          AppointmentListVm vm,
          Widget child,
        ) {
          return RbioScaffold(
            appbar: _buildAppBar(context),
            body: _buildBody(vm),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).my_appointments,
      ),
      actions: getActions(context),
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
      SizedBox(
        width: 12,
      ),
    ];
  }

  Widget _buildBody(AppointmentListVm vm) {
    switch (vm.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return RbioLoadingOverlay(
          child: _buildPosts(vm.patientAppointments, vm),
          isLoading: vm.showProgressOverlay,
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
    List<PatientAppointmentsResponse> posts,
    AppointmentListVm vm,
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
            startCurrentDate: vm.startDate,
            onStartDateChange: (date) {
              vm.setStartDate(date);
            },
            endCurrentDate: vm.endDate,
            onEndDateChange: (date) {
              vm.setEndDate(date);
            },
            startMinDate: DateTime(1900),
            startMaxDate: DateTime.now(),
            endMinDate: DateTime.now(),
          ),
        ),

        //
        SizedBox(height: 12.0),

        //
        Expanded(
          child: vm.patientAppointments.length > 0
              ? ListView.builder(
                  padding: EdgeInsets.only(
                    bottom: R.sizes.defaultBottomValue,
                  ),
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildCard(vm, posts[index]);
                  },
                )
              : Center(
                  child: Text(
                    LocaleProvider.current.no_result_selected_date,
                    textAlign: TextAlign.center,
                    style: context.xHeadline1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildCard(
    AppointmentListVm vm,
    PatientAppointmentsResponse data,
  ) {
    return RbioCardAppoCard.appointment(
      isActiveHeader:
          DateTime.parse(data.from).isAfter(DateTime.now()) ? true : false,
      tenantName: data.tenant,
      doctorName: data.resources[0].resource,
      departmentName: data.resources[0].department,
      date: _getFormattedDate(data.from.substring(0, 10)),
      time: data.from.substring(11, 16),
      suffix: data.type != R.dynamicVar.onlineAppointmentType &&
              DateTime.parse(data.from).isAfter(DateTime.now())
          ? InkWell(
              onTap: () {
                vm.handleAppointment(data);
              },
              child: Container(
                color: Colors.red,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  LocaleProvider.current.cancel,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColor,
                  ),
                ),
              ),
            )
          : SizedBox(),

      //
      footer: _buildCardFooter(vm, data),
    );
  }

  String _getFormattedDate(String date) {
    var parsedDate = DateTime.parse(date);
    String textDate = new DateFormat("d MMMM yyyy").format(parsedDate);
    return textDate;
  }

  Widget _buildCardFooter(
    AppointmentListVm value,
    PatientAppointmentsResponse data,
  ) {
    if (data.type == R.dynamicVar.onlineAppointmentType) {
      if (DateTime.parse(data.from).isBefore(DateTime.now())) {
        return Center(
          child: RbioElevatedButton(
            title: LocaleProvider.current.rate,
            padding: EdgeInsets.symmetric(horizontal: 5),
            onTap: () {
              value.showRateDialog(data.id);
            },
          ),
        );
      } else {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: context.xTextScaleType == TextScaleType.Small
                ? Row(
                    children: [
                      Expanded(
                        child: RbioElevatedAutoButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
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
                      ),

                      //
                      R.sizes.wSizer4,

                      //
                      Expanded(
                        child: RbioElevatedAutoButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
                          title: "Request\nTranslator",
                          onTap: () {
                            value.showTranslatorSelector(data.id.toString());
                          },
                        ),
                      ),

                      //
                      R.sizes.wSizer4,

                      //
                      Expanded(
                        child: RbioElevatedAutoButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
                          title: "Start\nMeeting",
                          onTap: () {
                            value.handleAppointment(data);
                          },
                        ),
                      ),
                    ],
                  )
                : Wrap(
                    spacing: 4,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      RbioElevatedButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
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

                      //
                      RbioElevatedButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        title: "Request\nTranslator",
                        onTap: () {
                          value.showTranslatorSelector(data.id.toString());
                        },
                      ),

                      //
                      RbioElevatedButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        title: "Start\nMeeting",
                        onTap: () {
                          value.handleAppointment(data);
                        },
                      ),
                    ],
                  ),
          ),
        );
      }
    } else {
      return null;
    }
  }
}
