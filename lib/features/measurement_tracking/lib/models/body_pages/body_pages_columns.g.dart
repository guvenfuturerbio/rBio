// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_pages_columns.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Columns _$ColumnsFromJson(Map<String, dynamic> json) {
  return Columns(
    data: json['data'] as String,
    name: json['name'] as String,
    searchable: json['searchable'] as bool,
    orderable: json['orderable'] as bool,
    search: json['search'] == null
        ? null
        : Search.fromJson(json['search'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ColumnsToJson(Columns instance) => <String, dynamic>{
      'data': instance.data,
      'name': instance.name,
      'searchable': instance.searchable,
      'orderable': instance.orderable,
      'search': instance.search,
    };
