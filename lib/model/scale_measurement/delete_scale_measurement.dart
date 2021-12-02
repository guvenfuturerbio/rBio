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
}
