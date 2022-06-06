import 'package:json_annotation/json_annotation.dart';

import '../../../../core/core.dart';

part 'get_events_response.g.dart';

@JsonSerializable()
class GetEventsResponse extends IBaseModel<GetEventsResponse> {
  @JsonKey(name: "events")
  List<Events>? events;

  @JsonKey(name: "resource")
  Resource? resource;

  @JsonKey(name: "serviceTime")
  int? serviceTime;

  GetEventsResponse({
    this.events,
    this.resource,
    this.serviceTime,
  });

  factory GetEventsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetEventsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetEventsResponseToJson(this);

  @override
  GetEventsResponse fromJson(Map<String, dynamic> json) {
    return GetEventsResponse.fromJson(json);
  }
}

@JsonSerializable()
class Events extends IBaseModel<Events> {
  @JsonKey(name: "date")
  String? date;

  @JsonKey(name: "from")
  String? from;

  @JsonKey(name: "to")
  String? to;

  @JsonKey(name: "type")
  int? type;

  Events({
    this.date,
    this.from,
    this.to,
    this.type,
  });

  factory Events.fromJson(Map<String, dynamic> json) => _$EventsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EventsToJson(this);

  @override
  Events fromJson(Map<String, dynamic> json) {
    return Events.fromJson(json);
  }
}

@JsonSerializable()
class Resource extends IBaseModel<Resource> {
  @JsonKey(name: "departmentId")
  int? departmentId;

  @JsonKey(name: "resource")
  String? resource;

  @JsonKey(name: "resourceId")
  int? resourceId;

  @JsonKey(name: "tenantId")
  int? tenantId;

  @JsonKey(name: "eventDate")
  String? eventDate;

  Resource({
    this.departmentId,
    this.resource,
    this.resourceId,
    this.tenantId,
  });

  factory Resource.fromJson(Map<String, dynamic> json) =>
      _$ResourceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResourceToJson(this);

  @override
  Resource fromJson(Map<String, dynamic> json) {
    return Resource.fromJson(json);
  }
}
