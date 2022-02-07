import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../core/enums/remindable.dart';
import '../../../core/my_flutter_app_icons.dart';
import '../../../core/widgets/guven_date_picker.dart';
import '../viewmodel/hba1c_reminder_add_vm.dart';

// ignore: must_be_immutable
class Hba1cReminderAddScreen extends StatefulWidget {
  int? hba1cIdForNotification;
  Remindable? remindable;

  Hba1cReminderAddScreen({Key? key}) : super(key: key);

  @override
  State<Hba1cReminderAddScreen> createState() => _Hba1cReminderAddScreenState();
}

class _Hba1cReminderAddScreenState extends State<Hba1cReminderAddScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.remindable =
          Atom.queryParameters['remindable']?.toRouteToRemindable();
      widget.hba1cIdForNotification =
          int.parse(Atom.queryParameters['hba1cIdForNotification']!);
    } catch (e) {
      return const RbioRouteError();
    }

    return ChangeNotifierProvider<Hba1cReminderAddVm>(
      create: (context) => Hba1cReminderAddVm(
        context,
        widget.remindable!,
      ),
      child: RbioScaffold(
        appbar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.hbA1c_measurement,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<Hba1cReminderAddVm>(
      builder: (
        BuildContext context,
        Hba1cReminderAddVm vm,
        Widget? child,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    _buildBoldTitle(LocaleProvider.current.last_test_date),
                    _buildLastTestDate(context, vm),

                    //
                    _buildGap(),

                    //
                    _buildBoldTitle(LocaleProvider.current.last_result),
                    _buildLastTestValue(context, vm),

                    //
                    _buildGap(),

                    //
                    _buildBoldTitle(LocaleProvider.current.reminder_date),
                    _buildReminderDate(context, vm),

                    //
                    _buildGap(),

                    //
                    _buildBoldTitle(LocaleProvider.current.reminder_hour),
                    _buildReminderHour(context, vm),

                    //
                    _buildGap(),
                  ],
                ),
              ),
            ),

            //
            _buildGap(),

            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                Expanded(
                  child: RbioElevatedButton(
                    backColor: getIt<ITheme>().cardBackgroundColor,
                    textColor: getIt<ITheme>().textColorSecondary,
                    title: LocaleProvider.current.btn_cancel,
                    onTap: () {
                      Atom.historyBack();
                    },
                    showElevation: false,
                  ),
                ),

                //
                R.sizes.wSizer8,

                //
                Expanded(
                  child: RbioElevatedButton(
                    title: LocaleProvider.current.btn_create,
                    onTap: () {
                      vm.createNotification(widget.hba1cIdForNotification!);
                    },
                    showElevation: false,
                  ),
                ),
              ],
            ),

            //
            R.sizes.defaultBottomPadding,
          ],
        );
      },
    );
  }

  Widget _buildGap() => R.sizes.hSizer16;

  Widget _buildLastTestDate(BuildContext context, Hba1cReminderAddVm hba1cVM) {
    return Container(
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Text(
              (hba1cVM.lastMeasurementDate == "")
                  ? ""
                  : DateTime.parse(hba1cVM.lastMeasurementDate).xFormatTime10(),
              style: context.xHeadline3,
            ),
          ),

          //
          IconButton(
            onPressed: () async {
              final initialDate = hba1cVM.lastMeasurementDate;
              final result = await showGuvenDatePicker(
                context,
                DateTime.now(),
                DateTime.now().add(const Duration(days: 365)),
                (initialDate == '')
                    ? DateTime.now()
                    : DateTime.parse(initialDate),
                LocaleProvider.of(context).select_day_from,
              );

              if (result != null) {
                hba1cVM.setLastMeasurementDate(result.toString());
              }
            },
            icon: Icon(
              MyFlutterApp.calendar,
              size: R.sizes.iconSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastTestValue(BuildContext context, Hba1cReminderAddVm hba1cVM) {
    return GestureDetector(
      onTap: () async {
        final result = await Atom.show<String?>(const _LastTestDialog());
        if (result != null) {
          hba1cVM.setPreviousResult(double.parse(result));
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: getIt<ITheme>().cardBackgroundColor,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 12,
        ),
        child: Text(
          (Intl.getCurrentLocale() == "tr"
              ? "% ${hba1cVM.previousResult.toString()}"
              : "${hba1cVM.previousResult.toString()} %"),
          style: context.xHeadline3,
        ),
      ),
    );
  }

  Widget _buildReminderDate(BuildContext context, Hba1cReminderAddVm hba1cVM) {
    return Container(
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Text(
              (hba1cVM.remindDate == "")
                  ? ""
                  : DateTime.parse(hba1cVM.remindDate).xFormatTime10(),
              style: context.xHeadline3.copyWith(
                color: getIt<ITheme>().textColorSecondary,
              ),
            ),
          ),

          //
          IconButton(
            onPressed: () async {
              final initialDate = hba1cVM.remindDate;
              final result = await showGuvenDatePicker(
                context,
                DateTime.now(),
                DateTime.now().add(const Duration(days: 365)),
                (initialDate == '')
                    ? DateTime.now()
                    : DateTime.parse(initialDate),
                LocaleProvider.of(context).select_day_from,
              );

              if (result != null) {
                hba1cVM.setRemindDate(result.toString());
              }
            },
            icon: Icon(
              MyFlutterApp.calendar,
              size: R.sizes.iconSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderHour(BuildContext context, Hba1cReminderAddVm hba1cVM) {
    return Container(
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Text(
              hba1cVM.remindHour == null
                  ? ''
                  : "${hba1cVM.remindHour?.hour}:${hba1cVM.remindHour?.minute}",
              style: context.xHeadline3.copyWith(
                color: getIt<ITheme>().textColorSecondary,
              ),
            ),
          ),

          //
          IconButton(
            onPressed: () async {
              final now = DateTime.now();
              var nowTimeOfDay = TimeOfDay(
                hour: now.hour,
                minute: now.minute,
              );
              if (hba1cVM.remindHour != null) {
                nowTimeOfDay = hba1cVM.remindHour!;
              }

              var timeOfDay = await Utils.instance.openMaterialTimePicker(
                context,
                nowTimeOfDay,
              );
              if (timeOfDay != null) {
                hba1cVM.setRemindHour(timeOfDay);
              }
            },
            icon: SvgPicture.asset(
              R.image.otherIcon,
              width: R.sizes.iconSize2,
            ),
          ),
        ],
      ),
    );
  }

  // #region _buildBoldTitle
  Widget _buildBoldTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        bottom: 8,
      ),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: context.xHeadline3.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  // #endregion
}

class _LastTestDialog extends StatefulWidget {
  const _LastTestDialog({Key? key}) : super(key: key);

  @override
  State<_LastTestDialog> createState() => _LastTestDialogState();
}

class _LastTestDialogState extends State<_LastTestDialog> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: SafeArea(
        child: Container(
          width: Atom.width > 350 ? 350 : Atom.width,
          decoration: BoxDecoration(
            color: getIt<ITheme>().cardBackgroundColor,
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                R.sizes.hSizer8,

                //
                Text(
                  LocaleProvider.current.test_result,
                  style: context.xHeadline1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //
                R.sizes.hSizer8,

                //
                RbioTextFormField(
                  backColor: getIt<ITheme>().grayColor,
                  controller: textEditingController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  keyboardType: TextInputType.number,
                ),

                //
                R.sizes.hSizer16,

                //
                if (context.xTextScaleType == TextScaleType.small) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //
                      Expanded(
                        child: _buildCancelButton(infinityWidth: false),
                      ),

                      //
                      R.sizes.wSizer8,

                      //
                      Expanded(
                        child: _buildConfirmButton(infinityWidth: false),
                      ),
                    ],
                  ),
                ] else ...[
                  _buildCancelButton(infinityWidth: true),
                  R.sizes.hSizer12,
                  _buildConfirmButton(infinityWidth: true),
                ],

                //
                R.sizes.hSizer4,
              ],
            ),
          ),
        ),
      ),
    );
  }

  RbioElevatedButton _buildConfirmButton({
    required bool infinityWidth,
  }) {
    return RbioElevatedButton(
      title: LocaleProvider.current.btn_confirm,
      onTap: () {
        if (textEditingController.text.isNotEmpty) {
          Atom.dismiss(textEditingController.text.trim());
        }
      },
      showElevation: false,
      fontWeight: FontWeight.bold,
      infinityWidth: infinityWidth,
    );
  }

  RbioElevatedButton _buildCancelButton({
    required bool infinityWidth,
  }) {
    return RbioElevatedButton(
      backColor: getIt<ITheme>().grayColor,
      textColor: getIt<ITheme>().textColorSecondary,
      title: LocaleProvider.current.btn_cancel,
      onTap: () {
        Atom.dismiss();
      },
      showElevation: false,
      fontWeight: FontWeight.bold,
      infinityWidth: infinityWidth,
    );
  }
}
