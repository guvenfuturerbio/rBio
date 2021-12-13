import 'blood_glucose_measurement_model.dart';
import 'detail_model.dart';
import 'tag_model.dart';

class BloodGlucose {
  String date;
  BloodGlucoseMeasurementModel bloodGlucoseMeasurement;
  DetailModel detail;
  TagModel tag;
  String deviceId;
  bool isManuel;
  int id;

  BloodGlucose({
    this.date,
    this.bloodGlucoseMeasurement,
    this.detail,
    this.tag,
    this.deviceId,
    this.isManuel,
    this.id,
  });

  BloodGlucose.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    bloodGlucoseMeasurement = json['blood_glucose_measurement'] != null
        ? new BloodGlucoseMeasurementModel.fromJson(
            json['blood_glucose_measurement'])
        : null;
    detail = json['detail'] != null
        ? new DetailModel.fromJson(json['detail'])
        : null;
    tag = json['tag'] != null ? new TagModel.fromJson(json['tag']) : null;
    deviceId = json['device_id'];
    isManuel = json['is_manuel'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.bloodGlucoseMeasurement != null) {
      data['blood_glucose_measurement'] = this.bloodGlucoseMeasurement.toJson();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    if (this.tag != null) {
      data['tag'] = this.tag.toJson();
    }
    data['device_id'] = this.deviceId;
    data['is_manuel'] = this.isManuel;
    data['id'] = this.id;
    return data;
  }
}
