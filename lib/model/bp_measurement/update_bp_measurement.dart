// To parse this JSON data, do
//
//     final updateBpMeasurements = updateBpMeasurementsFromJson(jsonString);

import 'dart:convert';

UpdateBpMeasurements updateBpMeasurementsFromJson(String str) =>
    UpdateBpMeasurements.fromJson(json.decode(str) as Map<String, dynamic>);

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

  int? id;
  int? entegrationId;
  DateTime? occurrenceTime;
  int? sys;
  int? dia;
  int? pulse;
  String? note;
  String? deviceUuid;
  bool? isManual;
  int? measurementId;

  factory UpdateBpMeasurements.fromJson(Map<String, dynamic> json) =>
      UpdateBpMeasurements(
        id: json["id"] as int?,
        entegrationId: json["entegration_id"] as int?,
        occurrenceTime: DateTime.parse(json["occurrence_time"] as String),
        sys: json["sys"] as int?,
        dia: json["dia"] as int?,
        pulse: json["pulse"] as int?,
        note: json["note"] as String?,
        deviceUuid: json["device_uuid"] as String?,
        isManual: json["is_manual"] as bool?,
        measurementId: json["measurement_id"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entegration_id": entegrationId,
        "occurrence_time": occurrenceTime?.toIso8601String(),
        "sys_value": sys,
        "dia_value": dia,
        "pulse_value": pulse,
        "note": note,
        "device_uuid": deviceUuid,
        "is_manual": isManual,
        "measurement_id": measurementId,
      };
}
