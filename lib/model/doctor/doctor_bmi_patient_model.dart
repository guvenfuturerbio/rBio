class DoctorBMIPatientModel {
  String? name;
  List<DoctorBMIMeasurements>? bmiMeasurements;
  int? id;

  DoctorBMIPatientModel({
    this.name,
    this.bmiMeasurements,
    this.id,
  });

  DoctorBMIPatientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    if (json['bmi_measurements'] != null) {
      bmiMeasurements = <DoctorBMIMeasurements>[];
      json['bmi_measurements'].forEach((v) {
        bmiMeasurements
            ?.add(DoctorBMIMeasurements.fromJson(v as Map<String, dynamic>));
      });
    }
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (bmiMeasurements != null) {
      data['bmi_measurements'] =
          bmiMeasurements?.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class DoctorBMIMeasurements {
  int? id;
  int? entegrationId;
  String? occurrenceTime;
  double? weight;
  double? bmi;
  int? measurementId;
  double? water;
  double? bodyFat;
  double? visceralFat;
  double? boneMass;
  double? muscle;
  double? bmh;
  int? scaleUnit;
  String? deviceId;
  bool? isManuel;
  String? note;

  DoctorBMIMeasurements({
    this.id,
    this.entegrationId,
    this.occurrenceTime,
    this.weight,
    this.bmi,
    this.measurementId,
    this.water,
    this.bodyFat,
    this.visceralFat,
    this.boneMass,
    this.muscle,
    this.bmh,
    this.scaleUnit,
    this.deviceId,
    this.isManuel,
    this.note,
  });

  DoctorBMIMeasurements.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    entegrationId = json['entegration_id'] as int?;
    occurrenceTime = json['occurrence_time'] as String?;
    weight = json['weight'] as double?;
    bmi = json['bmi'] as double?;
    measurementId = json['measurement_id'] as int?;
    water = json['water'] as double?;
    bodyFat = json['body_fat'] as double?;
    visceralFat = json['visceral_fat'] as double?;
    boneMass = json['bone_mass'] as double?;
    muscle = json['muscle'] as double?;
    bmh = json['bmh'] as double?;
    scaleUnit = json['scale_unit'] as int?;
    deviceId = json['device_id'] as String?;
    isManuel = json['is_manuel'] as bool?;
    note = json['note'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['entegration_id'] = entegrationId;
    data['occurrence_time'] = occurrenceTime;
    data['weight'] = weight;
    data['bmi'] = bmi;
    data['measurement_id'] = measurementId;
    data['water'] = water;
    data['body_fat'] = bodyFat;
    data['visceral_fat'] = visceralFat;
    data['bone_mass'] = boneMass;
    data['muscle'] = muscle;
    data['bmh'] = bmh;
    data['scale_unit'] = scaleUnit;
    data['device_id'] = deviceId;
    data['is_manuel'] = isManuel;
    data['note'] = note;
    return data;
  }
}
