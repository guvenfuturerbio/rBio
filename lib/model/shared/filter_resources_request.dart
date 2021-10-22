class FilterResourcesRequest {
  int departmentId;
  int tenantId;
  String search;

  FilterResourcesRequest({
    this.departmentId,
    this.tenantId,
    this.search,
  });

  factory FilterResourcesRequest.fromJson(Map<String, dynamic> json) =>
      FilterResourcesRequest(
        departmentId: json['departmentId'] as int,
        tenantId: json['tenantId'] as int,
        search: json['search'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'departmentId': departmentId,
        'tenantId': tenantId,
        'search': search,
      };
}
