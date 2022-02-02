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

  int? id;
  int? entegrationId;
  DateTime? occurrenceTime;
  double? weight;
  double? bmi;
  int? kioskMeasurementId;
  double? water;
  double? bodyFat;
  double? visceralFat;
  double? boneMass;
  double? muscle;
  double? bmh;
  int? scaleUnit;
  String? note;

  factory UpdateScaleMasurementBody.fromJson(Map<String, dynamic> json) =>
      UpdateScaleMasurementBody(
        id: json["measurement_id"] as int?,
        entegrationId: json["entegration_id"] as int?,
        occurrenceTime: DateTime.parse(json["occurrence_time"] as String),
        weight: json["weight"] as double?,
        bmi: json["bmi"] as double?,
        kioskMeasurementId: json["kioskMeasurement_id"] as int?,
        water: json["water"] as double?,
        bodyFat: json["body_fat"] as double?,
        visceralFat: json["visceral_fat"] as double?,
        boneMass: json["bone_mass"] as double?,
        muscle: json["muscle"] as double?,
        bmh: json["bmh"] as double?,
        scaleUnit: json["scale_unit"] as int?,
        note: json["note"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "measurement_id": id,
        "entegration_id": entegrationId,
        "occurrence_time": occurrenceTime?.toIso8601String(),
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
