import 'dart:convert';

class ChatPerson {
  String? name;
  String? id;
  String? lastMessage;
  String? lastMessageSender;
  int? lastMessageType; // 0 : Text, 1 : Image
  String? messageTime;
  bool? hasRead;
  bool? otherHasRead;
  int? timestamp;
  String? url;
  String? firebaseToken;

  ChatPerson({
    required this.name,
    required this.id,
    this.lastMessage,
    this.lastMessageSender,
    this.lastMessageType,
    this.messageTime,
    this.timestamp,
    this.hasRead = true,
    this.otherHasRead = false,
    this.url = "",
    required this.firebaseToken,
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
      name: map['name']as String? ?? '' ,
      id: map['id']as String? ?? '',
      lastMessage: map['lastMessage']as String? ?? '',
      lastMessageSender: map['lastMessageSender']as String? ?? '',
      lastMessageType: map['lastMessageType'] as int? ?? 0,
      messageTime: map['messageTime'] as String? ?? '',
      otherHasRead: map['otherHasRead']as bool? ?? false,
      hasRead: map['hasRead']as bool? ?? false,
      url: map['url']as String? ??
          "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png",
      firebaseToken: map['firebaseToken']as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatPerson.fromJson(String source) =>
      ChatPerson.fromMap(json.decode(source)as Map<String, dynamic>);
}
