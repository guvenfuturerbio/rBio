// To parse this JSON data, do
//
//     final getBpMeasurements = getBpMeasurementsFromJson(jsonString);

import 'dart:convert';

GetBpMeasurements getBpMeasurementsFromJson(String str) =>
    GetBpMeasurements.fromJson(json.decode(str));

String getBpMeasurementsToJson(GetBpMeasurements data) =>
    json.encode(data.toJson());

class GetBpMeasurements {
  GetBpMeasurements({
    this.entegrationId,
    this.beginDate,
    this.endDate,
    this.count,
  });

  int entegrationId;
  DateTime beginDate;
  DateTime endDate;
  int count;

  factory GetBpMeasurements.fromJson(Map<String, dynamic> json) =>
      GetBpMeasurements(
        entegrationId: json["entegration_id"],
        beginDate: DateTime.parse(json["begin_date"]),
        endDate: DateTime.parse(json["end_date"]),
        count: json["count"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['entegration_id'] = entegrationId;
    if (beginDate != null) map['begin_date'] = beginDate.toIso8601String();
    if (endDate != null) map['end_date'] = endDate.toIso8601String();
    if (count != null) map['count'] = count;

    return map;
  }
}
