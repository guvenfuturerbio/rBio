import 'dart:convert';

import 'local_notification_type.dart';

class LocalNotificationModel {
  final LocalNotificationType? type;
  final Object? data;

  LocalNotificationModel({
    this.type,
    this.data,
  });

  Map<String, dynamic> toJson() => {
        'type': type?.xRawValue,
        'data': data,
      };

  factory LocalNotificationModel.fromJson(Map<String, dynamic> map) =>
      LocalNotificationModel(
        type: map['type'] != null
            ? (map['type'] as String).xLocalNotificationType
            : null,
        data: map['data'],
      );

  String toJsonString() => json.encode(toJson());

  static LocalNotificationModel? chechIsModel(String payload) {
    final notificationJson = jsonDecode(payload);
    if (notificationJson is Map<String, dynamic>) {
      if (notificationJson.containsKey("type") &&
          notificationJson.containsKey("data") &&
          notificationJson.length == 2) {
        final model = LocalNotificationModel.fromJson(notificationJson);
        return model;
      }
    }

    return null;
  }
}
