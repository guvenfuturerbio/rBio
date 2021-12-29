import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPerson {
  String name;
  String id;
  String lastMessage;
  String messageTime;
  bool hasRead;
  String url;
  Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  ChatPerson({
    this.name,
    this.id,
    this.lastMessage,
    this.messageTime,
    this.hasRead = true,
    this.url,
    this.stream
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
