part of 'reminder_alert_dialog_cubit.dart';

@freezed
class ReminderAlertDialogState with _$ReminderAlertDialogState {
  const factory ReminderAlertDialogState.initial() = _Initial;
  const factory ReminderAlertDialogState.loadInProgress() = _LoadInProgress;
  const factory ReminderAlertDialogState.success(ReminderListModel model) = _Success;
  const factory ReminderAlertDialogState.failure() = _Failure;
  const factory ReminderAlertDialogState.createdPostponeNotification() = _CreatedPostponeNotification;
}
