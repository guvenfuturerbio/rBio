import 'local_notification_type.dart';

class LocalNotificationModel {
  final LocalNotificationType? type;
  final Map<String, dynamic>? data;

  LocalNotificationModel({
    this.type,
    this.data,
  });

  Map<String, dynamic> toJson() => {
        'type': type?.xRawValue,
        'data': data,
      };

  factory LocalNotificationModel.fromMap(Map<String, dynamic> map) =>
      LocalNotificationModel(
        type: map['type'] != null
            ? (map['type'] as String).xLocalNotificationType
            : null,
        data:
            map['data'] != null ? Map<String, dynamic>.from(map['data']) : null,
      );
}
