// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_bg_measurement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteBloodGlucoseMeasurementRequest
    _$DeleteBloodGlucoseMeasurementRequestFromJson(Map<String, dynamic> json) =>
        DeleteBloodGlucoseMeasurementRequest(
          entegrationId: json['entegration_id'] as int?,
          measurementId: json['measurement_id'] as int?,
        );

Map<String, dynamic> _$DeleteBloodGlucoseMeasurementRequestToJson(
        DeleteBloodGlucoseMeasurementRequest instance) =>
    <String, dynamic>{
      'entegration_id': instance.entegrationId,
      'measurement_id': instance.measurementId,
    };
