import '../../../../core/core.dart';

abstract class ReminderEntity<T> {
  final int notificationId;
  final Remindable remindable;
  final int scheduledDate;
  final int createdDate;
  final int entegrationId;

  ReminderEntity({
    required this.notificationId,
    required this.remindable,
    required this.scheduledDate,
    required this.createdDate,
    required this.entegrationId,
  });

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId,
        'remindable': remindable.xRawValue,
        'scheduledDate': scheduledDate,
        'createdDate': createdDate,
        'entegrationId': entegrationId,
      };
}
