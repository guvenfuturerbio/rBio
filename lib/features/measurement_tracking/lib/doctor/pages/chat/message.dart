
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String sentTo;
  final String sentFrom;
  final String message;
  final Timestamp date;
  final int type; //0 text //1 image

  Message({this.sentTo, this.sentFrom, this.message,this.type, this.date});
  Map<String, dynamic> toMap() {
    return {
      'sentTo': sentTo,
      'sentFrom': sentFrom,
      'message': message,
      'date': date ?? FieldValue.serverTimestamp(),
      'type' : type,
    };
  }

  Message.fromMap(Map<String, dynamic> map)
      : this.sentTo = map['sentTo'],
        this.sentFrom = map['sentFrom'],
        this.message = map['message'],
        this.date = map['date'] ,
        this.type = map['type'];
 }
