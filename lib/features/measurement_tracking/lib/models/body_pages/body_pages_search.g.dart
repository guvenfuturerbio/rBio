// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_pages_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) {
  return Search(
    value: json['value'] as String,
    regex: json['regex'] as bool,
  );
}

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'value': instance.value,
      'regex': instance.regex,
    };
