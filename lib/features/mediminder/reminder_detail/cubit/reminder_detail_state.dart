part of 'reminder_detail_cubit.dart';

@freezed
class ReminderDetailState with _$ReminderDetailState {
  const factory ReminderDetailState.initial() = ReminderDetailInitial;
  const factory ReminderDetailState.loadInProgress() = ReminderDetailLoadInProgress;
  const factory ReminderDetailState.success(ReminderDetailResult result) = ReminderDetailSuccess;
  const factory ReminderDetailState.empty() = ReminderDetailEmpty;
  const factory ReminderDetailState.failure() = ReminderDetailFailure;
  const factory ReminderDetailState.openListScreen() = ReminderDetailOpenListScreen;
}

@freezed
class ReminderDetailResult with _$ReminderDetailResult {
  const factory ReminderDetailResult.hba1C(Hba1CReminderModel model) = ReminderDetailHba1C;
  const factory ReminderDetailResult.bloodGlucose(List<BloodGlucoseReminderModel> list) = ReminderDetailBloodGlucose;
  const factory ReminderDetailResult.medication(List<MedicationReminderModel> list) = ReminderDetailMedication;
}

class ReminderChangeTimeStatus {
  int notificationId;
  bool value;
  tz.TZDateTime dateTime;
  List<ExpandableHoursModel> list;
  BloodGlucoseReminderModel? bloodGlucoseModel;
  MedicationReminderModel? medicationModel;

  ReminderChangeTimeStatus({
    required this.notificationId,
    required this.value,
    required this.dateTime,
    required this.list,
    this.bloodGlucoseModel,
    this.medicationModel,
  });
}
