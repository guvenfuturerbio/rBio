import 'package:onedosehealth/core/core.dart';

class DoctorBMIPatientModel {
  String name;
  List<DoctorBMIMeasurements> bmiMeasurements;
  int id;

  DoctorBMIPatientModel({
    this.name,
    this.bmiMeasurements,
    this.id,
  });

  DoctorBMIPatientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['bmi_measurements'] != null) {
      bmiMeasurements = new List<DoctorBMIMeasurements>();
      json['bmi_measurements'].forEach((v) {
        bmiMeasurements.add(new DoctorBMIMeasurements.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.bmiMeasurements != null) {
      data['bmi_measurements'] =
          this.bmiMeasurements.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class DoctorBMIMeasurements {
  int id;
  int entegrationId;
  String occurrenceTime;
  double weight;
  double bmi;
  int measurementId;
  double water;
  double bodyFat;
  double visceralFat;
  double boneMass;
  double muscle;
  double bmh;
  int scaleUnit;
  String deviceId;
  bool isManuel;
  String note;

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
    id = json['id'];
    entegrationId = json['entegration_id'];
    occurrenceTime = json['occurrence_time'];
    weight = json['weight'];
    bmi = json['bmi'];
    measurementId = json['measurement_id'];
    water = json['water'];
    bodyFat = json['body_fat'];
    visceralFat = json['visceral_fat'];
    boneMass = json['bone_mass'];
    muscle = json['muscle'];
    bmh = json['bmh'];
    scaleUnit = json['scale_unit'];
    deviceId = json['device_id'];
    isManuel = json['is_manuel'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entegration_id'] = this.entegrationId;
    data['occurrence_time'] = this.occurrenceTime;
    data['weight'] = this.weight;
    data['bmi'] = this.bmi;
    data['measurement_id'] = this.measurementId;
    data['water'] = this.water;
    data['body_fat'] = this.bodyFat;
    data['visceral_fat'] = this.visceralFat;
    data['bone_mass'] = this.boneMass;
    data['muscle'] = this.muscle;
    data['bmh'] = this.bmh;
    data['scale_unit'] = this.scaleUnit;
    data['device_id'] = this.deviceId;
    data['is_manuel'] = this.isManuel;
    data['note'] = this.note;
    return data;
  }
}
