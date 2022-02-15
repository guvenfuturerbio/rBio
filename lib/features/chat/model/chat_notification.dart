import 'notification_data.dart';
import 'notification_model.dart';

class ChatNotificationModel {
  String? to;
  bool? contentAvailable;
  NotificationModel? notification;
  NotificationData? data;

  ChatNotificationModel({
    this.to,
    this.contentAvailable,
    this.notification,
    this.data,
  });

  ChatNotificationModel.fromJson(Map<String, dynamic> json) {
    to = json['to'] as String;
    contentAvailable = json['content_available'] as bool?;
    notification = json['notification'] != null
        ?  NotificationModel.fromJson(json['notification'] as Map<String, dynamic> )
        : null;
    data = json['data'] != null
        ?  NotificationData.fromJson(json['data'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['to'] = to;
    data['content_available'] = contentAvailable;
    if (notification != null) {
      data['notification'] = notification?.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}
