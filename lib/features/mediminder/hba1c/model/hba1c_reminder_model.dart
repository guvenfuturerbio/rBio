import '../../../../core/core.dart';
import '../../mediminder.dart';

class Hba1CReminderModel extends ReminderEntity<Hba1CReminderModel> {
  String? lastTestDate;
  String? lastTestValue;

  Hba1CReminderModel({
    required int notificationId,
    required int scheduledDate,
    required int createdDate,
    required int entegrationId,
    this.lastTestDate,
    this.lastTestValue,
  }) : super(
          notificationId: notificationId,
          remindable: Remindable.hbA1c,
          scheduledDate: scheduledDate,
          createdDate: createdDate,
          entegrationId: entegrationId,
        );

  factory Hba1CReminderModel.empty() => Hba1CReminderModel(
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
          'lastTestDate': lastTestDate,
          'lastTestValue': lastTestValue,
        },
      );
  }

  factory Hba1CReminderModel.fromJson(Map<String, dynamic> json) {
    return Hba1CReminderModel(
      notificationId: json['notificationId'] as int,
      scheduledDate: json['scheduledDate'] as int,
      createdDate: json['createdDate'] as int,
      entegrationId: json['entegrationId'] as int,
      lastTestDate: json['lastTestDate'] as String?,
      lastTestValue: json['lastTestValue'] as String?,
    );
  }

  @override
  Hba1CReminderModel fromJson(Map<String, dynamic> json) {
    return Hba1CReminderModel.fromJson(json);
  }
}
