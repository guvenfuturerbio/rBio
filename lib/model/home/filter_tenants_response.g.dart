// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_tenants_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterTenantsResponse _$FilterTenantsResponseFromJson(
        Map<String, dynamic> json) =>
    FilterTenantsResponse(
      enabled: json['enabled'] as bool?,
      id: json['id'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$FilterTenantsResponseToJson(
        FilterTenantsResponse instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'id': instance.id,
      'title': instance.title,
    };
