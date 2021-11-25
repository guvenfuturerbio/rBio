// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    id: json['entegration_id'] as int,
    imageURL: json['image_url'] as String,
    name: json['name'] as String,
    gender: json['gender'] as String,
    birthDate: json['birth_day'] as String,
    weight: json['weight'] as String,
    height: json['height'] as String,
    diabetesType: json['diabetes_type'] as String,
    rangeMin: json['range_min'] as int,
    rangeMax: json['range_max'] as int,
    hyper: json['hyper'] as int,
    hypo: json['hypo'] as int,
    target: json['target'] as int,
    userId: json['id'] as int,
    deviceUUID: json['device_uuid'] as String,
    manufacturerId: json['manufacturer_id'] as int,
    yearOfDiagnosis: json['year_of_diagnosis'] as int,
    smoker: json['smoker'] as bool,
    isFirstUser: json['is_first_user'] as bool,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.userId,
      'entegration_id': instance.id,
      'image_url': instance.imageURL,
      'name': instance.name,
      'birth_day': instance.birthDate,
      'gender': instance.gender,
      'height': instance.height,
      'weight': instance.weight,
      'diabetes_type': instance.diabetesType,
      'hypo': instance.hypo,
      'range_min': instance.rangeMin,
      'target': instance.target,
      'range_max': instance.rangeMax,
      'hyper': instance.hyper,
      'device_uuid': instance.deviceUUID,
      'manufacturer_id': instance.manufacturerId,
      'year_of_diagnosis': instance.yearOfDiagnosis,
      'smoker': instance.smoker,
      'is_first_user': instance.isFirstUser,
    };
