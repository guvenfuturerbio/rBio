import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onedosehealth/core/utils/tz_helper.dart';

import '../../../../../core/core.dart';
import '../../../mediminder.dart';

part '../model/reminder_postpone_type.dart';
part 'widget/postpone_component.dart';

class ReminderAlertDialog extends StatelessWidget {
  final ReminderNotificationModel notificationModel;

  const ReminderAlertDialog({
    Key? key,
    required this.notificationModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReminderAlertDialogCubit>(
      create: (context) => ReminderAlertDialogCubit(
        notificationModel,
        getIt(),
        getIt(),
      )..setInitState(),
      child: Builder(
        builder: (context) {
          return BlocListener<ReminderAlertDialogCubit,
              ReminderAlertDialogState>(
            listener: (context, state) {
              state.whenOrNull(
                createdPostponeNotification: () {
                  Atom.dismiss();
                },
              );
            },
            child: _ReminderAlertView(
              notificationModel: notificationModel,
            ),
          );
        },
      ),
    );
  }
}

class _ReminderAlertView extends StatelessWidget {
  final ReminderNotificationModel notificationModel;

  const _ReminderAlertView({
    Key? key,
    required this.notificationModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderAlertDialogCubit, ReminderAlertDialogState>(
      buildWhen: (previous, current) =>
          current.mapOrNull(createdPostponeNotification: (_) => false) ?? true,
      builder: (context, state) => _buildBody(context, state),
    );
  }

  // #region _buildBody
  Widget _buildBody(BuildContext context, ReminderAlertDialogState state) {
    return state.whenOrNull(
          initial: () => const SizedBox(),
          loadInProgress: () => const RbioLoading(),
          success: (model) => _buildSuccess(context, model),
          failure: () => const RbioBodyError(),
        ) ??
        const SizedBox();
  }
  // #endregion

  // #region _buildSuccess
  Widget _buildSuccess(BuildContext context, ReminderListModel model) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(36),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: context.scaffoldBackgroundColor,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Text(
              _getTitle(model),
              style: context.xHeadline3,
            ),

            //
            R.sizes.hSizer8,

            //
            Text(
              model.title,
              style: context.xHeadline2.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            //
            Text(
              model.scheduledDate.xHourFormat,
              style: context.xHeadline3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            //
            Text(
              model.nameAndSurname,
              style: context.xHeadline3,
            ),

            //
            R.sizes.hSizer4,

            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                if (notificationModel.baseNotificationId == null) ...[
                  //
                  const Expanded(
                    child: _ExpandablePostponeComponent(),
                  ),

                  //
                  R.sizes.wSizer8,
                ],

                //
                Expanded(
                  child: RbioElevatedButton(
                    onTap: () {},
                    title: LocaleProvider.current.Ok,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            //
            R.sizes.hSizer4,

            //
            RbioRedButton(
              onTap: () {
                Atom.dismiss();
              },
              title: LocaleProvider.current.discard,
              infinityWidth: true,
            ),
          ],
        ),
      ),
    );
  }
  // #endregion

  // #region _getTitle
  String _getTitle(ReminderListModel model) {
    switch (model.remindable) {
      case Remindable.bloodGlucose:
        return LocaleProvider.current.bg_measurement_time;

      case Remindable.medication:
        return LocaleProvider.current.time_take_medicine_title;

      case Remindable.hbA1c:
        return LocaleProvider.current.time_hba1c;

      case Remindable.strip:
        return "";
    }
  }
  // #endregion
}
