// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_departments_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterDepartmentsResponse _$FilterDepartmentsResponseFromJson(
        Map<String, dynamic> json) =>
    FilterDepartmentsResponse(
      enabled: json['enabled'] as bool?,
      id: json['id'] as int?,
      tenants: (json['tenants'] as List<dynamic>?)
          ?.map(
              (e) => FilterTenantsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$FilterDepartmentsResponseToJson(
        FilterDepartmentsResponse instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'id': instance.id,
      'tenants': instance.tenants,
      'title': instance.title,
    };
