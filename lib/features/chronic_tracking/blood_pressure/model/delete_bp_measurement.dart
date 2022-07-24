class DeleteBpMeasurements {
  int? measurementId;
  int? entegrationId;

  DeleteBpMeasurements({
    this.measurementId,
    this.entegrationId,
  });

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
