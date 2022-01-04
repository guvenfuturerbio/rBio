import 'package:onedosehealth/features/chat/model/chat_person.dart';

class NotificationData {
  String type;
  String title;
  String body;
  ChatPerson chatPerson;

  NotificationData({this.type, this.title, this.body, this.chatPerson});

  NotificationData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    body = json['body'];
    chatPerson = json['chatPerson'] != null
        ? new ChatPerson.fromMap(json['chatPerson'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['body'] = this.body;
    if (this.chatPerson != null) {
      data['chatPerson'] = this.chatPerson.toMap();
    }
    return data;
  }
}
