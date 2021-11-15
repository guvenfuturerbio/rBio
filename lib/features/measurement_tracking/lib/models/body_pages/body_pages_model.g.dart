// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_pages_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyPages _$BodyPagesFromJson(Map<String, dynamic> json) {
  return BodyPages(
    draw: json['draw'] as int,
    columns: (json['columns'] as List)
        ?.map((e) =>
            e == null ? null : Columns.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    order: (json['order'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    start: json['start'] as int,
    length: json['length'] as String,
    search: json['search'] == null
        ? null
        : Search.fromJson(json['search'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BodyPagesToJson(BodyPages instance) => <String, dynamic>{
      'draw': instance.draw,
      'columns': instance.columns,
      'order': instance.order,
      'start': instance.start,
      'length': instance.length,
      'search': instance.search,
    };
