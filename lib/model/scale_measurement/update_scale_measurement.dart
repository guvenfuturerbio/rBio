class UpdateScaleMasurementBody {
  UpdateScaleMasurementBody({
    this.id,
    this.entegrationId,
    this.occurrenceTime,
    this.weight,
    this.bmi,
    this.kioskMeasurementId,
    this.water,
    this.bodyFat,
    this.visceralFat,
    this.boneMass,
    this.muscle,
    this.bmh,
    this.scaleUnit,
    this.note,
  });

  int id;
  int entegrationId;
  DateTime occurrenceTime;
  double weight;
  double bmi;
  int kioskMeasurementId;
  double water;
  double bodyFat;
  double visceralFat;
  double boneMass;
  double muscle;
  double bmh;
  int scaleUnit;
  String note;

  factory UpdateScaleMasurementBody.fromJson(Map<String, dynamic> json) =>
      UpdateScaleMasurementBody(
        id: json["measurement_id"],
        entegrationId: json["entegration_id"],
        occurrenceTime: DateTime.parse(json["occurrence_time"]),
        weight: json["weight"],
        bmi: json["bmi"],
        kioskMeasurementId: json["kioskMeasurement_id"],
        water: json["water"],
        bodyFat: json["body_fat"],
        visceralFat: json["visceral_fat"],
        boneMass: json["bone_mass"],
        muscle: json["muscle"],
        bmh: json["bmh"],
        scaleUnit: json["scale_unit"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "measurement_id": id,
        "entegration_id": entegrationId,
        "occurrence_time": occurrenceTime.toIso8601String(),
        "weight": weight,
        "bmi": bmi,
        "kioskMeasurement_id": kioskMeasurementId,
        "water": water,
        "bodyFat": bodyFat,
        "visceral_fat": visceralFat,
        "bone_mass": boneMass,
        "muscle": muscle,
        "bmh": bmh,
        "scale_unit": scaleUnit,
        "note": note,
      };
}
