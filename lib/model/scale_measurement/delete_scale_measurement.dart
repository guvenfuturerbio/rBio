class DeleteScaleMasurementBody {
  DeleteScaleMasurementBody({
    this.measurementId,
    this.entegrationId,
  });

  int measurementId;
  int entegrationId;

  Map<String, dynamic> toJson() => {
        "measurement_id": measurementId,
        "entegration_d": entegrationId,
      };
  factory DeleteScaleMasurementBody.fromJson(Map<String, dynamic> map) =>
      DeleteScaleMasurementBody(
          entegrationId: map['entegration_d'],
          measurementId: map['measurement_id']);
}
