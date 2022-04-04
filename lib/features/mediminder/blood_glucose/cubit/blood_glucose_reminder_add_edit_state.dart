part of 'blood_glucose_reminder_add_edit_cubit.dart';

@freezed
class BloodGlucoseReminderAddEditState with _$BloodGlucoseReminderAddEditState {
  const factory BloodGlucoseReminderAddEditState.initial() = _InitialState;
  const factory BloodGlucoseReminderAddEditState.success(BloodGlucoseReminderAddEditResult result) = _SuccessState;
  const factory BloodGlucoseReminderAddEditState.openListScreen() = _OpenListScreenState;
  const factory BloodGlucoseReminderAddEditState.showWarningDialog(String description) = _ShowWarningDialogState;
}

class BloodGlucoseReminderAddEditResult {
  bool isCreated;
  int? editNotificationId;
  int? editCreatedDate;
  UsageType? usageType;
  MedicinePeriod? medicinePeriod;
  int? dailyDose;
  List<tz.TZDateTime> doseTimes;
  List<SelectableDay> days;

  BloodGlucoseReminderAddEditResult({
    required this.isCreated,
    this.editNotificationId,
    this.editCreatedDate,
    this.usageType,
    this.medicinePeriod,
    this.dailyDose,
    this.doseTimes = const [],
    this.days = const [],
  });

  BloodGlucoseReminderAddEditResult copyWith({
    bool? isCreated,
    int? editNotificationId,
    int? editCreatedDate,
    UsageType? usageType,
    MedicinePeriod? medicinePeriod,
    int? dailyDose,
    List<tz.TZDateTime>? doseTimes,
    List<SelectableDay>? days,
  }) {
    return BloodGlucoseReminderAddEditResult(
      isCreated: isCreated ?? this.isCreated,
      editNotificationId: editNotificationId ?? this.editNotificationId,
      editCreatedDate: editCreatedDate ?? this.editCreatedDate,
      usageType: usageType ?? this.usageType,
      medicinePeriod: medicinePeriod ?? this.medicinePeriod,
      dailyDose: dailyDose ?? this.dailyDose,
      doseTimes: doseTimes ?? this.doseTimes,
      days: days ?? this.days,
    );
  }

  BloodGlucoseReminderAddEditResult resetDailDose() {
    return BloodGlucoseReminderAddEditResult(
      isCreated: isCreated,
      editNotificationId: editNotificationId,
      editCreatedDate: editCreatedDate,
      usageType: usageType,
      medicinePeriod: medicinePeriod,
      dailyDose: null,
      doseTimes: [],
      days: days,
    );
  }
}
