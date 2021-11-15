// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_my_patient_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMyPatientFilter _$GetMyPatientFilterFromJson(Map<String, dynamic> json) {
  return GetMyPatientFilter(
    start: json['start'] as String,
    end: json['end'] as String,
    skip: json['skip'] as String,
    take: json['take'] as String,
  );
}

Map<String, dynamic> _$GetMyPatientFilterToJson(GetMyPatientFilter instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'skip': instance.skip,
      'take': instance.take,
    };
