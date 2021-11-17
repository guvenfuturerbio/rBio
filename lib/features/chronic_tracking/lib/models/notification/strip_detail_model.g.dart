// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strip_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripDetailModel _$StripDetailModelFromJson(Map<String, dynamic> json) {
  return StripDetailModel(
    deviceUUID: json['device_UUID'] as String,
    currentCount: json['current_count'] as int,
    alarmCount: json['alarm_count'] as int,
    entegrationId: json['entegration_id'] as int,
    isNotificationActive: json['is_active'] as bool,
  );
}

Map<String, dynamic> _$StripDetailModelToJson(StripDetailModel instance) =>
    <String, dynamic>{
      'device_UUID': instance.deviceUUID,
      'current_count': instance.currentCount,
      'alarm_count': instance.alarmCount,
      'entegration_id': instance.entegrationId,
      'is_active': instance.isNotificationActive,
    };
