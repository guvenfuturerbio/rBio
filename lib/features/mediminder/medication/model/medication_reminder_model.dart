import '../../../../core/core.dart';
import '../../mediminder.dart';

class MedicationReminderModel extends ReminderEntity<MedicationReminderModel> {
  String? name;
  int? dayIndex;
  int? dosage;
  MedicinePeriod? medicinePeriod;
  UsageType? usageType;

  MedicationReminderModel({
    required int notificationId,
    required int scheduledDate,
    required int createdDate,
    required int entegrationId,
    this.name,
    this.dayIndex,
    this.dosage,
    this.medicinePeriod,
    this.usageType,
  }) : super(
          notificationId: notificationId,
          remindable: Remindable.medication,
          scheduledDate: scheduledDate,
          createdDate: createdDate,
          entegrationId: entegrationId,
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

  factory MedicationReminderModel.fromJson(Map<String, dynamic> json) {
    return MedicationReminderModel(
      notificationId: json['notificationId'] as int,
      scheduledDate: json['scheduledDate'] as int,
      createdDate: json['createdDate'] as int,
      entegrationId: json['entegrationId'] as int,
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

  MedicationReminderModel changeScheduledDate({int? scheduledDate}) =>
      MedicationReminderModel(
        notificationId: notificationId,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        createdDate: createdDate,
        entegrationId: entegrationId,
        name: name,
        dayIndex: dayIndex,
        dosage: dosage,
        medicinePeriod: medicinePeriod,
        usageType: usageType,
      );

  @override
  MedicationReminderModel fromJson(Map<String, dynamic> json) {
    return MedicationReminderModel.fromJson(json);
  }
}
