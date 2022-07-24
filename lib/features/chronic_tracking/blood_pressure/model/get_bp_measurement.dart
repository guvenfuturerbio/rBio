class GetBpMeasurements {
  int? entegrationId;
  DateTime? beginDate;
  DateTime? endDate;
  int? count;

  GetBpMeasurements({
    this.entegrationId,
    this.beginDate,
    this.endDate,
    this.count,
  });

  factory GetBpMeasurements.fromJson(Map<String, dynamic> json) =>
      GetBpMeasurements(
        entegrationId: json["entegration_id"] as int?,
        beginDate: DateTime.parse(json["begin_date"] as String),
        endDate: DateTime.parse(json["end_date"] as String),
        count: json["count"] as int?,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['entegration_id'] = entegrationId;
    if (beginDate != null) map['begin_date'] = beginDate?.toIso8601String();
    if (endDate != null) map['end_date'] = endDate?.toIso8601String();
    if (count != null) map['count'] = count;

    return map;
  }
}
