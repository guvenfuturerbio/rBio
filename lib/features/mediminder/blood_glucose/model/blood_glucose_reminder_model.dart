import '../../../../core/core.dart';
import '../../mediminder.dart';

class BloodGlucoseReminderModel
    extends ReminderEntity<BloodGlucoseReminderModel> {
  int? dayIndex;
  int? dailyDose;
  ReminderPeriod? reminderPeriod;
  UsageType? usageType;

  BloodGlucoseReminderModel({
    required int notificationId,
    required int scheduledDate,
    required int createdDate,
    required int entegrationId,
    required String? nameAndSurname,
    required bool status,
    this.dayIndex,
    this.dailyDose,
    this.reminderPeriod,
    this.usageType,
  }) : super(
          notificationId: notificationId,
          remindable: Remindable.bloodGlucose,
          scheduledDate: scheduledDate,
          createdDate: createdDate,
          entegrationId: entegrationId,
          nameAndSurname: nameAndSurname,
          status: status,
        );

  factory BloodGlucoseReminderModel.empty() => BloodGlucoseReminderModel(
        notificationId: -1,
        scheduledDate: -1,
        createdDate: -1,
        entegrationId: -1,
        nameAndSurname: '',
        status: true,
      );

  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    return baseJson
      ..addAll(
        {
          "dayIndex": dayIndex,
          "dailyDose": dailyDose,
          "reminderPeriod": reminderPeriod?.xRawValue,
          "usageType": usageType?.xRawValue,
        },
      );
  }

  factory BloodGlucoseReminderModel.fromJson(Map<String, dynamic> json) {
    return BloodGlucoseReminderModel(
      notificationId: json['notificationId'] as int,
      scheduledDate: json['scheduledDate'] as int,
      createdDate: json['createdDate'] as int,
      nameAndSurname: json['nameAndSurname'] as String,
      entegrationId: json['entegrationId'] as int,
      status: json['status'] as bool,
      dayIndex: json['dayIndex'] as int?,
      dailyDose: json['dailyDose'] as int?,
      reminderPeriod: json['reminderPeriod'] == null
          ? null
          : (json['reminderPeriod'] as String).xGetReminderPeriod,
      usageType: json['usageType'] == null
          ? null
          : (json['usageType'] as String).xGetUsageType,
    );
  }

  @override
  BloodGlucoseReminderModel fromJson(Map<String, dynamic> json) {
    return BloodGlucoseReminderModel.fromJson(json);
  }

  BloodGlucoseReminderModel changeStatus(bool newStatus) {
    return BloodGlucoseReminderModel(
      status: newStatus,
      notificationId: notificationId,
      scheduledDate: scheduledDate,
      createdDate: createdDate,
      nameAndSurname: nameAndSurname,
      entegrationId: entegrationId,
      dayIndex: dayIndex,
      dailyDose: dailyDose,
      reminderPeriod: reminderPeriod,
      usageType: usageType,
    );
  }
}
