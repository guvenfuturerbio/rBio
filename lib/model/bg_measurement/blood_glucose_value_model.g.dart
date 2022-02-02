// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_glucose_value_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodGlucoseValue _$BloodGlucoseValueFromJson(Map<String, dynamic> json) {
  return BloodGlucoseValue(
    value: json['value'] as String,
    valueType: json['value_type'] as String,
    valueNote: json['value_note'] as String,
    detail: BloodGlucoseValueDetail.fromJson(
      json['detail'] as Map<String, dynamic>,
    ),
    id: json['entegration_id'] as int,
    isManual: json['is_manuel'] as bool,
    deviceUUID: json['device_uuid'] as String,
  );
}

Map<String, dynamic> _$BloodGlucoseValueToJson(BloodGlucoseValue instance) =>
    <String, dynamic>{
      'entegration_id': instance.id,
      'value': instance.value,
      'value_type': instance.valueType,
      'value_note': instance.valueNote,
      'detail': instance.detail?.toJson(),
      'is_manuel': instance.isManual,
      'device_uuid': instance.deviceUUID,
    };
