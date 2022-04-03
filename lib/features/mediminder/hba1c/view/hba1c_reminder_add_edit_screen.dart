import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../hba1c.dart';

class Hba1cReminderAddEditScreen extends StatelessWidget {
  const Hba1cReminderAddEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? notificationId;

    try {
      final routeParam = Atom.queryParameters['notificationId'];
      if (routeParam != null) {
        notificationId = int.tryParse(routeParam);
      }
    } catch (_) {
      return const RbioRouteError();
    }

    return BlocProvider<Hba1cReminderAddEditCubit>(
      create: (context) => Hba1cReminderAddEditCubit(
        getIt(),
      )..setInitState(notificationId),
      child: Builder(
        builder: (context) {
          return BlocListener<Hba1cReminderAddEditCubit,
              Hba1cReminderAddEditState>(
            listener: (context, state) {
              state.whenOrNull(
                openListScreen: () {
                  Atom.historyBack();
                  Atom.to(
                    PagePaths.allReminderList,
                    isReplacement: true,
                  );
                },
                showWarningDialog: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return GradientDialog(
                        title: LocaleProvider.current.warning,
                        text: LocaleProvider.current.fill_all_field,
                      );
                    },
                  );
                },
              );
            },
            child: const Hba1cReminderAddEditView(),
          );
        },
      ),
    );
  }
}

class Hba1cReminderAddEditView extends StatelessWidget {
  const Hba1cReminderAddEditView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(context),
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
    return BlocBuilder<Hba1cReminderAddEditCubit, Hba1cReminderAddEditState>(
      buildWhen: (previous, current) =>
          current.whenOrNull(
            openListScreen: () => false,
            showWarningDialog: () => false,
          ) ??
          true,
      builder: (context, state) {
        return state.whenOrNull(
              initial: () => const SizedBox(),
              success: (result) {
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
                            _buildBoldTitle(
                              context,
                              LocaleProvider.current.last_test_date,
                            ),
                            _buildLastTestDate(context, result),

                            //
                            _buildGap(),

                            //
                            _buildBoldTitle(
                              context,
                              LocaleProvider.current.last_result,
                            ),
                            _buildLastTestValue(context, result),

                            //
                            _buildGap(),

                            //
                            _buildBoldTitle(
                              context,
                              LocaleProvider.current.reminder_date,
                            ),
                            _buildReminderDate(context, result),

                            //
                            _buildGap(),

                            //
                            _buildBoldTitle(
                              context,
                              LocaleProvider.current.reminder_hour,
                            ),
                            _buildReminderHour(context, result),

                            //
                            _buildGap(),
                          ],
                        ),
                      ),
                    ),

                    //
                    _buildGap(),

                    //
                    _buildButtons(context, result),

                    //
                    R.sizes.defaultBottomPadding,
                  ],
                );
              },
            ) ??
            const SizedBox();
      },
    );
  }

  Widget _buildGap() => R.sizes.hSizer16;

  Widget _buildLastTestDate(
    BuildContext context,
    Hba1cReminderAddEditResult result,
  ) {
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
              (result.lastTestDate == null)
                  ? ""
                  : DateTime.parse(result.lastTestDate!).xFormatTime10(),
              style: context.xHeadline3,
            ),
          ),

          //
          IconButton(
            onPressed: () async {
              final initialDate = result.lastTestDate;
              final selectedDate = await showRbioDatePicker(
                context,
                title: LocaleProvider.current.last_test_date,
                initialDateTime: (initialDate == null)
                    ? DateTime.now()
                    : DateTime.parse(initialDate),
                minimumDate: R.constants.date2000,
                maximumDate: DateTime.now().add(const Duration(days: 730)),
              );

              if (selectedDate != null) {
                context
                    .read<Hba1cReminderAddEditCubit>()
                    .setLastTestDate(selectedDate);
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

  Widget _buildLastTestValue(
    BuildContext context,
    Hba1cReminderAddEditResult result,
  ) {
    return GestureDetector(
      onTap: () async {
        final newValue = await Atom.show(
          _LastTestDialog(
            initValue: result.lastTestValue == null
                ? ''
                : result.lastTestValue!.toString(),
          ),
        );
        if (newValue != null) {
          context
              .read<Hba1cReminderAddEditCubit>()
              .setLastTestValue(double.tryParse(newValue) ?? 0);
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
          result.lastTestValue == null
              ? ''
              : (Intl.getCurrentLocale() == "tr"
                  ? "% ${result.lastTestValue.toString()}"
                  : "${result.lastTestValue.toString()} %"),
          style: context.xHeadline3,
        ),
      ),
    );
  }

  Widget _buildReminderDate(
    BuildContext context,
    Hba1cReminderAddEditResult result,
  ) {
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
              (result.scheduledDate == null)
                  ? ""
                  : DateTime.parse(result.scheduledDate!).xFormatTime10(),
              style: context.xHeadline3.copyWith(
                color: getIt<ITheme>().textColorSecondary,
              ),
            ),
          ),

          //
          IconButton(
            onPressed: () async {
              final now = DateTime.now();
              final initialDate = result.scheduledDate;
              final selectedDate = await showRbioDatePicker(
                context,
                title: LocaleProvider.current.reminder_date,
                initialDateTime: (initialDate == null)
                    ? DateTime.now()
                    : DateTime.parse(initialDate),
                minimumDate: DateTime(now.year, now.month, now.day, 0, 0, 0),
                maximumDate: result.lastTestDate == null
                    ? DateTime.now()
                    : DateTime.parse(result.lastTestDate!)
                        .add(const Duration(days: 365)),
              );

              if (selectedDate != null) {
                context
                    .read<Hba1cReminderAddEditCubit>()
                    .setScheduledDate(selectedDate);
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

  Widget _buildReminderHour(
    BuildContext context,
    Hba1cReminderAddEditResult result,
  ) {
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
              result.scheduledHour == null
                  ? ''
                  : result.scheduledHour!.xTimeFormat,
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
              if (result.scheduledHour != null) {
                nowTimeOfDay = result.scheduledHour!;
              }

              var timeOfDay = await Utils.instance.openMaterialTimePicker(
                context,
                nowTimeOfDay,
              );
              if (timeOfDay != null) {
                context
                    .read<Hba1cReminderAddEditCubit>()
                    .setScheduledHour(timeOfDay);
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

  Widget _buildButtons(
    BuildContext context,
    Hba1cReminderAddEditResult result,
  ) {
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
            title: result.isCreated
                ? LocaleProvider.current.btn_create
                : LocaleProvider.current.update,
            onTap: () {
              context
                  .read<Hba1cReminderAddEditCubit>()
                  .createNotification(context);
            },
            showElevation: false,
          ),
        ),
      ],
    );
  }

  // #region _buildBoldTitle
  Widget _buildBoldTitle(
    BuildContext context,
    String title,
  ) {
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
