import '../../../../core/core.dart';
import '../../mediminder.dart';

class BloodGlucoseReminderModel
    extends ReminderEntity<BloodGlucoseReminderModel> {
  int? dayIndex;
  int? dosage;
  MedicinePeriod? medicinePeriod;
  UsageType? usageType;

  BloodGlucoseReminderModel({
    required int notificationId,
    required int scheduledDate,
    required int createdDate,
    required int entegrationId,
    this.dayIndex,
    this.dosage,
    this.medicinePeriod,
    this.usageType,
  }) : super(
          notificationId: notificationId,
          remindable: Remindable.bloodGlucose,
          scheduledDate: scheduledDate,
          createdDate: createdDate,
          entegrationId: entegrationId,
        );

  factory BloodGlucoseReminderModel.empty() => BloodGlucoseReminderModel(
        notificationId: -1,
        scheduledDate: -1,
        createdDate: -1,
        entegrationId: -1,
      );

  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    return baseJson
      ..addAll(
        {
          "dayIndex": dayIndex,
          "dosage": dosage,
          "medicinePeriod": medicinePeriod?.xRawValue,
          "usageType": usageType?.xRawValue,
        },
      );
  }

  factory BloodGlucoseReminderModel.fromJson(Map<String, dynamic> json) {
    return BloodGlucoseReminderModel(
      notificationId: json['notificationId'] as int,
      scheduledDate: json['scheduledDate'] as int,
      createdDate: json['createdDate'] as int,
      entegrationId: json['entegrationId'] as int,
      dayIndex: json['dayIndex'] as int?,
      dosage: json['dosage'] as int?,
      medicinePeriod: json['medicinePeriod'] == null
          ? null
          : (json['medicinePeriod'] as String).xMedicinePeriodKeys,
      usageType: json['usageType'] == null
          ? null
          : (json['usageType'] as String).xUsageTypeKeys,
    );
  }

  BloodGlucoseReminderModel changeScheduledDate({int? scheduledDate}) =>
      BloodGlucoseReminderModel(
        notificationId: notificationId,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        createdDate: createdDate,
        entegrationId: entegrationId,
        dayIndex: dayIndex,
        dosage: dosage,
        medicinePeriod: medicinePeriod,
        usageType: usageType,
      );

  @override
  BloodGlucoseReminderModel fromJson(Map<String, dynamic> json) {
    return BloodGlucoseReminderModel.fromJson(json);
  }
}
