class Message {
  final String? sentFrom;
  final String? message;
  final int? date;
  final int? type; //0 text //1 image

  Message({
    this.sentFrom,
    this.message,
    this.type,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'sentFrom': sentFrom,
      'message': message,
      'date': date,
      'type': type,
    };
  }

  Message.fromMap(Map<String, dynamic> map)
      : sentFrom = map['sentFrom']as String?,
        message = map['message']as String?,
        date = map['date']as int?,
        type = map['type']as int?;
}
