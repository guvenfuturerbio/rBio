import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../model/model.dart';
import 'appointment_list_vm.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({Key? key}) : super(key: key);

  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppointmentListVm>(
      create: (context) => AppointmentListVm(context),
      child: Consumer<AppointmentListVm>(
        builder: (
          BuildContext context,
          AppointmentListVm vm,
          Widget? child,
        ) {
          return RbioStackedScaffold(
            isLoading: vm.showProgressOverlay,
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
          R.image.allFilesGrey,
          color: R.color.white,
        ),
        onTap: () {
          Atom.to(PagePaths.allFiles);
        },
      ),
      const SizedBox(
        width: 12,
      ),
    ];
  }

  Widget _buildBody(AppointmentListVm vm) {
    switch (vm.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return _buildPosts(vm.patientAppointments ?? [], vm);

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
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
        R.sizes.stackedTopPadding(context),
        R.sizes.hSizer8,

        //
        Text(
          LocaleProvider.current.date_filter,
          style: context.xHeadline1,
        ),

        //
        Container(
          margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
          child: GuvenDateRange(
            startCurrentDate: vm.startDate,
            onStartDateChange: (date) {
              if (!vm.startDate.xIsSameDate(date)) {
                vm.setStartDate(date);
              }
            },
            endCurrentDate: vm.endDate,
            onEndDateChange: (date) {
              if (!vm.endDate.xIsSameDate(date)) {
                vm.setEndDate(date);
              }
            },
            startMinDate: DateTime(1900),
            startMaxDate: DateTime.now(),
            endMinDate: DateTime.now(),
          ),
        ),

        //
        const SizedBox(height: 12.0),

        //
        Expanded(
          child: (vm.patientAppointments?.isNotEmpty ?? false)
              ? ListView.builder(
                  padding: EdgeInsets.only(
                    bottom: R.sizes.defaultBottomValue,
                  ),
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
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
      isActiveHeader: DateTime.parse(data.from ?? '').isAfter(DateTime.now())
          ? true
          : false,
      tenantName: (data.tenant ?? '') == "Nba Tıp Merkezi"
          ? "Güven Hastanesi Çayyolu"
          : (data.tenant ?? ''),
      doctorName: data.resources?[0].resource ?? '',
      departmentName: data.resources?[0].department ?? '',
      date: _getFormattedDate((data.from ?? '').substring(0, 10)),
      time: (data.from ?? '').substring(11, 16),
      suffix: data.type != R.constants.onlineAppointmentType &&
              DateTime.parse(data.from ?? '').isAfter(DateTime.now())
          ? InkWell(
              onTap: () {
                vm.handleAppointment(data);
              },
              child: Container(
                color: Colors.red,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  LocaleProvider.current.btn_cancel,
                  style: context.xHeadline3.copyWith(
                    color: getIt<IAppConfig>().theme.textColor,
                  ),
                ),
              ),
            )
          : const SizedBox(),

      //
      footer: _buildCardFooter(vm, data) ?? const SizedBox(),
    );
  }

  String _getFormattedDate(String date) {
    var parsedDate = DateTime.parse(date);
    String textDate = DateFormat("d MMMM yyyy").format(parsedDate);
    return textDate;
  }

  Widget? _buildCardFooter(
    AppointmentListVm value,
    PatientAppointmentsResponse data,
  ) {
    if (data.type == R.constants.onlineAppointmentType) {
      if (DateTime.parse(data.from ?? '').isBefore(DateTime.now())) {
        return Center(
          child: RbioElevatedButton(
            title: LocaleProvider.current.rate,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            onTap: () {
              final itemId = data.id;
              if (itemId != null) {
                value.showRateDialog(itemId);
              }
            },
          ),
        );
      } else {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: context.xTextScaleType == TextScaleType.small
                ? Row(
                    children: [
                      Expanded(
                        child: RbioElevatedAutoButton(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
                          title: LocaleProvider.current.uploadFile,
                          onTap: () async {
                            File? fileBytes = await value.getSelectedFile();
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
                                    content: const SizedBox(),
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
                          title: LocaleProvider.current.requestTranslator,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
                          title: LocaleProvider.current.startMeeting,
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        title: "Upload\nFile",
                        onTap: () async {
                          File? fileBytes = await value.getSelectedFile();
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
                                  content: const SizedBox(),
                                );
                              },
                            );
                          }
                        },
                      ),

                      //
                      RbioElevatedButton(
                        padding: const EdgeInsets.symmetric(
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
                        padding: const EdgeInsets.symmetric(
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
