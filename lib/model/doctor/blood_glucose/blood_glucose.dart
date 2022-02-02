import 'blood_glucose_measurement_model.dart';
import 'detail_model.dart';
import 'tag_model.dart';

class BloodGlucose {
  String? date;
  BloodGlucoseMeasurementModel? bloodGlucoseMeasurement;
  DetailModel? detail;
  TagModel? tag;
  String? deviceId;
  bool? isManuel;
  int? id;

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
    date = json['date'] as String?;
    bloodGlucoseMeasurement = json['blood_glucose_measurement'] != null
        ? BloodGlucoseMeasurementModel.fromJson(
            json['blood_glucose_measurement'] as Map<String, dynamic>,
          )
        : null;
    detail = json['detail'] != null
        ? DetailModel.fromJson(
            json['detail'] as Map<String, dynamic>,
          )
        : null;
    tag = json['tag'] != null
        ? TagModel.fromJson(json['tag'] as Map<String, dynamic>)
        : null;
    deviceId = json['device_id'] as String?;
    isManuel = json['is_manuel'] as bool?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (bloodGlucoseMeasurement != null) {
      data['blood_glucose_measurement'] = bloodGlucoseMeasurement?.toJson();
    }
    if (detail != null) {
      data['detail'] = detail?.toJson();
    }
    if (tag != null) {
      data['tag'] = tag?.toJson();
    }
    data['device_id'] = deviceId;
    data['is_manuel'] = isManuel;
    data['id'] = id;
    return data;
  }
}
