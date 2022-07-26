import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../model/country_list_response.dart';
import '../viewmodel/create_appointment_summary_vm.dart';
import 'qr_code_scanner_screen.dart';
import 'widget/location_info_card.dart';

class CreateAppointmentSummaryScreen extends StatefulWidget {
  const CreateAppointmentSummaryScreen({Key? key}) : super(key: key);

  @override
  _CreateAppointmentSummaryScreenState createState() =>
      _CreateAppointmentSummaryScreenState();
}

class _CreateAppointmentSummaryScreenState
    extends State<CreateAppointmentSummaryScreen> {
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

  late final TextEditingController _countryController;
  late final TextEditingController _cityController;

  late Country selectedCountry;
  late String selectedCity;

  @override
  void initState() {
    super.initState();

    codeEditingController = TextEditingController();
    codeFocusNode = FocusNode();

    _countryController = TextEditingController(text: R.constants.turkey);
    _cityController = TextEditingController();

    selectedCountry = Country(name: R.constants.turkey, id: 213);
    selectedCity = "";
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
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return ChangeNotifierProvider<CreateAppointmentSummaryVm>(
      create: (context) => CreateAppointmentSummaryVm(
        mContext: context,
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
      context: context,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.appointment_details,
      ),
    );
  }

  Widget _buildBody(CreateAppointmentSummaryVm vm) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //
                      R.widgets.stackedTopPadding(context),

                      //
                      if (vm.appointmentSuccess) ...[
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //
                              R.widgets.hSizer8,

                              //
                              SvgPicture.asset(
                                context.xCurrentTheme.successAppointmentImage,
                                width: Atom.width * 0.2,
                                height: Atom.height * .2,
                              ),

                              //
                              R.widgets.hSizer4,

                              //
                              Text(
                                LocaleProvider.current.appo_created,
                                textAlign: TextAlign.center,
                                style: context.xHeadline3.copyWith(
                                  color: context.xPrimaryColor,
                                ),
                              ),

                              //
                              R.widgets.hSizer12,
                            ],
                          ),
                        ),
                      ],

                      //
                      R.widgets.hSizer16,

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
                      R.widgets.hSizer16,

                      //
                      if (forOnline &&
                          getIt<IAppConfig>()
                              .functionality
                              .createOnlineAppointmentWithCountrySelection)
                        LocationInfoCard(
                          countryController: _countryController,
                          cityController: _cityController,
                          isCityVisible:
                              selectedCountry.id == 213 ? true : false,
                          countryOnTap: () async {
                            var res = await showRbioSelectBottomSheet(
                              context,
                              title: LocaleProvider.current.country,
                              children: [
                                for (var item in vm.countryList.countries ?? [])
                                  Center(child: Text(item.name)),
                              ],
                              initialItem: 0,
                            );

                            _countryController.text =
                                vm.countryList.countries![res].name!;

                            setState(() {
                              selectedCountry = vm.countryList.countries![res];
                            });
                          },
                          cityOnTap: () async {
                            var res = await showRbioSelectBottomSheet(
                              context,
                              title: LocaleProvider.current.city,
                              children: [
                                for (var item in vm.province)
                                  Center(child: Text(item))
                              ],
                              initialItem: 0,
                            );

                            _cityController.text = vm.province[res];
                            selectedCity = _cityController.text;
                            setState(() {});
                          },
                        ),
                    ],
                  ),
                ),
              ),

              //
              _buildKeyboardVisibilityBuilder(vm, isKeyboardVisible),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKeyboardVisibilityBuilder(
    CreateAppointmentSummaryVm vm,
    bool isKeyboardVisible,
  ) {
    return RbioKeyboardActions(
      focusList: [
        codeFocusNode,
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (forOnline && !vm.appointmentSuccess) ...[
            if (vm.showCodeField) ...[
              Container(
                height: 55,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: isKeyboardVisible ? 5 : 0),
                decoration: BoxDecoration(
                  color: context.xCardColor,
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
                  color: context.xCardColor,
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
          if (vm.appointmentSuccess) ...[
            RbioElevatedButton(
              infinityWidth: true,
              onTap: () {
                Atom.to(
                  PagePaths.main,
                  isReplacement: true,
                );
              },
              title: LocaleProvider.current.home,
              fontWeight: FontWeight.w600,
            ),
          ] else ...[
            // Online Appointment
            if (forOnline) ...[
              if (!isKeyboardVisible) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (!forOnline) ...[
                      RbioElevatedButton(
                        infinityWidth: true,
                        onTap: () async {
                          if (vm.appointmentSuccess) {
                            Atom.to(PagePaths.main, isReplacement: true);
                          } else {
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
                          }
                        },
                        title: vm.appointmentSuccess
                            ? LocaleProvider.current.home
                            : LocaleProvider.current.confirm,
                        fontWeight: FontWeight.w600,
                      ),
                    ] else ...[
                      if (!isKeyboardVisible) ...[
                        SizedBox(
                          width: Atom.width - 24,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              //
                              Expanded(
                                child: _buildSummaryButton(vm),
                              ),

                              //
                              R.widgets.wSizer4,

                              //
                              Expanded(
                                child: RbioElevatedButton(
                                  onTap: () {
                                    if (vm.newVideoCallPriceResponse
                                            ?.patientPrice ==
                                        null) {
                                      vm.saveAppointment(
                                        price: vm.orgVideoCallPriceResponse
                                            ?.patientPrice
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
                                        price: vm.newVideoCallPriceResponse
                                            ?.patientPrice
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
                        ),
                      ],
                    ],
                  ],
                ),
              ],
            ]

            // Hospital Appointment
            else ...[
              RbioElevatedButton(
                infinityWidth: true,
                onTap: () async {
                  await vm.saveAppointment(
                    forOnline: false,
                    forFree: true,
                  );
                },
                title: LocaleProvider.current.confirm,
                fontWeight: FontWeight.w600,
              ),
            ],
          ],

          //
          R.widgets.defaultBottomPadding,
        ],
      ),
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
                    color: context.xMyCustomTheme.textDisabledColor,
                  ),
                ),

                //
                _buildHorizontalGap(),

                //
                Text(
                  _newPrice,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.xPrimaryColor,
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
                color: context.xPrimaryColor,
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
        title = LocaleProvider.current.discount_code;
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
          ? context.xCardColor
          : context.xPrimaryColor,
      textColor: vm.summaryButton == SummaryButtons.add
          ? context.xTextInverseColor
          : null,
      fontWeight: FontWeight.w600,
    );
  }

  Widget _buildInfoCard(CreateAppointmentSummaryVm vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.xCardColor,
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
                    _buildActiveText(date.xGetUTCLocalDate()),
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
                    _buildActiveText('$from+03:00'.xGetUTCLocalTime() +
                        '-' +
                        '$to+03:00'.xGetUTCLocalTime()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalGap() => R.widgets.hSizer8;

  Widget _buildHorizontalGap() => R.widgets.wSizer12;

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
          color: context.xMyCustomTheme.textDisabledColor,
        ),
      );
}
