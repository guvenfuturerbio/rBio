// To parse this JSON data, do
//
//     final updateBpMeasurements = updateBpMeasurementsFromJson(jsonString);

import 'dart:convert';

UpdateBpMeasurements updateBpMeasurementsFromJson(String str) =>
    UpdateBpMeasurements.fromJson(json.decode(str));

String updateBpMeasurementsToJson(UpdateBpMeasurements data) =>
    json.encode(data.toJson());

class UpdateBpMeasurements {
  UpdateBpMeasurements({
    this.id,
    this.entegrationId,
    this.occurrenceTime,
    this.sys,
    this.dia,
    this.pulse,
    this.note,
    this.deviceUuid,
    this.isManual,
    this.measurementId,
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

  factory UpdateBpMeasurements.fromJson(Map<String, dynamic> json) =>
      UpdateBpMeasurements(
        id: json["id"],
        entegrationId: json["entegration_id"],
        occurrenceTime: DateTime.parse(json["occurrence_time"]),
        sys: json["sys"],
        dia: json["dia"],
        pulse: json["pulse"],
        note: json["note"],
        deviceUuid: json["device_uuid"],
        isManual: json["is_manual"],
        measurementId: json["measurement_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entegration_id": entegrationId,
        "occurrence_time": occurrenceTime.toIso8601String(),
        "sys": sys,
        "dia": dia,
        "pulse": pulse,
        "note": note,
        "device_uuid": deviceUuid,
        "is_manual": isManual,
        "measurement_id": measurementId,
      };
}
