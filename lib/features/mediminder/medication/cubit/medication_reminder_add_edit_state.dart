part of 'medication_reminder_add_edit_cubit.dart';

@freezed
class MedicationReminderAddEditState with _$MedicationReminderAddEditState {
  const factory MedicationReminderAddEditState.initial() = _InitialState;
  const factory MedicationReminderAddEditState.success(
      MedicationReminderAddEditResult result) = _SuccessState;
  const factory MedicationReminderAddEditState.openListScreen() =
      _OpenListScreenState;
  const factory MedicationReminderAddEditState.showWarningDialog(
      String description) = _ShowWarningDialogState;
}

class MedicationReminderAddEditResult {
  bool isCreated;
  int? editCreatedDate;
  DrugTracking drugTracking;
  String? drugName;
  UsageType? usageType;
  ReminderPeriod? reminderPeriod;
  int? dailyDose;
  int? oneTimeDose;
  List<SelectableDay> days;
  List<tz.TZDateTime> doseTimes;
  int? drugCount;
  int? remainingCountNotification;
  String? boxCode;

  MedicationReminderAddEditResult({
    required this.isCreated,
    this.editCreatedDate,
    this.drugTracking = DrugTracking.manuel,
    this.drugName,
    this.usageType,
    this.reminderPeriod,
    this.dailyDose,
    this.oneTimeDose,
    this.doseTimes = const [],
    this.days = const [],
    this.drugCount,
    this.remainingCountNotification,
    this.boxCode,
  });

  MedicationReminderAddEditResult copyWith({
    bool? isCreated,
    int? editCreatedDate,
    DrugTracking? drugTracking,
    String? drugName,
    UsageType? usageType,
    ReminderPeriod? reminderPeriod,
    int? dailyDose,
    int? oneTimeDose,
    List<SelectableDay>? days,
    List<tz.TZDateTime>? doseTimes,
    int? drugCount,
    int? remainingCountNotification,
    String? boxCode,
  }) {
    return MedicationReminderAddEditResult(
      isCreated: isCreated ?? this.isCreated,
      editCreatedDate: editCreatedDate ?? this.editCreatedDate,
      drugTracking: drugTracking ?? this.drugTracking,
      drugName: drugName ?? this.drugName,
      usageType: usageType ?? this.usageType,
      reminderPeriod: reminderPeriod ?? this.reminderPeriod,
      dailyDose: dailyDose ?? this.dailyDose,
      oneTimeDose: oneTimeDose ?? this.oneTimeDose,
      days: days ?? this.days,
      doseTimes: doseTimes ?? this.doseTimes,
      drugCount: drugCount ?? this.drugCount,
      remainingCountNotification:
          remainingCountNotification ?? this.remainingCountNotification,
      boxCode: boxCode ?? this.boxCode,
    );
  }

  MedicationReminderAddEditResult resetDailDose() {
    return MedicationReminderAddEditResult(
      isCreated: isCreated,
      editCreatedDate: editCreatedDate,
      drugTracking: drugTracking,
      drugName: drugName,
      usageType: usageType,
      reminderPeriod: reminderPeriod,
      dailyDose: null,
      oneTimeDose: oneTimeDose,
      doseTimes: [],
      days: days,
      drugCount: drugCount,
      remainingCountNotification: remainingCountNotification,
      boxCode: boxCode,
    );
  }

  MedicationReminderAddEditResult resetDrugCount() {
    return MedicationReminderAddEditResult(
      isCreated: isCreated,
      editCreatedDate: editCreatedDate,
      drugTracking: drugTracking,
      drugName: drugName,
      usageType: usageType,
      reminderPeriod: reminderPeriod,
      dailyDose: dailyDose,
      oneTimeDose: oneTimeDose,
      doseTimes: doseTimes,
      days: days,
      drugCount: null,
      remainingCountNotification: remainingCountNotification,
      boxCode: boxCode,
    );
  }

  MedicationReminderAddEditResult resetRemainingCountNotification() {
    return MedicationReminderAddEditResult(
      isCreated: isCreated,
      editCreatedDate: editCreatedDate,
      drugTracking: drugTracking,
      drugName: drugName,
      usageType: usageType,
      reminderPeriod: reminderPeriod,
      dailyDose: dailyDose,
      oneTimeDose: oneTimeDose,
      doseTimes: doseTimes,
      days: days,
      drugCount: drugCount,
      remainingCountNotification: null,
      boxCode: boxCode,
    );
  }
}
