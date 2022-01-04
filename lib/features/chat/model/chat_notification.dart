import 'package:onedosehealth/features/chat/model/notification_data.dart';

class ChatNotificationModel {
  String to;
  bool contentAvailable;
  NotificationData data;

  ChatNotificationModel({this.to, this.contentAvailable, this.data});

  ChatNotificationModel.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    contentAvailable = json['content_available'];
    data = json['data'] != null
        ? new NotificationData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to'] = this.to;
    data['content_available'] = this.contentAvailable;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
