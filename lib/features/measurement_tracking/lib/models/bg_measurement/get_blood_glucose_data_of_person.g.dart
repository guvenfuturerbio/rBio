// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_blood_glucose_data_of_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBloodGlucoseDataOfPerson _$GetBloodGlucoseDataOfPersonFromJson(
    Map<String, dynamic> json) {
  return GetBloodGlucoseDataOfPerson(
    id: json['entegration_id'] as int,
    start: json['start'] as String,
    end: json['end'] as String,
  );
}

Map<String, dynamic> _$GetBloodGlucoseDataOfPersonToJson(
        GetBloodGlucoseDataOfPerson instance) =>
    <String, dynamic>{
      'entegration_id': instance.id,
      'start': instance.start,
      'end': instance.end,
    };
