import 'dart:convert';

class AvailableDate {
  bool available;
  DateTime date;
  AvailableDate({
    this.available,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'available': available,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory AvailableDate.fromMap(Map<String, dynamic> map) {
    return AvailableDate(
      available: map['available'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailableDate.fromJson(String source) =>
      AvailableDate.fromMap(json.decode(source));
}
