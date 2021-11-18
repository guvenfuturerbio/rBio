// To parse this JSON data, do
//
//     final hba1CForSchedule = hba1CForScheduleFromJson(jsonString);

import 'dart:convert';

Hba1CForSchedule hba1CForScheduleFromJson(String str) =>
    Hba1CForSchedule.fromJson(json.decode(str));

String hba1CForScheduleToJson(Hba1CForSchedule data) =>
    json.encode(data.toJson());

class Hba1CForSchedule {
  Hba1CForSchedule({
    this.id,
    this.lastTestDate,
    this.lastTestValue,
    this.reminderDate,
  });

  int id;
  String lastTestDate;
  String lastTestValue;
  String reminderDate;

  factory Hba1CForSchedule.fromJson(Map<String, dynamic> json) =>
      Hba1CForSchedule(
        id: json["id"],
        lastTestDate: json["last_test_date"],
        lastTestValue: json["last_test_value"],
        reminderDate: json["reminder_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_test_date": lastTestDate,
        "last_test_value": lastTestValue,
        "reminder_date": reminderDate,
      };
}
