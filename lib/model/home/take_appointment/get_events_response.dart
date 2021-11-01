class GetEventsResponse {
  List<Events> events;
  Resource resource;
  int serviceTime;

  GetEventsResponse({
    this.events,
    this.resource,
    this.serviceTime,
  });

  GetEventsResponse.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events.add(new Events.fromJson(v));
      });
    }
    resource = json['resource'] != null
        ? new Resource.fromJson(json['resource'])
        : null;
    serviceTime = json['serviceTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    if (this.resource != null) {
      data['resource'] = this.resource.toJson();
    }
    data['serviceTime'] = this.serviceTime;
    return data;
  }
}

class Events {
  String date;
  String from;
  String to;
  int type;

  Events({this.date, this.from, this.to, this.type});

  Events.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    from = json['from'];
    to = json['to'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['from'] = this.from;
    data['to'] = this.to;
    data['type'] = this.type;
    return data;
  }
}

class Resource {
  int departmentId;
  String resource;
  int resourceId;
  int tenantId;
  String eventDate;

  Resource({this.departmentId, this.resource, this.resourceId, this.tenantId});

  Resource.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId'];
    resource = json['resource'];
    resourceId = json['resourceId'];
    tenantId = json['tenantId'];
    eventDate = json['eventDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['resource'] = this.resource;
    data['resourceId'] = this.resourceId;
    data['tenantId'] = this.tenantId;
    data['eventDate'] = this.eventDate;
    return data;
  }
}
