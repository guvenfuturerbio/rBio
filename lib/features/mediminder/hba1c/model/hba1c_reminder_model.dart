import '../../../../core/core.dart';
import '../../mediminder.dart';

class Hba1CReminderModel extends ReminderEntity {
  String? lastTestDate;
  String? lastTestValue;

  Hba1CReminderModel({
    required int notificationId,
    required int scheduledDate,
    required int createdDate,
    this.lastTestDate,
    this.lastTestValue,
  }) : super(
          notificationId: notificationId,
          remindable: Remindable.hbA1c,
          scheduledDate: scheduledDate,
          createdDate: createdDate,
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
    final baseModel = ReminderEntity.fromJson(json);
    return Hba1CReminderModel(
      notificationId: baseModel.notificationId,
      scheduledDate: baseModel.scheduledDate,
      createdDate: baseModel.createdDate,
      lastTestDate: json['lastTestDate'] as String?,
      lastTestValue: json['lastTestValue'] as String?,
    );
  }
}
