import 'package:onedosehealth/features/chat/model/chat_person.dart';

class NotificationData {
  String? type;
  String? title;
  String? body;
  ChatPerson? chatPerson;

  NotificationData({this.type, this.title, this.body, this.chatPerson});

  NotificationData.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String?;
    title = json['title']as String?;
    body = json['body']as String?;
    chatPerson = json['chatPerson'] != null
        ?  ChatPerson.fromMap(json['chatPerson']as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['title'] = title;
    data['body'] = body;
    if (chatPerson != null) {
      data['chatPerson'] = chatPerson?.toMap();
    }
    return data;
  }
}
