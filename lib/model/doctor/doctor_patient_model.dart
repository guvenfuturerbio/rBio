import 'diabet_type.dart';

class DoctorPatientModel {
  String name;
  DiabetType diabetType;
  String lastBg;
  String hypo;
  String hyper;
  int type1Count;
  int type2Count;
  int type3Count;
  int entegrationId;
  int normalMax;
  int normalMin;
  int alertMin;
  int alertMax;
  int id;

  DoctorPatientModel({
    this.name,
    this.diabetType,
    this.lastBg,
    this.hypo,
    this.hyper,
    this.type1Count,
    this.type2Count,
    this.type3Count,
    this.entegrationId,
    this.normalMax,
    this.normalMin,
    this.alertMin,
    this.alertMax,
    this.id,
  });

  DoctorPatientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    diabetType = json['diabet_type'] != null
        ? new DiabetType.fromJson(json['diabet_type'])
        : null;
    lastBg = json['last_bg'];
    hypo = json['hypo'];
    hyper = json['hyper'];
    type1Count = json['type1_count'];
    type2Count = json['type2_count'];
    type3Count = json['type3_count'];
    entegrationId = json['entegration_id'];
    normalMax = (json['normal_max'] as double).toInt();
    normalMin = (json['normal_min'] as double).toInt();
    alertMin = (json['alert_min'] as double).toInt();
    alertMax = (json['alert_max'] as double).toInt();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.diabetType != null) {
      data['diabet_type'] = this.diabetType.toJson();
    }
    data['last_bg'] = this.lastBg;
    data['hypo'] = this.hypo;
    data['hyper'] = this.hyper;
    data['type1_count'] = this.type1Count;
    data['type2_count'] = this.type2Count;
    data['type3_count'] = this.type3Count;
    data['entegration_id'] = this.entegrationId;
    data['normal_max'] = this.normalMax;
    data['normal_min'] = this.normalMin;
    data['alert_min'] = this.alertMin;
    data['alert_max'] = this.alertMax;
    data['id'] = this.id;
    return data;
  }
}
