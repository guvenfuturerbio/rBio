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
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$GetBloodGlucoseDataOfPersonToJson(
    GetBloodGlucoseDataOfPerson instance) {
  Map<String, dynamic> map = <String, dynamic>{};
  map['entegration_id'] = instance.id;
  if (instance.start != null) map['start'] = instance.start;
  if (instance.end != null) map['end'] = instance.end;
  if (instance.count != null) map['count'] = instance.count;
  return map;
}
