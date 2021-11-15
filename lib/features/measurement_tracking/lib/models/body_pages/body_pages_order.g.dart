// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_pages_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    column: json['column'] as int,
    dir: json['dir'] as String,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'column': instance.column,
      'dir': instance.dir,
    };
