import 'dart:convert';

import 'package:onedosehealth/core/core.dart';

class ReminderNotificationModel {
  final int notificationId;
  final Remindable? remindable;
  final String? title;
  final String? description;

  // Notification ertelendikten sonra ertelenen notification'ın id'si.
  final int? baseNotificationId;

  ReminderNotificationModel({
    required this.notificationId,
    this.remindable,
    this.title,
    this.description,
    this.baseNotificationId,
  });

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId,
        'remindable': remindable?.xRawValue,
        'title': title,
        'description': description,
        'baseNotificationId': baseNotificationId,
      };

  factory ReminderNotificationModel.fromJson(Map<String, dynamic> map) =>
      ReminderNotificationModel(
        notificationId: map['notificationId']?.toInt(),
        remindable: map['remindable'] != null
            ? (map['remindable'] as String).xRemindableKeys
            : null,
        title: map['title'],
        description: map['description'],
        baseNotificationId: map['baseNotificationId'],
      );

  String toJsonString() => json.encode(toJson());

  static ReminderNotificationModel? chechIsModel(Object? payload) {
    if (payload is String) {
      final notificationJson = jsonDecode(payload);
      if (notificationJson is Map<String, dynamic>) {
        if (notificationJson.containsKey("notificationId") &&
            notificationJson.containsKey("remindable") &&
            notificationJson.containsKey("title") &&
            notificationJson.containsKey("description") &&
            notificationJson.containsKey("baseNotificationId") &&
            notificationJson.length == 5) {
          final model = ReminderNotificationModel.fromJson(notificationJson);
          return model;
        }
      }
    }

    return null;
  }
}
