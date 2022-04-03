import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../hba1c.dart';

class Hba1cReminderAddScreen extends StatefulWidget {
  const Hba1cReminderAddScreen({Key? key}) : super(key: key);

  @override
  State<Hba1cReminderAddScreen> createState() => _Hba1cReminderAddScreenState();
}

class _Hba1cReminderAddScreenState extends State<Hba1cReminderAddScreen> {
  int? notificationId;
  bool get isCreated => notificationId == null;

  @override
  Widget build(BuildContext context) {
    try {
      final routeParam = Atom.queryParameters['notificationId'];
      if (routeParam != null) {
        notificationId = int.tryParse(routeParam);
      }
    } catch (_) {
      return const RbioRouteError();
    }

    return ChangeNotifierProvider<Hba1cReminderAddVm>(
      create: (context) => Hba1cReminderAddVm(context, notificationId, getIt()),
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
            _buildButtons(vm),

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
              (hba1cVM.lastTestDate == "")
                  ? ""
                  : DateTime.parse(hba1cVM.lastTestDate).xFormatTime10(),
              style: context.xHeadline3,
            ),
          ),

          //
          IconButton(
            onPressed: () async {
              final initialDate = hba1cVM.lastTestDate;
              final result = await showRbioDatePicker(
                context,
                title: LocaleProvider.current.last_test_date,
                initialDateTime: (initialDate == '')
                    ? DateTime.now()
                    : DateTime.parse(initialDate),
                minimumDate: R.constants.date2000,
                maximumDate: DateTime.now().add(const Duration(days: 730)),
              );

              if (result != null) {
                hba1cVM.setLastTestDate(result.toString());
              }
            },
            icon: Icon(
              RbioCustomIcons.calendar,
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
        final result = await Atom.show(
          _LastTestDialog(
            initValue: hba1cVM.lastTestValue.toString(),
          ),
        );
        if (result != null) {
          hba1cVM.setLastTestValue(double.tryParse(result) ?? 0);
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
              ? "% ${hba1cVM.lastTestValue.toString()}"
              : "${hba1cVM.lastTestValue.toString()} %"),
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
              (hba1cVM.scheduledDate == "")
                  ? ""
                  : DateTime.parse(hba1cVM.scheduledDate).xFormatTime10(),
              style: context.xHeadline3.copyWith(
                color: getIt<ITheme>().textColorSecondary,
              ),
            ),
          ),

          //
          IconButton(
            onPressed: () async {
              final now = DateTime.now();
              final initialDate = hba1cVM.scheduledDate;
              final result = await showRbioDatePicker(
                context,
                title: LocaleProvider.current.reminder_date,
                initialDateTime: (initialDate == '')
                    ? DateTime.now()
                    : DateTime.parse(initialDate),
                minimumDate: DateTime(now.year, now.month, now.day, 0, 0, 0),
                maximumDate: DateTime.parse(hba1cVM.lastTestDate)
                    .add(const Duration(days: 365)),
              );

              if (result != null) {
                hba1cVM.setScheduledDate(result.toString());
              }
            },
            icon: Icon(
              RbioCustomIcons.calendar,
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
              hba1cVM.scheduledHour == null
                  ? ''
                  : hba1cVM.scheduledHour!.xTimeFormat,
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
              if (hba1cVM.scheduledHour != null) {
                nowTimeOfDay = hba1cVM.scheduledHour!;
              }

              var timeOfDay = await Utils.instance.openMaterialTimePicker(
                context,
                nowTimeOfDay,
              );
              if (timeOfDay != null) {
                hba1cVM.setScheduledHour(timeOfDay);
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

  Widget _buildButtons(Hba1cReminderAddVm vm) {
    return Row(
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
            title: isCreated
                ? LocaleProvider.current.btn_create
                : LocaleProvider.current.update,
            onTap: () {
              vm.createNotification(isCreated);
            },
            showElevation: false,
          ),
        ),
      ],
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
  final String initValue;

  const _LastTestDialog({
    Key? key,
    this.initValue = '',
  }) : super(key: key);

  @override
  State<_LastTestDialog> createState() => _LastTestDialogState();
}

class _LastTestDialogState extends State<_LastTestDialog> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    textEditingController.text = widget.initValue;

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
