import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../mediminder.dart';
import '../hba1c.dart';

part 'widget/last_test_dialog.dart';

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
                    PagePaths.reminderList,
                    isReplacement: true,
                  );
                },
                showWarningDialog: (description) {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return GradientDialog(
                        title: LocaleProvider.current.warning,
                        text: description,
                      );
                    },
                  );
                },
              );
            },
            child: const _Hba1cReminderAddEditView(),
          );
        },
      ),
    );
  }
}

class _Hba1cReminderAddEditView extends StatelessWidget {
  const _Hba1cReminderAddEditView({
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
            showWarningDialog: (_) => false,
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
                            ReminderBoldTitle(
                              title: LocaleProvider.current.last_test_date,
                            ),
                            _buildLastTestDate(context, result),

                            //
                            _buildGap(),

                            //
                            ReminderBoldTitle(
                              title: LocaleProvider.current.last_result,
                            ),
                            _buildLastTestValue(context, result),

                            //
                            _buildGap(),

                            //
                            ReminderBoldTitle(
                              title: LocaleProvider.current.reminder_date,
                            ),
                            _buildReminderDate(context, result),

                            //
                            _buildGap(),

                            //
                            ReminderBoldTitle(
                              title: LocaleProvider.current.reminder_hour,
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
                    _buildGap(),
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
    return GestureDetector(
      onTap: () async {
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
      child: Container(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                RbioCustomIcons.calendar,
                size: R.sizes.iconSize,
              ),
            ),
          ],
        ),
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
    return GestureDetector(
      onTap: () async {
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
      child: Container(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                RbioCustomIcons.calendar,
                size: R.sizes.iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderHour(
    BuildContext context,
    Hba1cReminderAddEditResult result,
  ) {
    return GestureDetector(
      onTap: () async {
        final now = DateTime.now();
        var nowTimeOfDay = TimeOfDay(
          hour: now.hour,
          minute: now.minute,
        );
        if (result.scheduledHour != null) {
          nowTimeOfDay = result.scheduledHour!;
        }

        final selectedDate = await showRbioDatePicker(
          context,
          title: LocaleProvider.current.reminder_hour,
          initialDateTime: DateTime(
            now.year,
            now.month,
            now.day,
            nowTimeOfDay.hour,
            nowTimeOfDay.minute,
          ),
          minimumDate: DateTime(
            now.year,
            now.month,
            now.day,
            0,
            0,
          ),
          maximumDate: DateTime(
            now.year,
            now.month,
            now.day,
            23,
            59,
          ),
          mode: CupertinoDatePickerMode.time,
        );

        if (selectedDate != null) {
          context.read<Hba1cReminderAddEditCubit>().setScheduledHour(
                TimeOfDay(
                  hour: selectedDate.hour,
                  minute: selectedDate.minute,
                ),
              );
        }
      },
      child: Container(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                R.image.otherIcon,
                width: R.sizes.iconSize2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(
    BuildContext context,
    Hba1cReminderAddEditResult result,
  ) {
    if (result.lastTestDate != null &&
        result.lastTestValue != null &&
        result.scheduledDate != null &&
        result.scheduledHour != null) {
      return SafeArea(
        child: Row(
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
              ),
            ),

            //
            R.sizes.wSizer12,

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
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
