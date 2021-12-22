import 'diabet_type.dart';

class DoctorGlucosePatientModel {
  String name;
  DiabetType diabetType;
  List<DoctorGlucosePatientMeasurementModel> measurements;
  int entegrationId;
  double normalMin;
  double normalMax;
  double alertMin;
  double alertMax;
  double target;
  int id;

  DoctorGlucosePatientModel({
    this.name,
    this.diabetType,
    this.entegrationId,
    this.normalMin,
    this.normalMax,
    this.alertMin,
    this.alertMax,
    this.target,
    this.id,
  });

  DoctorGlucosePatientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    diabetType = json['diabet_type'] != null
        ? new DiabetType.fromJson(json['diabet_type'])
        : null;
    if (json['measurements'] != null) {
      measurements = new List<DoctorGlucosePatientMeasurementModel>();
      json['measurements'].forEach((v) {
        measurements.add(new DoctorGlucosePatientMeasurementModel.fromJson(v));
      });
    }
    entegrationId = json['entegration_id'];
    normalMax = json['normal_max'] as double;
    normalMin = json['normal_min'] as double;
    alertMin = json['alert_min'] as double;
    alertMax = json['alert_max'] as double;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.diabetType != null) {
      data['diabet_type'] = this.diabetType.toJson();
    }
    if (this.measurements != null) {
      data['measurements'] = this.measurements.map((v) => v.toJson()).toList();
    }
    data['entegration_id'] = this.entegrationId;
    data['normal_max'] = this.normalMax;
    data['normal_min'] = this.normalMin;
    data['alert_min'] = this.alertMin;
    data['alert_max'] = this.alertMax;
    data['target'] = this.target;
    data['id'] = this.id;
    return data;
  }
}

class DoctorGlucosePatientMeasurementModel {
  String measurement;
  String measurementTime;

  DoctorGlucosePatientMeasurementModel(
      {this.measurement, this.measurementTime});

  DoctorGlucosePatientMeasurementModel.fromJson(Map<String, dynamic> json) {
    measurement = json['measurement'];
    measurementTime = json['measurement_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['measurement'] = this.measurement;
    data['measurement_time'] = this.measurementTime;
    return data;
  }
}
