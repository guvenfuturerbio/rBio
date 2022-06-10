import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../my_appointments.dart';

class AppointmentListScreen extends StatefulWidget {
  final bool isFromDashboard;

  const AppointmentListScreen({
    Key? key,
    this.isFromDashboard = false,
  }) : super(key: key);

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
      leading: widget.isFromDashboard ? const SizedBox() : null,
      leadingWidth: widget.isFromDashboard ? 0 : null,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).my_appointments,
      ),
      actions: getActions(context),
    );
  }

  List<Widget> getActions(BuildContext context) {
    return [
      // InkWell(
      //   child: SvgPicture.asset(
      //     R.image.allFilesGrey,
      //     color: getIt<IAppConfig>().theme.white,
      //   ),
      //   onTap: () {
      //     Atom.to(PagePaths.allFiles);
      //   },
      // ),
      // const SizedBox(
      //   width: 12,
      // ),
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
          margin: const EdgeInsets.only(top: 8, right: 8),
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
            startMinDate: DateTime(1900).getStartOfTheDay,
            startMaxDate: DateTime.now().getStartOfTheDay,
            endMinDate: DateTime.now().getStartOfTheDay,
            endMaxDate:
                DateTime.now().add(const Duration(days: 365)).getStartOfTheDay,
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
      date: data.from?.xGetUTCLocalDate() ?? '',
      //_getFormattedDate((data.from ?? '').substring(0, 10)),
      time: ("${data.from?.xGetUTCLocalTime()} ${data.to?.xGetUTCLocalTime()}"),
      //(data.from ?? '').substring(11, 16),
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

  Widget? _buildCardFooter(
    AppointmentListVm value,
    PatientAppointmentsResponse data,
  ) {
    if (data.type == R.constants.onlineAppointmentType) {
      if (DateTime.parse(data.from ?? '').isBefore(DateTime.now())) {
        if (data.isRated ?? false) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                LocaleProvider.current.rate_thank_you,
                style: context.xHeadline4.copyWith(
                  color: getIt<IAppConfig>().theme.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RbioIconButton(
                onPressed: () {
                  final itemId = data.id;
                  if (itemId != null) {
                    value.showRateDialog(itemId);
                  }
                },
                icon: SvgPicture.asset(
                  R.image.rate,
                  color: getIt<IAppConfig>().theme.white,
                ),
              ),
            ),
          );
        }
      } else {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // RbioIconButton(
                //   onPressed: () async {
                //     File? fileBytes = await value.getSelectedFile();
                //     if (fileBytes != null) {
                //       showDialog(
                //         context: context,
                //         barrierDismissible: true,
                //         builder: (BuildContext context) {
                //           return GuvenAlert(
                //             backgroundColor: Colors.white,
                //             title: GuvenAlert.buildTitle(
                //               LocaleProvider().upload_file_question,
                //             ),
                //             actions: [
                //               GuvenAlert.buildMaterialAction(
                //                 LocaleProvider.of(context).confirm,
                //                 () async {
                //                   await value.uploadFile(fileBytes);
                //                   Navigator.pop(context);
                //                 },
                //               ),
                //             ],
                //             content: const SizedBox(),
                //           );
                //         },
                //       );
                //     }
                //   },
                //   icon: SvgPicture.asset(
                //     R.image.upload,
                //     color: getIt<IAppConfig>().theme.white,
                //   ),
                // ),

                //

                RbioIconButton(
                  onPressed: () {
                    value.showTranslatorSelector(data.id.toString());
                  },
                  icon: SvgPicture.asset(
                    R.image.translator,
                    color: getIt<IAppConfig>().theme.white,
                  ),
                ),

                //
                RbioIconButton(
                  onPressed: () {
                    value.handleAppointment(data);
                  },
                  icon: SvgPicture.asset(
                    R.image.startVideo,
                    color: getIt<IAppConfig>().theme.white,
                  ),
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
