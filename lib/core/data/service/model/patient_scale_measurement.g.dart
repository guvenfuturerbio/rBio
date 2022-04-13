// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_scale_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PatientScaleMeasurement _$$_PatientScaleMeasurementFromJson(
        Map<String, dynamic> json) =>
    _$_PatientScaleMeasurement(
      entegrationId: json['entegration_id'] as int?,
      occurrenceTime: json['occurrence_time'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      bmi: (json['bmi'] as num?)?.toDouble(),
      measurementId: json['measurement_id'] as int?,
      water: (json['water'] as num?)?.toDouble(),
      bodyFat: (json['body_fat'] as num?)?.toDouble(),
      visceralFat: (json['visceral_fat'] as num?)?.toDouble(),
      boneMass: (json['bone_mass'] as num?)?.toDouble(),
      muscle: (json['muscle'] as num?)?.toDouble(),
      bmh: (json['bmh'] as num?)?.toDouble(),
      scaleUnit: json['scale_unit'] as int?,
      deviceId: json['device_id'] as String?,
      isManuel: json['is_manuel'] as bool?,
      note: json['note'] as String?,
      height: json['height'] as int?,
      age: json['age'] as int?,
      genderId: json['genderId'] as int?,
    );

Map<String, dynamic> _$$_PatientScaleMeasurementToJson(
        _$_PatientScaleMeasurement instance) =>
    <String, dynamic>{
      'entegration_id': instance.entegrationId,
      'occurrence_time': instance.occurrenceTime,
      'weight': instance.weight,
      'bmi': instance.bmi,
      'measurement_id': instance.measurementId,
      'water': instance.water,
      'body_fat': instance.bodyFat,
      'visceral_fat': instance.visceralFat,
      'bone_mass': instance.boneMass,
      'muscle': instance.muscle,
      'bmh': instance.bmh,
      'scale_unit': instance.scaleUnit,
      'device_id': instance.deviceId,
      'is_manuel': instance.isManuel,
      'note': instance.note,
      'height': instance.height,
      'age': instance.age,
      'genderId': instance.genderId,
    };
