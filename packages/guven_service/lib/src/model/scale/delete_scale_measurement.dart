class DeleteScaleMasurementBody {
  int? measurementId;
  int? entegrationId;

  DeleteScaleMasurementBody({
    this.measurementId,
    this.entegrationId,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "measurement_id": measurementId,
        "entegration_id": entegrationId,
      };

  factory DeleteScaleMasurementBody.fromJson(Map<String, dynamic> map) =>
      DeleteScaleMasurementBody(
        entegrationId: map['entegration_id'] as int?,
        measurementId: map['measurement_id'] as int?,
      );
}
