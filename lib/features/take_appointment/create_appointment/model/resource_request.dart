class ResourceRequest {
  int? resourceId;
  int? tenantId;
  int? departmentId;
  String? from;
  String? to;

  ResourceRequest({
    this.resourceId,
    this.tenantId,
    this.departmentId,
    this.from,
    this.to,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'resourceId': resourceId,
        'tenantId': tenantId,
        'departmentId': departmentId,
        'from': from,
        'to': to,
      };

  factory ResourceRequest.fromJson(Map<String, dynamic> json) =>
      ResourceRequest(
        resourceId: json['resourceId'] as int?,
        tenantId: json['tenantId']as int?,
        departmentId: json['departmentId']as int?,
        from: json['from']as String?,
        to: json['to']as String?,
      );
}
