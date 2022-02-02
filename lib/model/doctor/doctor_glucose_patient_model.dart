import 'diabet_type.dart';

class DoctorGlucosePatientModel {
  String? name;
  DiabetType? diabetType;
  List<DoctorGlucosePatientMeasurementModel>? measurements;
  int? entegrationId;
  double? normalMin;
  double? normalMax;
  double? alertMin;
  double? alertMax;
  double? target;
  int? id;

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
    name = json['name'] as String?;
    diabetType = json['diabet_type'] != null
        ? DiabetType.fromJson(json['diabet_type'] as Map<String, dynamic>)
        : null;
    if (json['measurements'] != null) {
      measurements = <DoctorGlucosePatientMeasurementModel>[];
      json['measurements'].forEach((v) {
        measurements?.add(DoctorGlucosePatientMeasurementModel.fromJson(
            v as Map<String, dynamic>));
      });
    }
    entegrationId = json['entegration_id'] as int?;
    normalMax = json['normal_max'] as double?;
    normalMin = json['normal_min'] as double?;
    alertMin = json['alert_min'] as double?;
    alertMax = json['alert_max'] as double?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (diabetType != null) {
      data['diabet_type'] = diabetType?.toJson();
    }
    if (measurements != null) {
      data['measurements'] = measurements?.map((v) => v.toJson()).toList();
    }
    data['entegration_id'] = entegrationId;
    data['normal_max'] = normalMax;
    data['normal_min'] = normalMin;
    data['alert_min'] = alertMin;
    data['alert_max'] = alertMax;
    data['target'] = target;
    data['id'] = id;
    return data;
  }
}

class DoctorGlucosePatientMeasurementModel {
  String? measurement;
  String? measurementTime;

  DoctorGlucosePatientMeasurementModel(
      {this.measurement, this.measurementTime});

  DoctorGlucosePatientMeasurementModel.fromJson(Map<String, dynamic> json) {
    measurement = json['measurement'] as String?;
    measurementTime = json['measurement_time'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['measurement'] = measurement;
    data['measurement_time'] = measurementTime;
    return data;
  }
}
