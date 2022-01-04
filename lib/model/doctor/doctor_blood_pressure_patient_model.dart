class DoctorBloodPressurePatientModel {
  String name;
  List<DoctorBloodPressureMeasurements> bpMeasurements;
  int id;

  DoctorBloodPressurePatientModel({
    this.name,
    this.bpMeasurements,
    this.id,
  });

  DoctorBloodPressurePatientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['bp_measurements'] != null) {
      bpMeasurements = new List<DoctorBloodPressureMeasurements>();
      json['bp_measurements'].forEach((v) {
        bpMeasurements.add(new DoctorBloodPressureMeasurements.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.bpMeasurements != null) {
      data['bp_measurements'] =
          this.bpMeasurements.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class DoctorBloodPressureMeasurements {
  int id;
  int entegrationId;
  String occurrenceTime;
  int sysValue;
  int diaValue;
  int pulseValue;
  String note;
  String deviceId;
  bool isManuel;
  int measurementId;

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
    id = json['id'];
    entegrationId = json['entegration_id'];
    occurrenceTime = json['occurrence_time'];
    sysValue = json['sys_value'];
    diaValue = json['dia_value'];
    pulseValue = json['pulse_value'];
    note = json['note'];
    deviceId = json['device_id'];
    isManuel = json['is_manuel'];
    measurementId = json['measurement_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entegration_id'] = this.entegrationId;
    data['occurrence_time'] = this.occurrenceTime;
    data['sys_value'] = this.sysValue;
    data['dia_value'] = this.diaValue;
    data['pulse_value'] = this.pulseValue;
    data['note'] = this.note;
    data['device_id'] = this.deviceId;
    data['is_manuel'] = this.isManuel;
    data['measurement_id'] = this.measurementId;
    return data;
  }
}
