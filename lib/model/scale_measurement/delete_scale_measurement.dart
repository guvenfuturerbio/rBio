class DeleteScaleMasurementBody {
  DeleteScaleMasurementBody({
    this.measurementId,
    this.entegrationId,
  });

  int measurementId;
  int entegrationId;

  Map<String, dynamic> toJson() => {
        "measurement_id": measurementId,
        "entegration_id": entegrationId,
      };
  factory DeleteScaleMasurementBody.fromJson(Map<String, dynamic> map) =>
      DeleteScaleMasurementBody(
          entegrationId: map['entegration_id'],
          measurementId: map['measurement_id']);
}
