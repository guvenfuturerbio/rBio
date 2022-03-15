import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/create_appointment_summary_vm.dart';
import 'qr_code_scanner_screen.dart';

class CreateAppointmentSummaryScreen extends StatefulWidget {
  const CreateAppointmentSummaryScreen({Key? key}) : super(key: key);

  @override
  _CreateAppointmentSummaryScreenState createState() =>
      _CreateAppointmentSummaryScreenState();
}

class _CreateAppointmentSummaryScreenState
    extends State<CreateAppointmentSummaryScreen> {
  late String patientId;
  late String patientName;
  late int tenantId;
  late String tenantName;
  late int departmentId;
  late String departmentName;
  late int resourceId;
  late String resourceName;
  late String date;
  late String from;
  late String to;
  late bool forOnline;

  late TextEditingController codeEditingController;
  late FocusNode codeFocusNode;

  @override
  void initState() {
    codeEditingController = TextEditingController();
    codeFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    codeEditingController.dispose();
    codeFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      patientId = Uri.decodeFull(Atom.queryParameters['patientId']!);
      patientName = Uri.decodeFull(Atom.queryParameters['patientName']!);
      tenantId = int.parse(Atom.queryParameters['tenantId']!);
      tenantName = Uri.decodeFull(Atom.queryParameters['tenantName']!);
      departmentId = int.parse(Atom.queryParameters['departmentId']!);
      departmentName = Uri.decodeFull(Atom.queryParameters['departmentName']!);
      resourceId = int.parse(Atom.queryParameters['resourceId']!);
      resourceName = Uri.decodeFull(Atom.queryParameters['resourceName']!);
      date = Atom.queryParameters['date']!;
      from = Atom.queryParameters['from'] as String;
      to = Atom.queryParameters['to'] as String;
      forOnline = Atom.queryParameters['forOnline'] == 'true';
    } catch (_) {
      return const RbioRouteError();
    }

    return ChangeNotifierProvider<CreateAppointmentSummaryVm>(
      create: (context) => CreateAppointmentSummaryVm(
        mContext: context,
        patientId: getIt<UserNotifier>().getPatient().id!,
        tenantId: tenantId,
        departmentId: departmentId,
        resourceId: resourceId,
        forOnline: forOnline,
        from: from,
        to: to,
      ),
      child: Consumer(
        builder: (
          BuildContext context,
          CreateAppointmentSummaryVm vm,
          Widget? child,
        ) {
          return KeyboardDismissOnTap(
            child: RbioStackedScaffold(
              isLoading: vm.showOverlayLoading,
              appbar: _buildAppBar(context),
              body: _buildBody(vm),
            ),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.create_appo,
      ),
    );
  }

  Widget _buildBody(CreateAppointmentSummaryVm vm) => SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            R.sizes.stackedTopPadding(context),

            //
            if (vm.appointmentSuccess) ...[
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    R.sizes.hSizer8,

                    //
                    SvgPicture.asset(
                      R.image.successAppointment,
                      width: Atom.width * 0.4,
                    ),

                    //
                    R.sizes.hSizer4,

                    //
                    Text(
                      LocaleProvider.current.appo_created,
                      textAlign: TextAlign.center,
                      style: context.xHeadline3.copyWith(
                        color: getIt<ITheme>().mainColor,
                      ),
                    ),

                    //
                    R.sizes.hSizer12,
                  ],
                ),
              ),
            ],

            //
            R.sizes.hSizer16,

            //
            Text(
              LocaleProvider.current.appointment_details,
              textAlign: TextAlign.start,
              style: context.xHeadline3,
            ),

            //
            const SizedBox(
              height: 12,
            ),

            //
            _buildInfoCard(vm),

            //
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: _buildKeyboardVisibilityBuilder(vm),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildKeyboardVisibilityBuilder(CreateAppointmentSummaryVm vm) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return RbioKeyboardActions(
          focusList: [
            codeFocusNode,
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (forOnline) ...[
                if (vm.showCodeField) ...[
                  Container(
                    height: 55,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: isKeyboardVisible ? 5 : 0),
                    decoration: BoxDecoration(
                      color: getIt<ITheme>().cardBackgroundColor,
                      borderRadius: R.sizes.borderRadiusCircular,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        _buildHorizontalGap(),

                        //
                        Expanded(
                          child: RbioTextFormField(
                            focusNode: codeFocusNode,
                            controller: codeEditingController,
                            hintText: LocaleProvider.current.discount_code,
                            border: RbioTextFormField.noneBorder(),
                            textInputAction: TextInputAction.done,
                            contentPadding: const EdgeInsets.only(
                              left: 0,
                              right: 20,
                              top: 10,
                              bottom: 13,
                            ),
                            onChanged: (term) {
                              if (term != '') {
                                vm.summaryButton = SummaryButtons.applyActive;
                              } else {
                                vm.summaryButton = SummaryButtons.applyPassive;
                              }
                            },
                          ),
                        ),

                        //
                        if (!Atom.isWeb)
                          GestureDetector(
                            onTap: () async {
                              final code = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const QRCodeScannerScreen();
                                  },
                                ),
                              );
                              if (code != null) {
                                codeEditingController.text = code;
                                vm.summaryButton = SummaryButtons.applyActive;
                              }
                            },
                            child: SvgPicture.asset(
                              R.image.qr,
                              width: 28,
                            ),
                          ),

                        //
                        _buildHorizontalGap(),
                      ],
                    ),
                  ),

                  //
                  _buildVerticalGap(),
                  if (!isKeyboardVisible) ...[
                    _buildVerticalGap(),
                  ],
                ],

                //
                if (!isKeyboardVisible) ...[
                  Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: getIt<ITheme>().cardBackgroundColor,
                      borderRadius: R.sizes.borderRadiusCircular,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        _buildHorizontalGap(),

                        //
                        Text(
                          LocaleProvider.current.price,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.xHeadline3.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                          ),
                        ),

                        //
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _buildPrice(vm),
                          ),
                        ),

                        //
                        _buildHorizontalGap(),
                      ],
                    ),
                  ),

                  //
                  if (!isKeyboardVisible) ...[
                    _buildVerticalGap(),
                    _buildVerticalGap(),
                  ],
                ],
              ],

              //
              if (!forOnline) ...[
                RbioElevatedButton(
                  infinityWidth: true,
                  showElevation: false,
                  onTap: () {
                    if (vm.appointmentSuccess) {
                      Atom.to(PagePaths.main, isReplacement: true);
                    } else {
                      if (vm.orgVideoCallPriceResponse?.patientPrice == null) {
                        Atom.show(
                          GuvenAlert(
                            backgroundColor:
                                getIt<ITheme>().cardBackgroundColor,
                            title: GuvenAlert.buildTitle(
                              LocaleProvider.current.warning,
                            ),
                            content: GuvenAlert.buildSmallDescription(
                                LocaleProvider.current.something_went_wrong),
                          ),
                        );
                      } else {
                        if (vm.newVideoCallPriceResponse?.patientPrice ==
                            null) {
                          vm.saveAppointment(
                            price: vm.orgVideoCallPriceResponse?.patientPrice
                                ?.toString(),
                            forOnline: forOnline,
                            forFree:
                                (vm.orgVideoCallPriceResponse?.patientPrice ??
                                            0) <
                                        1
                                    ? true
                                    : false,
                          );
                        } else {
                          vm.saveAppointment(
                            price: vm.newVideoCallPriceResponse?.patientPrice
                                ?.toString(),
                            forOnline: forOnline,
                            forFree:
                                (vm.newVideoCallPriceResponse?.patientPrice ??
                                            0) <
                                        1
                                    ? true
                                    : false,
                          );
                        }
                      }
                    }
                  },
                  title: vm.appointmentSuccess
                      ? LocaleProvider.current.Ok
                      : LocaleProvider.current.confirm,
                  fontWeight: FontWeight.w600,
                ),
                R.sizes.defaultBottomPadding,
              ] else ...[
                if (!isKeyboardVisible) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //
                      Expanded(
                        child: _buildSummaryButton(vm),
                      ),

                      //
                      const SizedBox(width: 8),

                      //
                      Expanded(
                        child: RbioElevatedButton(
                          showElevation: false,
                          onTap: () {
                            if (vm.newVideoCallPriceResponse?.patientPrice ==
                                null) {
                              vm.saveAppointment(
                                price: vm
                                    .orgVideoCallPriceResponse?.patientPrice
                                    ?.toString(),
                                forOnline: forOnline,
                                forFree: (vm.orgVideoCallPriceResponse
                                                ?.patientPrice ??
                                            0) <
                                        1
                                    ? true
                                    : false,
                              );
                            } else {
                              vm.saveAppointment(
                                price: vm
                                    .newVideoCallPriceResponse?.patientPrice
                                    ?.toString(),
                                forOnline: forOnline,
                                forFree: (vm.newVideoCallPriceResponse
                                                ?.patientPrice ??
                                            0) <
                                        1
                                    ? true
                                    : false,
                              );
                            }
                          },
                          title: forOnline
                              ? LocaleProvider.current.pay
                              : LocaleProvider.current.done,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  //
                  SizedBox(
                    height: Atom.safeBottom + 10,
                  ),
                ],
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildPrice(CreateAppointmentSummaryVm vm) {
    String? _newPrice;
    if (vm.orgVideoCallPriceResponse != null &&
        vm.orgVideoCallPriceResponse?.patientPrice != null) {
      String _price = '${vm.orgVideoCallPriceResponse!.patientPrice!} TL';

      if (vm.newVideoCallPriceResponse != null &&
          vm.newVideoCallPriceResponse?.patientPrice != null) {
        _newPrice = '${vm.newVideoCallPriceResponse!.patientPrice!} TL';
      }

      return _newPrice != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _price,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline1.copyWith(
                    decoration: TextDecoration.lineThrough,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    color: getIt<ITheme>().textColorPassive,
                  ),
                ),
                _buildHorizontalGap(),
                Text(
                  _newPrice,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: getIt<ITheme>().mainColor,
                  ),
                )
              ],
            )
          : Text(
              _price,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline1.copyWith(
                fontWeight: FontWeight.bold,
                color: getIt<ITheme>().mainColor,
              ),
            );
    } else {
      return const RbioLoading();
    }
  }

  Widget _buildSummaryButton(CreateAppointmentSummaryVm vm) {
    late String title;
    late VoidCallback onTap;

    switch (vm.summaryButton) {
      case SummaryButtons.add:
        title = LocaleProvider.current.add_discount_code;
        onTap = () {
          vm.showCodeField = true;
          vm.summaryButton = SummaryButtons.applyPassive;
        };
        break;

      case SummaryButtons.applyPassive:
        title = LocaleProvider.current.apply_discount;
        onTap = () {};
        break;

      case SummaryButtons.applyActive:
        title = LocaleProvider.current.apply_discount;
        onTap = () {
          vm.applyCode(codeEditingController.text.trim());
          vm.summaryButton = SummaryButtons.cancel;
        };
        break;

      case SummaryButtons.cancel:
        title = LocaleProvider.current.cancel_discount;
        onTap = () {
          codeEditingController.text = '';
          vm.codeCancel();
          vm.summaryButton = SummaryButtons.applyPassive;
        };
        break;

      case SummaryButtons.none:
        title = "";
        onTap = () {};
        break;
    }

    return RbioElevatedButton(
      onTap: onTap,
      title: title,
      backColor: vm.summaryButton == SummaryButtons.add
          ? getIt<ITheme>().cardBackgroundColor
          : getIt<ITheme>().mainColor,
      textColor: vm.summaryButton == SummaryButtons.add
          ? getIt<ITheme>().textColorSecondary
          : getIt<ITheme>().textColor,
      fontWeight: FontWeight.w600,
      showElevation: false,
    );
  }

  Widget _buildInfoCard(CreateAppointmentSummaryVm vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPassiveText(LocaleProvider.current.patient_name),
          _buildActiveText(patientName),
          _buildVerticalGap(),

          //
          _buildPassiveText(LocaleProvider.current.tenant_name),
          _buildActiveText(tenantName),
          _buildVerticalGap(),

          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    _buildPassiveText(LocaleProvider.current.doctor_name),
                    _buildActiveText(resourceName),
                  ],
                ),
              ),

              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    _buildPassiveText(LocaleProvider.current.depart_name),
                    _buildActiveText(departmentName),
                  ],
                ),
              ),
            ],
          ),

          //
          _buildVerticalGap(),

          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    _buildPassiveText(LocaleProvider.current.hint_date),
                    _buildActiveText(DateTime.parse(date).xFormatTime1()),
                  ],
                ),
              ),

              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    _buildPassiveText(LocaleProvider.current.time),
                    _buildActiveText(
                        '${from.substring(11, 16)} - ${to.substring(11, 16)}'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalGap() => const SizedBox(height: 8);

  Widget _buildHorizontalGap() => const SizedBox(width: 12);

  Widget _buildActiveText(String text) => Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.xHeadline3,
      );

  Widget _buildPassiveText(String text) => Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.xHeadline4.copyWith(
          color: getIt<ITheme>().textColorPassive,
        ),
      );
}
