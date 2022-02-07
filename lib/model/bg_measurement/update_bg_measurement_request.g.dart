// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_bg_measurement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBloodGlucoseMeasurementRequest
    _$UpdateBloodGlucoseMeasurementRequestFromJson(Map<String, dynamic> json) {
  return UpdateBloodGlucoseMeasurementRequest(
    entegrationId: json['entegration_id'] as int?,
    measurementId: json['measurement_id'] as int?,
    tag: json['measurement_tag'] as int?,
    value: json['measurement_value'] as int?,
    type: json['measurement_type'] as String?,
    note: json['measurement_note'] as String?,
    date: json['occurrence'] as String?,
  );
}

Map<String, dynamic> _$UpdateBloodGlucoseMeasurementRequestToJson(
        UpdateBloodGlucoseMeasurementRequest instance) =>
    <String, dynamic>{
      'entegration_id': instance.entegrationId,
      'measurement_id': instance.measurementId,
      'measurement_tag': instance.tag,
      'measurement_value': instance.value,
      'measurement_type': instance.type,
      'measurement_note': instance.note,
      'occurrence': instance.date,
    };
