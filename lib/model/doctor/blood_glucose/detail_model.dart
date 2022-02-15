class DetailModel {
  String? occurrenceTime;
  int? normalMin;
  int? normalMax;
  int? alertMin;
  int? alertMax;
  int? target;
  //bool isSmoker;

  DetailModel({
    this.occurrenceTime,
    this.normalMin,
    this.normalMax,
    this.alertMin,
    this.alertMax,
    this.target,
    //this.isSmoker
  });

  DetailModel.fromJson(Map<String, dynamic> json) {
    occurrenceTime = json['occurrence_time'] as String?;
    normalMin = (json['normal_min'] as double).toInt();
    normalMax = (json['normal_max'] as double).toInt();
    alertMin = (json['alert_min'] as double).toInt();
    alertMax = (json['alert_max'] as double).toInt();
    target = (json['target'] as double).toInt();
    //isSmoker = json['is_smoker'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['occurrence_time'] = occurrenceTime;
    data['normal_min'] = normalMin;
    data['normal_max'] = normalMax;
    data['alert_min'] = alertMin;
    data['alert_max'] = alertMax;
    data['target'] = target;
    //data['is_smoker'] = this.isSmoker;
    return data;
  }
}
