class GetVideoCallPriceRequest {
  int? resourceId;
  int? tenantId;
  int? departmentId;

  GetVideoCallPriceRequest({
    this.resourceId,
    this.tenantId,
    this.departmentId,
  });

  factory GetVideoCallPriceRequest.fromJson(Map<String, dynamic> json) =>
      GetVideoCallPriceRequest(
        resourceId: json['resourceId'] as int?,
        tenantId: json['tenantId'] as int?,
        departmentId: json['departmentId'] as int?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'resourceId': resourceId,
        'tenantId': tenantId,
        'departmentId': departmentId,
      };
}
