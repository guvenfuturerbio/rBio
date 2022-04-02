import '../../../../core/core.dart';
import '../../mediminder.dart';

class BloodGlucoseReminderModel extends ReminderEntity {
  String? name;
  int? dayIndex;
  int? dosage;
  MedicinePeriod? medicinePeriod;
  UsageType? usageType;

  BloodGlucoseReminderModel({
    required int notificationId,
    required int scheduledDate,
    required int createdDate,
    this.name,
    this.dayIndex,
    this.dosage,
    this.medicinePeriod,
    this.usageType,
  }) : super(
          notificationId: notificationId,
          remindable: Remindable.bloodGlucose,
          scheduledDate: scheduledDate,
          createdDate: createdDate,
        );

  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    return baseJson
      ..addAll(
        {
          "name": name,
          "dayIndex": dayIndex,
          "dosage": dosage,
          "medicinePeriod": medicinePeriod?.xRawValue,
          "usageType": usageType?.xRawValue,
        },
      );
  }

  factory BloodGlucoseReminderModel.fromJson(Map<String, dynamic> json) {
    final baseModel = ReminderEntity.fromJson(json);
    return BloodGlucoseReminderModel(
      notificationId: baseModel.notificationId,
      scheduledDate: baseModel.scheduledDate,
      createdDate: baseModel.createdDate,
      name: json['name'] as String?,
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
        name: name,
        dayIndex: dayIndex,
        dosage: dosage,
        medicinePeriod: medicinePeriod,
        usageType: usageType,
      );
}
