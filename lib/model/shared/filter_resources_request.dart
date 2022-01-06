class FilterResourcesRequest {
  int departmentId;
  int tenantId;
  String search;
  int appointmentType;

  FilterResourcesRequest({
    this.departmentId,
    this.tenantId,
    this.search,
    this.appointmentType,
  });

  factory FilterResourcesRequest.fromJson(Map<String, dynamic> json) =>
      FilterResourcesRequest(
        departmentId: json['departmentId'] as int,
        tenantId: json['tenantId'] as int,
        search: json['search'] as String,
        appointmentType: json['appointmentType'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'departmentId': departmentId,
        'tenantId': tenantId,
        'search': search,
        'appointmentType': appointmentType,
      };
}
