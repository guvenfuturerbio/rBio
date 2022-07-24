import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../../core/utils/helper/tz_helper.dart';
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
    return RbioBaseGreyDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Center(
            child: Text(
              _getTitle(model),
              style: getIt<IAppConfig>().theme.dialogTheme.title(context),
            ),
          ),

          //
          R.widgets.hSizer24,

          //
          Center(
            child: Text(
              getIt<UserFacade>().getNameAndSurname(),
              style: getIt<IAppConfig>().theme.dialogTheme.description(context),
            ),
          ),

          //
          R.widgets.hSizer8,

          //
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              Text(
                model.title,
                style: getIt<IAppConfig>()
                    .theme
                    .dialogTheme
                    .description(context)
                    .copyWith(fontWeight: FontWeight.bold),
              ),

              //
              Text(
                "  -  ",
                style: getIt<IAppConfig>()
                    .theme
                    .dialogTheme
                    .description(context)
                    .copyWith(fontWeight: FontWeight.bold),
              ),

              //
              Text(
                model.scheduledDate.xHourFormat,
                style: getIt<IAppConfig>()
                    .theme
                    .dialogTheme
                    .description(context)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          //
          R.widgets.hSizer12,

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
                R.widgets.wSizer8,
              ],

              //
              Expanded(
                child: RbioSmallDialogButton.main(
                  context: context,
                  onPressed: () {
                    Atom.dismiss();
                  },
                  title: LocaleProvider.current.Ok,
                ),
              ),
            ],
          ),

          //
          R.widgets.hSizer8,

          //
          RbioSmallDialogButton.red(
            context,
            title: LocaleProvider.current.discard,
            onPressed: () {
              Atom.dismiss(false);
            },
          ),
        ],
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
