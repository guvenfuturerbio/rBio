import 'dart:convert';

String addScaleMasurementBodyToJson(AddScaleMasurementBody data) =>
    json.encode(data.toJson());

class AddScaleMasurementBody {
  AddScaleMasurementBody({
    this.entegrationId,
    this.occurrenceTime,
    this.weight,
    this.bmi,
    this.water,
    this.bodyFat,
    this.visceralFat,
    this.boneMass,
    this.muscle,
    this.bmh,
    this.scaleUnit,
    this.note,
  });

  int entegrationId;
  DateTime occurrenceTime;
  int weight;
  int bmi;
  int water;
  int bodyFat;
  int visceralFat;
  int boneMass;
  int muscle;
  int bmh;
  int scaleUnit;
  String note;

  Map<String, dynamic> toJson() => {
        "entegration_id": entegrationId,
        "occurrence_time": occurrenceTime.toIso8601String(),
        "weight": weight,
        "bmi": bmi,
        "water": water,
        "body_fat": bodyFat,
        "visceral_fat": visceralFat,
        "bone_mass": boneMass,
        "muscle": muscle,
        "bmh": bmh,
        "scale_unit": scaleUnit,
        "note": note,
      };
}
