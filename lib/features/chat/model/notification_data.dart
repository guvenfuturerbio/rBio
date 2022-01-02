import 'package:onedosehealth/features/chat/model/chat_person.dart';

class NotificationData {
  String type;
  ChatPerson chatPerson;

  NotificationData({this.type, this.chatPerson});

  NotificationData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    chatPerson = json['chatPerson'] != null
        ? new ChatPerson.fromMap(json['chatPerson'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.chatPerson != null) {
      data['chatPerson'] = this.chatPerson.toMap();
    }
    return data;
  }
}
