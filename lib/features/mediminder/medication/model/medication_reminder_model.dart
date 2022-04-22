import '../../../../core/core.dart';
import '../../mediminder.dart';

class MedicationReminderModel extends ReminderEntity<MedicationReminderModel> {
  DrugTracking? drugTracking;
  String? drugName;
  UsageType? usageType;
  ReminderPeriod? reminderPeriod;
  int? dayIndex;
  int? dailyDose;
  int? oneTimeDose;
  int? drugCount;
  int? remainingCountNotification;
  String? boxCode;

  MedicationReminderModel({
    required int notificationId,
    required int scheduledDate,
    required int createdDate,
    required int entegrationId,
    required bool status,
    this.drugTracking,
    this.drugName,
    this.usageType,
    this.reminderPeriod,
    this.dayIndex,
    this.dailyDose,
    this.oneTimeDose,
    this.drugCount,
    this.remainingCountNotification,
    this.boxCode,
  }) : super(
          notificationId: notificationId,
          remindable: Remindable.medication,
          scheduledDate: scheduledDate,
          createdDate: createdDate,
          entegrationId: entegrationId,
          status: status,
        );

  factory MedicationReminderModel.empty() => MedicationReminderModel(
        notificationId: -1,
        scheduledDate: -1,
        createdDate: -1,
        entegrationId: -1,
        status: true,
      );

  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    return baseJson
      ..addAll(
        {
          "drugTracking": drugTracking?.xRawValue,
          "drugName": drugName,
          "usageType": usageType?.xRawValue,
          "reminderPeriod": reminderPeriod?.xRawValue,
          "dayIndex": dayIndex,
          "dailyDose": dailyDose,
          "oneTimeDose": oneTimeDose,
          'drugCount': drugCount,
          'remainingCountNotification': remainingCountNotification,
          'boxCode': boxCode,
        },
      );
  }

  factory MedicationReminderModel.fromJson(Map<String, dynamic> json) {
    return MedicationReminderModel(
      notificationId: json['notificationId'] as int,
      scheduledDate: json['scheduledDate'] as int,
      createdDate: json['createdDate'] as int,
      entegrationId: json['entegrationId'] as int,
      status: json['status'] as bool,
      drugTracking: json['drugTracking'] == null
          ? null
          : (json['drugTracking'] as String).xGetDrugTracking,
      drugName: json['drugName'] as String?,
      usageType: json['usageType'] == null
          ? null
          : (json['usageType'] as String).xGetUsageType,
      reminderPeriod: json['reminderPeriod'] == null
          ? null
          : (json['reminderPeriod'] as String).xGetReminderPeriod,
      dayIndex: json['dayIndex'] as int?,
      dailyDose: json['dailyDose'] as int?,
      oneTimeDose: json['oneTimeDose'] as int?,
      drugCount: json['drugCount'] as int?,
      remainingCountNotification: json['remainingCountNotification'] as int?,
      boxCode: json['boxCode'] as String?,
    );
  }

  @override
  MedicationReminderModel fromJson(Map<String, dynamic> json) {
    return MedicationReminderModel.fromJson(json);
  }

  MedicationReminderModel changeStatus(bool newStatus) {
    return MedicationReminderModel(
      status: newStatus,
      notificationId: notificationId,
      scheduledDate: scheduledDate,
      createdDate: createdDate,
      entegrationId: entegrationId,
      drugTracking: drugTracking,
      drugName: drugName,
      usageType: usageType,
      reminderPeriod: reminderPeriod,
      dayIndex: dayIndex,
      dailyDose: dailyDose,
      oneTimeDose: oneTimeDose,
      drugCount: drugCount,
      remainingCountNotification: remainingCountNotification,
      boxCode: boxCode,
    );
  }

  MedicationReminderModel addDrugCount(int newValue) =>
      MedicationReminderModel(
        createdDate: createdDate,
        entegrationId: entegrationId,
        notificationId: notificationId,
        scheduledDate: scheduledDate,
        status: status,
        drugTracking: drugTracking,
        drugName: drugName,
        usageType: usageType,
        reminderPeriod: reminderPeriod,
        dayIndex: dayIndex,
        dailyDose: dailyDose,
        oneTimeDose: oneTimeDose,
        drugCount: (drugCount ?? 0) + newValue,
        remainingCountNotification: remainingCountNotification,
        boxCode: boxCode,
      );
}
