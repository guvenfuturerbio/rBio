class GetEventsResponse {
  List<Events>? events;
  Resource? resource;
  int? serviceTime;

  GetEventsResponse({
    this.events,
    this.resource,
    this.serviceTime,
  });

  GetEventsResponse.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events?.add(Events.fromJson(v as Map<String, dynamic>));
      });
    }
    resource = json['resource'] != null
        ? Resource.fromJson(json['resource'] as Map<String, dynamic>)
        : null;
    serviceTime = json['serviceTime'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (events != null) {
      data['events'] = events?.map((v) => v.toJson()).toList();
    }
    if (resource != null) {
      data['resource'] = resource?.toJson();
    }
    data['serviceTime'] = serviceTime;
    return data;
  }
}

class Events {
  String? date;
  String? from;
  String? to;
  int? type;

  Events({this.date, this.from, this.to, this.type});

  Events.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String?;
    from = json['from'] as String?;
    to = json['to'] as String?;
    type = json['type'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['from'] = from;
    data['to'] = to;
    data['type'] = type;
    return data;
  }
}

class Resource {
  int? departmentId;
  String? resource;
  int? resourceId;
  int? tenantId;
  String? eventDate;

  Resource({this.departmentId, this.resource, this.resourceId, this.tenantId});

  Resource.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId'] as int?;
    resource = json['resource'] as String?;
    resourceId = json['resourceId'] as int?;
    tenantId = json['tenantId'] as int?;
    eventDate = json['eventDate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departmentId'] = departmentId;
    data['resource'] = resource;
    data['resourceId'] = resourceId;
    data['tenantId'] = tenantId;
    data['eventDate'] = eventDate;
    return data;
  }
}
