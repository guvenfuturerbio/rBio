// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_glucose_report_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodGlucoseReportBody _$BloodGlucoseReportBodyFromJson(
        Map<String, dynamic> json) =>
    BloodGlucoseReportBody(
      start: json['start'] as String?,
      end: json['end'] as String?,
      reportType: json['report_type'] as int?,
      userId: json['entegration_id'] as int?,
    );

Map<String, dynamic> _$BloodGlucoseReportBodyToJson(
        BloodGlucoseReportBody instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'report_type': instance.reportType,
      'entegration_id': instance.userId,
    };
