// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientRangeChangeBody _$PatientRangeChangeBodyFromJson(
        Map<String, dynamic> json) =>
    PatientRangeChangeBody(
      fromId: json['from'] as int?,
      entegrationId: json['entegration_id'] as int?,
      normalMin: (json['normal_min'] as num?)?.toDouble(),
      normalMax: (json['normal_max'] as num?)?.toDouble(),
      alertMin: (json['alert_min'] as num?)?.toDouble(),
      alertMax: (json['alert_max'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PatientRangeChangeBodyToJson(
        PatientRangeChangeBody instance) =>
    <String, dynamic>{
      'from': instance.fromId,
      'entegration_id': instance.entegrationId,
      'normal_min': instance.normalMin,
      'normal_max': instance.normalMax,
      'alert_min': instance.alertMin,
      'alert_max': instance.alertMax,
    };
