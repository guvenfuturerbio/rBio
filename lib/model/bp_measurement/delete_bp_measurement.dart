// To parse this JSON data, do
//
//     final deleteBpMeasurements = deleteBpMeasurementsFromJson(jsonString);

import 'dart:convert';

DeleteBpMeasurements deleteBpMeasurementsFromJson(String str) =>
    DeleteBpMeasurements.fromJson(json.decode(str) as Map<String, dynamic>);

String deleteBpMeasurementsToJson(DeleteBpMeasurements data) =>
    json.encode(data.toJson());

class DeleteBpMeasurements {
  DeleteBpMeasurements({
    this.measurementId,
    this.entegrationId,
  });

  int? measurementId;
  int? entegrationId;

  factory DeleteBpMeasurements.fromJson(Map<String, dynamic> json) =>
      DeleteBpMeasurements(
        measurementId: json["measurement_id"] as int?,
        entegrationId: json["entegration_id"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "measurement_id": measurementId,
        "entegration_id": entegrationId,
      };
}
