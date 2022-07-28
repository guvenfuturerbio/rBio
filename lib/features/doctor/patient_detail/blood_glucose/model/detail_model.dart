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
    normalMin = (json['normal_min'] ?? 0.0).toInt();
    normalMax = (json['normal_max'] ?? 0.0).toInt();
    alertMin = (json['alert_min'] ?? 0.0).toInt();
    alertMax = (json['alert_max'] ?? 0.0).toInt();
    target = (json['target'] ?? 0.0).toInt();
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
