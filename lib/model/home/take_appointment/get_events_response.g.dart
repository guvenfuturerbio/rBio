// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_events_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEventsResponse _$GetEventsResponseFromJson(Map<String, dynamic> json) =>
    GetEventsResponse(
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => Events.fromJson(e as Map<String, dynamic>))
          .toList(),
      resource: json['resource'] == null
          ? null
          : Resource.fromJson(json['resource'] as Map<String, dynamic>),
      serviceTime: json['serviceTime'] as int?,
    );

Map<String, dynamic> _$GetEventsResponseToJson(GetEventsResponse instance) =>
    <String, dynamic>{
      'events': instance.events,
      'resource': instance.resource,
      'serviceTime': instance.serviceTime,
    };

Events _$EventsFromJson(Map<String, dynamic> json) => Events(
      date: json['date'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      type: json['type'] as int?,
    );

Map<String, dynamic> _$EventsToJson(Events instance) => <String, dynamic>{
      'date': instance.date,
      'from': instance.from,
      'to': instance.to,
      'type': instance.type,
    };

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource(
      departmentId: json['departmentId'] as int?,
      resource: json['resource'] as String?,
      resourceId: json['resourceId'] as int?,
      tenantId: json['tenantId'] as int?,
    )..eventDate = json['eventDate'] as String?;

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'departmentId': instance.departmentId,
      'resource': instance.resource,
      'resourceId': instance.resourceId,
      'tenantId': instance.tenantId,
      'eventDate': instance.eventDate,
    };
