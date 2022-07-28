class DoctorBloodPressurePatientModel {
  String? name;
  List<DoctorBloodPressureMeasurements>? bpMeasurements;
  int? id;

  DoctorBloodPressurePatientModel({
    this.name,
    this.bpMeasurements,
    this.id,
  });

  DoctorBloodPressurePatientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    if (json['bp_measurements'] != null) {
      bpMeasurements = <DoctorBloodPressureMeasurements>[];
      json['bp_measurements'].forEach((v) {
        bpMeasurements?.add(
          DoctorBloodPressureMeasurements.fromJson(
            v as Map<String, dynamic>,
          ),
        );
      });
    }
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (bpMeasurements != null) {
      data['bp_measurements'] = bpMeasurements?.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class DoctorBloodPressureMeasurements {
  int? id;
  int? entegrationId;
  String? occurrenceTime;
  int? sysValue;
  int? diaValue;
  int? pulseValue;
  String? note;
  String? deviceId;
  bool? isManuel;
  int? measurementId;

  DoctorBloodPressureMeasurements({
    this.id,
    this.entegrationId,
    this.occurrenceTime,
    this.sysValue,
    this.diaValue,
    this.pulseValue,
    this.note,
    this.deviceId,
    this.isManuel,
    this.measurementId,
  });

  DoctorBloodPressureMeasurements.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    entegrationId = json['entegration_id'] as int?;
    occurrenceTime = json['occurrence_time'] as String?;
    sysValue = json['sys_value'] as int?;
    diaValue = json['dia_value'] as int?;
    pulseValue = json['pulse_value'] as int?;
    note = json['note'] as String?;
    deviceId = json['device_id'] as String?;
    isManuel = json['is_manuel'] as bool?;
    measurementId = json['measurement_id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['entegration_id'] = entegrationId;
    data['occurrence_time'] = occurrenceTime;
    data['sys_value'] = sysValue;
    data['dia_value'] = diaValue;
    data['pulse_value'] = pulseValue;
    data['note'] = note;
    data['device_id'] = deviceId;
    data['is_manuel'] = isManuel;
    data['measurement_id'] = measurementId;
    return data;
  }
}
