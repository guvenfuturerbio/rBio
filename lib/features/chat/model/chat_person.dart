import 'dart:convert';

class ChatPerson {
  String name;
  String id;
  String lastMessage;
  String lastMessageSender;
  int lastMessageType; // 0 : Text, 1 : Image
  String messageTime;
  bool hasRead;
  bool otherHasRead;
  String url;

  ChatPerson({
    this.name,
    this.id,
    this.lastMessage,
    this.lastMessageSender,
    this.lastMessageType,
    this.messageTime,
    this.hasRead = true,
    this.otherHasRead = false,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'lastMessage': lastMessage,
      'messageTime': messageTime,
      'hasRead': hasRead,
      'url': url,
    };
  }

  factory ChatPerson.fromMap(Map<String, dynamic> map) {
    return ChatPerson(
        name: map['name'] ?? '',
        id: map['id'] ?? '',
        lastMessage: map['lastMessage'] ?? '',
        messageTime: map['messageTime'] ?? '',
        hasRead: map['hasRead'] ?? false,
        url: map['url'] ??
            "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png");
  }

  String toJson() => json.encode(toMap());

  factory ChatPerson.fromJson(String source) =>
      ChatPerson.fromMap(json.decode(source));
}
