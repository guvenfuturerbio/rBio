

import 'package:json_annotation/json_annotation.dart';
part 'blood_glucose_report_body.g.dart';

@JsonSerializable()
class BloodGlucoseReportBody {
  @JsonKey(name: 'start')
  String start;
  @JsonKey(name: 'end')
  String end;
  @JsonKey(name: 'report_type')
  int reportType;
  @JsonKey(name: 'entegration_id')
  int userId;

  BloodGlucoseReportBody({
    this.start,
    this.end,
    this.reportType,
    this.userId
  });

  factory BloodGlucoseReportBody.fromJson(Map<String, dynamic> json) => _$BloodGlucoseReportBodyFromJson(json);

  Map<String, dynamic> toJson() => _$BloodGlucoseReportBodyToJson(this);
}