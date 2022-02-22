class PartModel {
  String? startDateTime;
  String? endDateTime;
  int? interval;

  PartModel({
    this.startDateTime,
    this.endDateTime,
    this.interval,
  });

  PartModel.fromJson(Map<String, dynamic> json) {
    startDateTime = json['start_date_time'] as String?;
    endDateTime = json['end_date_time'] as String?;
    interval = json['interval'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date_time'] = startDateTime;
    data['end_date_time'] = endDateTime;
    data['interval'] = interval;
    return data;
  }
}
