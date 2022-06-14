import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../../../core/utils/tz_helper.dart';
import '../../../mediminder.dart';

part 'reminder_alert_dialog_cubit.freezed.dart';
part 'reminder_alert_dialog_state.dart';

class ReminderAlertDialogCubit extends Cubit<ReminderAlertDialogState> {
  ReminderAlertDialogCubit(
    this.notificationModel,
    this.reminderManager,
    this.reminderNotificationsManager,
  ) : super(const ReminderAlertDialogState.initial());
  late final ReminderNotificationModel notificationModel;
  late final ReminderManager reminderManager;
  late final ReminderNotificationsManager reminderNotificationsManager;

  Future<void> setInitState() async {
    try {
      emit(const ReminderAlertDialogState.loadInProgress());
      await Future.delayed(const Duration(milliseconds: 500));
      var allReminders = reminderManager.getAllReminders();
      final filterId = notificationModel.baseNotificationId ??
          notificationModel.notificationId;
      final model = allReminders
          .firstWhereOrNull((element) => element.notificationId == filterId);
      if (model != null) {
        emit(ReminderAlertDialogState.success(model));
      }
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(const ReminderAlertDialogState.failure());
    }
  }

  Future<void> createPostponeNotification(
    ReminderPostponeType selectType,
  ) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (model) async {
        final newId = await reminderManager.generateNotificationId();
        final scheduledDate =
            TZHelper.instance.now().add(selectType.xGetDuration);
        try {
          await reminderNotificationsManager.createPostponeNotification(
            scheduledDate,
            ReminderNotificationModel(
              notificationId: newId,
              title: notificationModel.title,
              description: notificationModel.description,
              remindable: notificationModel.remindable,
              baseNotificationId: notificationModel.notificationId,
            ),
          );
          emit(const ReminderAlertDialogState.createdPostponeNotification());
        } catch (e, stackTrace) {
          getIt<IAppConfig>()
              .platform
              .sentryManager
              .captureException(e, stackTrace: stackTrace);
          LoggerUtils.instance.e(
            "[ReminderAlertDialogCubit] - createPostponeNotification() - $e",
          );
        }
      },
    );
  }
}
