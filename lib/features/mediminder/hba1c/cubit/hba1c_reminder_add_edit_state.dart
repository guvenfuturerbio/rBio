part of 'hba1c_reminder_add_edit_cubit.dart';

@freezed
class Hba1cReminderAddEditState with _$Hba1cReminderAddEditState {
  const factory Hba1cReminderAddEditState.initial() = _InitialState;
  const factory Hba1cReminderAddEditState.success(Hba1cReminderAddEditResult result) = _SuccessState;
  const factory Hba1cReminderAddEditState.openListScreen() = _AddEditOpenListScreenState;
  const factory Hba1cReminderAddEditState.showWarningDialog(String description) = _ShowWarningDialogState;
}

class Hba1cReminderAddEditResult {
  bool isCreated;
  int? editNotificationId;
  int? editCreatedDate;

  String? scheduledDate;
  TimeOfDay? scheduledHour;
  String? lastTestDate;
  double? lastTestValue;

  Hba1cReminderAddEditResult({
    required this.isCreated,
    this.editNotificationId,
    this.editCreatedDate,
    this.scheduledDate,
    this.scheduledHour,
    this.lastTestDate,
    this.lastTestValue,
  });

  Hba1cReminderAddEditResult copyWith({
    bool? isCreated,
    int? editNotificationId,
    int? editCreatedDate,
    String? scheduledDate,
    TimeOfDay? scheduledHour,
    String? lastTestDate,
    double? lastTestValue,
  }) {
    return Hba1cReminderAddEditResult(
      isCreated: isCreated ?? this.isCreated,
      editNotificationId: editNotificationId ?? this.editNotificationId,
      editCreatedDate: editCreatedDate ?? this.editCreatedDate,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      scheduledHour: scheduledHour ?? this.scheduledHour,
      lastTestDate: lastTestDate ?? this.lastTestDate,
      lastTestValue: lastTestValue ?? this.lastTestValue,
    );
  }
}
