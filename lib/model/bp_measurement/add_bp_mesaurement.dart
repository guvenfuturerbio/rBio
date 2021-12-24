// To parse this JSON data, do
//
//     final addBpWithDetail = addBpWithDetailFromJson(jsonString);

import 'dart:convert';

AddBpWithDetail addBpWithDetailFromJson(String str) =>
    AddBpWithDetail.fromJson(json.decode(str));

String addBpWithDetailToJson(AddBpWithDetail data) =>
    json.encode(data.toJson());

class AddBpWithDetail {
  AddBpWithDetail({
    this.entegrationId,
    this.occurrenceTime,
    this.sys,
    this.dia,
    this.pulse,
    this.note,
    this.deviceUuid,
    this.isManual,
  });

  int id;
  int entegrationId;
  DateTime occurrenceTime;
  int sys;
  int dia;
  int pulse;
  String note;
  String deviceUuid;
  bool isManual;
  int measurementId;

  factory AddBpWithDetail.fromJson(Map<String, dynamic> json) =>
      AddBpWithDetail(
        entegrationId: json["entegration_id"],
        occurrenceTime: DateTime.parse(json["occurrence_time"]),
        sys: json["sys_value"],
        dia: json["dia_value"],
        pulse: json["pulse_value"],
        note: json["note"],
        deviceUuid: json["device_uuid"],
        isManual: json["is_manuel"],
      );

  Map<String, dynamic> toJson() => {
        "entegration_id": entegrationId,
        "occurrence_time": occurrenceTime.toIso8601String(),
        "sys_value": sys,
        "dia_value": dia,
        "pulse_value": pulse,
        "note": note,
        "device_uuid": deviceUuid,
        "is_manuel": isManual,
      };
}
