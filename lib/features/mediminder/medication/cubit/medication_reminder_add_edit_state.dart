part of 'medication_reminder_add_edit_cubit.dart';

@freezed
class MedicationReminderAddEditState with _$MedicationReminderAddEditState {
  const factory MedicationReminderAddEditState.initial() = _InitialState;
  const factory MedicationReminderAddEditState.success(
      MedicationReminderAddEditResult result) = _SuccessState;
}

class MedicationReminderAddEditResult {
  bool isCreated;
  int? editNotificationId;
  int? editCreatedDate;
  UsageType? usageType;
  MedicinePeriod? medicinePeriod;
  int? dailyDose;
  List<tz.TZDateTime> doseTimes;
  List<SelectableDay> days;
  int? oneTimeDose;

  MedicationReminderAddEditResult({
    required this.isCreated,
    this.editNotificationId,
    this.editCreatedDate,
    this.usageType,
    this.medicinePeriod,
    this.dailyDose,
    this.doseTimes = const [],
    this.days = const [],
    this.oneTimeDose,
  });

  MedicationReminderAddEditResult copyWith({
    bool? isCreated,
    int? editNotificationId,
    int? editCreatedDate,
    UsageType? usageType,
    MedicinePeriod? medicinePeriod,
    int? dailyDose,
    List<tz.TZDateTime>? doseTimes,
    List<SelectableDay>? days,
    int? oneTimeDose,
  }) {
    return MedicationReminderAddEditResult(
      isCreated: isCreated ?? this.isCreated,
      editNotificationId: editNotificationId ?? this.editNotificationId,
      editCreatedDate: editCreatedDate ?? this.editCreatedDate,
      usageType: usageType ?? this.usageType,
      medicinePeriod: medicinePeriod ?? this.medicinePeriod,
      dailyDose: dailyDose ?? this.dailyDose,
      doseTimes: doseTimes ?? this.doseTimes,
      days: days ?? this.days,
      oneTimeDose: oneTimeDose ?? this.oneTimeDose,
    );
  }

  MedicationReminderAddEditResult resetDailDose() {
    return MedicationReminderAddEditResult(
      isCreated: isCreated,
      editNotificationId: editNotificationId,
      editCreatedDate: editCreatedDate,
      usageType: usageType,
      medicinePeriod: medicinePeriod,
      dailyDose: null,
      doseTimes: [],
      days: days,
      oneTimeDose: oneTimeDose,
    );
  }
}
