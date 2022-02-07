// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_glucose_value_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodGlucoseValueDetail _$BloodGlucoseValueDetailFromJson(
    Map<String, dynamic> json) {
  return BloodGlucoseValueDetail(
    time: json['occurrence_time'] as String?,
    tag: json['sugar_measure_tag_id'] as int?,
  );
}

Map<String, dynamic> _$BloodGlucoseValueDetailToJson(
        BloodGlucoseValueDetail instance) =>
    <String, dynamic>{
      'occurrence_time': instance.time,
      'sugar_measure_tag_id': instance.tag,
    };
