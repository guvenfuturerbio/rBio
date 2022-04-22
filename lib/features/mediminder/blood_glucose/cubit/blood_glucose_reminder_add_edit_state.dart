part of 'blood_glucose_reminder_add_edit_cubit.dart';

@freezed
class BloodGlucoseReminderAddEditState with _$BloodGlucoseReminderAddEditState {
  const factory BloodGlucoseReminderAddEditState.initial() = _InitialState;
  const factory BloodGlucoseReminderAddEditState.success(
      BloodGlucoseReminderAddEditResult result) = _SuccessState;
  const factory BloodGlucoseReminderAddEditState.openListScreen() =
      _OpenListScreenState;
  const factory BloodGlucoseReminderAddEditState.showWarningDialog(
      String description) = _ShowWarningDialogState;
}

class BloodGlucoseReminderAddEditResult {
  bool isCreated;
  int? editCreatedDate;
  UsageType? usageType;
  ReminderPeriod? reminderPeriod;
  int? dailyDose;
  List<tz.TZDateTime> doseTimes;
  List<bool> doseTimeStatus;
  List<SelectableDay> days;

  BloodGlucoseReminderAddEditResult({
    required this.isCreated,
    this.editCreatedDate,
    this.usageType,
    this.reminderPeriod,
    this.dailyDose,
    this.doseTimeStatus = const [],
    this.doseTimes = const [],
    this.days = const [],
  });

  BloodGlucoseReminderAddEditResult copyWith({
    bool? isCreated,
    int? editCreatedDate,
    UsageType? usageType,
    ReminderPeriod? reminderPeriod,
    int? dailyDose,
    List<bool>? doseTimeStatus,
    List<tz.TZDateTime>? doseTimes,
    List<SelectableDay>? days,
  }) {
    return BloodGlucoseReminderAddEditResult(
      isCreated: isCreated ?? this.isCreated,
      editCreatedDate: editCreatedDate ?? this.editCreatedDate,
      usageType: usageType ?? this.usageType,
      reminderPeriod: reminderPeriod ?? this.reminderPeriod,
      dailyDose: dailyDose ?? this.dailyDose,
      doseTimeStatus: doseTimeStatus ?? this.doseTimeStatus,
      doseTimes: doseTimes ?? this.doseTimes,
      days: days ?? this.days,
    );
  }

  BloodGlucoseReminderAddEditResult resetDailDose() {
    return BloodGlucoseReminderAddEditResult(
      isCreated: isCreated,
      editCreatedDate: editCreatedDate,
      usageType: usageType,
      reminderPeriod: reminderPeriod,
      dailyDose: null,
      doseTimeStatus: [],
      doseTimes: [],
      days: days,
    );
  }
}
