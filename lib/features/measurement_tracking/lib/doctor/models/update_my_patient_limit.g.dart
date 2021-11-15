// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_my_patient_limit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMyPatientLimit _$UpdateMyPatientLimitFromJson(Map<String, dynamic> json) {
  return UpdateMyPatientLimit(
    rangeMin: json['range_min'] as int,
    rangeMax: json['range_max'] as int,
    hyper: json['hyper'] as int,
    hypo: json['hypo'] as int,
  );
}

Map<String, dynamic> _$UpdateMyPatientLimitToJson(
        UpdateMyPatientLimit instance) =>
    <String, dynamic>{
      'range_min': instance.rangeMin,
      'range_max': instance.rangeMax,
      'hyper': instance.hyper,
      'hypo': instance.hypo,
    };
