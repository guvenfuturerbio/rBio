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
  String firebaseToken;

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
    this.firebaseToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastMessage': lastMessage,
      'lastMessageSender': lastMessageSender,
      'lastMessageType': lastMessageType,
      'messageTime': messageTime,
      'otherHasRead': otherHasRead,
      'hasRead': hasRead,
      'url': url,
      'firebaseToken': firebaseToken,
    };
  }

  factory ChatPerson.fromMap(Map<String, dynamic> map) {
    return ChatPerson(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      lastMessageSender: map['lastMessageSender'] ?? '',
      lastMessageType: map['lastMessageType'] ?? 0,
      messageTime: map['messageTime'] ?? '',
      otherHasRead: map['otherHasRead'] ?? false,
      hasRead: map['hasRead'] ?? false,
      url: map['url'] ??
          "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png",
      firebaseToken: map['firebaseToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatPerson.fromJson(String source) =>
      ChatPerson.fromMap(json.decode(source));
}
