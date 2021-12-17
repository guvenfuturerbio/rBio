// To parse this JSON data, do
//
//     final deleteBpMeasurements = deleteBpMeasurementsFromJson(jsonString);

import 'dart:convert';

DeleteBpMeasurements deleteBpMeasurementsFromJson(String str) =>
    DeleteBpMeasurements.fromJson(json.decode(str));

String deleteBpMeasurementsToJson(DeleteBpMeasurements data) =>
    json.encode(data.toJson());

class DeleteBpMeasurements {
  DeleteBpMeasurements({
    this.measurementId,
    this.entegrationId,
  });

  int measurementId;
  int entegrationId;

  factory DeleteBpMeasurements.fromJson(Map<String, dynamic> json) =>
      DeleteBpMeasurements(
        measurementId: json["measurement_id"],
        entegrationId: json["entegration_id"],
      );

  Map<String, dynamic> toJson() => {
        "measurement_id": measurementId,
        "entegration_id": entegrationId,
      };
}
