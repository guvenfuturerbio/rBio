class ResourcesRequest {
  int tenantId;
  int departmentId;
  int resourceId;
  String from;
  String to;
  int id;

  ResourcesRequest({
    this.tenantId,
    this.departmentId,
    this.resourceId,
    this.from,
    this.to,
    this.id,
  });

  factory ResourcesRequest.fromJson(Map<String, dynamic> json) =>
      ResourcesRequest(
        tenantId: json['tenantId'] as int,
        departmentId: json['departmentId'] as int,
        resourceId: json['resourceId'] as int,
        from: json['from'] as String,
        to: json['to'] as String,
        id: json['id'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tenantId': tenantId,
        'departmentId': departmentId,
        'resourceId': resourceId,
        'from': from,
        'to': to,
        'id': id,
      };
}
