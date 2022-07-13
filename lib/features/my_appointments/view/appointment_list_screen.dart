import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/features/my_appointments/cubit/my_appointments_cubit.dart';

import '../../../../core/core.dart';
import '../../shared/rate_dialog/view/rate_dialog.dart';
import '../my_appointments.dart';

class AppointmentListScreen extends StatelessWidget {
  final bool isFromDashboard;
  const AppointmentListScreen({this.isFromDashboard = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAppointmentsCubit(
          getIt(), getIt(), getIt<IAppConfig>().platform.sentryManager, ''),
      child: AppointmentListView(isFromDashboard: isFromDashboard),
    );
  }
}

class AppointmentListView extends StatefulWidget {
  final bool isFromDashboard;

  const AppointmentListView({
    Key? key,
    this.isFromDashboard = false,
  }) : super(key: key);

  @override
  _AppointmentListViewState createState() => _AppointmentListViewState();
}

class _AppointmentListViewState extends State<AppointmentListView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyAppointmentsCubit, MyAppointmentsState>(
      listener: (context, state) {
        if (state.overlayStatus == MyAppointmentsOverlayStatus.doPayment) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return GuvenAlert(
                backgroundColor: Colors.white,
                title: GuvenAlert.buildTitle(
                  LocaleProvider.current.fee_information,
                ),
                content: GuvenAlert.buildDescription(
                  LocaleProvider.current.payment_question_tag,
                ),
                actions: [
                  GuvenAlert.buildMaterialAction(
                    LocaleProvider.current.btn_cancel,
                    () {
                      Navigator.pop(context);
                    },
                  ),

                  //
                  const SizedBox(
                    width: 20,
                  ),

                  //
                  GuvenAlert.buildMaterialAction(
                    LocaleProvider.current.confirm,
                    () {
                      Navigator.pop(context);
                      if (state.data != null) {
                        Atom.to(
                          PagePaths.appointmentSummary,
                          queryParameters: {
                            'tenantId': state.data!.tenantId.toString(),
                            'departmentId': state
                                .data!.resources![0].departmentId
                                .toString(),
                            'resourceId':
                                state.data!.resources![0].resourceId.toString(),
                            'doctorName': Uri.encodeFull(
                                state.data!.resources![0].resource ?? ''),
                            'departmentName': Uri.encodeFull(
                                state.data!.resources![0].department ?? ''),
                            'from': state.data!.from ?? '',
                            'to': state.data!.to ?? '',
                            'forOnline': true.toString(),
                            'imageUrl': state.data!.id.toString(),
                          },
                        );
                      }
                    },
                  ),
                ],
              );
            },
          );
        } else if (state.overlayStatus ==
            MyAppointmentsOverlayStatus.joinMeeting) {
          getIt<UserManager>().startMeeting(
            context,
            state.webConsultantId!,
            state.availabilityId!,
            state.fromDate!,
          );
        } else if (state.overlayStatus ==
            MyAppointmentsOverlayStatus.showErrorDialog) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) => RbioMessageDialog(
              description: LocaleProvider.current.sorry_dont_transaction,
              buttonTitle: LocaleProvider.current.ok,
            ),
          );
        } else if (state.overlayStatus ==
            MyAppointmentsOverlayStatus.questionDialog) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const QuestionDialog();
              }).then((value) async {
            if (value) {
              await context.read<MyAppointmentsCubit>().cancelAppointment();
            } else {}
          });
        } else if (state.overlayStatus ==
            MyAppointmentsOverlayStatus.showRateDialog) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return RateDialog(
                availabilityId: state.availabilityId!,
              );
            },
          );
        }
      },
      builder: (context, state) {
        return RbioStackedScaffold(
          isLoading: state.overlayStatus ==
                  MyAppointmentsOverlayStatus.showProgressOverlay
              ? true
              : false,
          appbar: _buildAppBar(context),
          body: _buildBody(state),
        );
      },
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

  Widget _buildBody(
    MyAppointmentsState state,
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
            startCurrentDate: state.startDate ?? DateTime.now(),
            onStartDateChange: (date) {
              if (!state.startDate!.xIsSameDate(date)) {
                context.read<MyAppointmentsCubit>().setStartDate(date);
              }
            },
            endCurrentDate: state.endDate ?? DateTime.now(),
            onEndDateChange: (date) {
              if (!state.endDate!.xIsSameDate(date)) {
                context.read<MyAppointmentsCubit>().setEndDate(date);
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
        Expanded(child: _buildExpandedChild(state))
      ],
    );
  }

  Widget _buildExpandedChild(MyAppointmentsState state) {
    switch (state.bodyStatus) {
      case MyAppointmentsBodyStatus.loadingProgress:
        return const RbioLoading();

      case MyAppointmentsBodyStatus.success:
        return (state.patientAppointments?.isNotEmpty ?? false)
            ? ListView.builder(
                padding: EdgeInsets.only(
                  bottom: R.sizes.defaultBottomValue,
                ),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: state.patientAppointments?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return _buildCard(state.patientAppointments![index]);
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
              );

      case MyAppointmentsBodyStatus.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }

  Widget _buildCard(
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
                context.read<MyAppointmentsCubit>().handleAppointment(data);
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
      footer: _buildCardFooter(data) ?? const SizedBox(),
    );
  }

  Widget? _buildCardFooter(
    PatientAppointmentsResponse data,
  ) {
    if (data.type == R.constants.onlineAppointmentType) {
      if (DateTime.parse(data.from ?? '').isBefore(
              DateTime.now().add(R.constants.videoCallBoundaryDuration)) &&
          (DateTime.parse(data.to ?? '').isAfter(DateTime.now()
              .subtract(R.constants.videoCallBoundaryDuration)))) {
        if (data.isRated ?? false) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildThankYouText(),

                //
                _build40Gap(),

                //GREEN
                _buildStartVideoButton(
                  onPressed: () {
                    context.read<MyAppointmentsCubit>().handleAppointment(data);
                  },
                ),
              ],
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              _buildRateButton(
                data,
              ),

              //
              _build40Gap(),

              //GREEN
              Center(
                child: _buildStartVideoButton(
                  onPressed: () {
                    context.read<MyAppointmentsCubit>().handleAppointment(data);
                  },
                ),
              ),
            ],
          );
        }
      } else if (!(DateTime.parse(data.from ?? '').isBefore(
              DateTime.now().add(R.constants.videoCallBoundaryDuration))) &&
          (DateTime.parse(data.to ?? '').isAfter(DateTime.now()
              .subtract(R.constants.videoCallBoundaryDuration)))) {
        if (data.isRated ?? false) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                _buildThankYouText(),

                //
                _build40Gap(),

                //
                _buildStartVideoButton(
                  backColor: getIt<IAppConfig>().theme.grey,
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return RbioMessageDialog(
                          description: LocaleProvider
                              .current.available_video_call_button,
                          isAtom: false,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              _buildRateButton(
                data,
              ),

              //
              _build40Gap(),

              //
              Center(
                child: _buildStartVideoButton(
                  backColor: getIt<IAppConfig>().theme.gray,
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return RbioMessageDialog(
                          description: LocaleProvider
                              .current.available_video_call_button,
                          isAtom: false,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }
      } else {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
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
              ],
            ),
          ),
        );
      }
    } else {
      return null;
    }
  }

  Widget _buildThankYouText() {
    return Center(
      child: Text(
        LocaleProvider.current.rate_thank_you,
        style: context.xHeadline4.copyWith(
          color: getIt<IAppConfig>().theme.mainColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _build40Gap() => R.sizes.wSizer40;

  Widget _buildStartVideoButton({
    Color? backColor,
    required void Function() onPressed,
  }) {
    return RbioIconButton(
      backColor: backColor,
      onPressed: onPressed,
      icon: SvgPicture.asset(
        R.image.startVideo,
        color: getIt<IAppConfig>().theme.white,
      ),
    );
  }

  Widget _buildRateButton(
    PatientAppointmentsResponse data,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: RbioIconButton(
          onPressed: () {
            final itemId = data.id;
            if (itemId != null) {
              context.read<MyAppointmentsCubit>().showRateDialog(itemId);
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
}
