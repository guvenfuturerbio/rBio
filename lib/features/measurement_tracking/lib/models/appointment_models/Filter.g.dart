// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return Filter(
    type: json['type'] as String,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
    };
