import 'dart:convert';

class ResourceRequest {
    int resourceId;
  int tenantId;
  int departmentId;
  String from;
  String to;
  ResourceRequest({
     this.resourceId,
     this.tenantId,
     this.departmentId,
     this.from,
     this.to,
  });

  Map<String, dynamic> toMap() {
    return {
      'resourceId': resourceId,
      'tenantId': tenantId,
      'departmentId': departmentId,
      'from': from,
      'to': to,
    };
  }

  factory ResourceRequest.fromMap(Map<String, dynamic> map) {
    return ResourceRequest(
      resourceId: map['resourceId'],
      tenantId: map['tenantId'],
      departmentId: map['departmentId'],
      from: map['from'],
      to: map['to'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResourceRequest.fromJson(String source) => ResourceRequest.fromMap(json.decode(source));
}
