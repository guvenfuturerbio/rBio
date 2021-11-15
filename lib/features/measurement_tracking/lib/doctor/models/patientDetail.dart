import 'diabetType.dart';

class PatientDetail {String name;
String birthDay;
String gender;
String height;
String weight;
DiabetType diabetType;
int rangeMin;
int rangeMax;
int hyper;
int hypo;
int target;
String imageUrl;
String deviceUuid;
int entegrationId;
bool smoker;
int yearOfDiagnosis;
int stripCount;
int id;

  PatientDetail(
      {this.name,
        this.birthDay,
        this.gender,
        this.height,
        this.weight,
        this.diabetType,
        this.rangeMin,
        this.rangeMax,
        this.hyper,
        this.hypo,
        this.target,
        this.imageUrl,
        this.deviceUuid,
        this.entegrationId,
        this.smoker,
        this.yearOfDiagnosis,
        this.stripCount,
        this.id});

  PatientDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    birthDay = json['birth_day'];
    gender = json['gender'];
    height = json['height'];
    weight = json['weight'];
    diabetType = json['diabet_type'] != null
        ? new DiabetType.fromJson(json['diabet_type'])
        : null;
    rangeMin = json['range_min'];
    rangeMax = json['range_max'];
    hyper = json['hyper'];
    hypo = json['hypo'];
    target = json['target'];
    imageUrl = json['image_url'];
    deviceUuid = json['device_uuid'];
    entegrationId = json['entegration_id'];
    smoker = json['smoker'];
    yearOfDiagnosis = json['year_of_diagnosis'];
    stripCount = json['strip_count'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['birth_day'] = this.birthDay;
    data['gender'] = this.gender;
    data['height'] = this.height;
    data['weight'] = this.weight;
    if (this.diabetType != null) {
      data['diabet_type'] = this.diabetType.toJson();
    }
    data['range_min'] = this.rangeMin;
    data['range_max'] = this.rangeMax;
    data['hyper'] = this.hyper;
    data['hypo'] = this.hypo;
    data['target'] = this.target;
    data['image_url'] = this.imageUrl;
    data['device_uuid'] = this.deviceUuid;
    data['entegration_id'] = this.entegrationId;
    data['smoker'] = this.smoker;
    data['year_of_diagnosis'] = this.yearOfDiagnosis;
    data['strip_count'] = this.stripCount;
    data['id'] = this.id;
    return data;
  }
}