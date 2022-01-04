import 'notification_data.dart';
import 'notification_model.dart';

class ChatNotificationModel {
  String to;
  bool contentAvailable;
  NotificationModel notification;
  NotificationData data;

  ChatNotificationModel({
    this.to,
    this.contentAvailable,
    this.notification,
    this.data,
  });

  ChatNotificationModel.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    contentAvailable = json['content_available'];
    notification = json['notification'] != null
        ? new NotificationModel.fromJson(json['notification'])
        : null;
    data = json['data'] != null
        ? new NotificationData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to'] = this.to;
    data['content_available'] = this.contentAvailable;
    if (this.notification != null) {
      data['notification'] = this.notification.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
