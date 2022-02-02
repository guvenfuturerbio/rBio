class FilterDepartmentsRequest {
  int? tenantId;
  String? search;

  FilterDepartmentsRequest({
    this.tenantId,
    this.search,
  });

  factory FilterDepartmentsRequest.fromJson(Map<String, dynamic> json) =>
      FilterDepartmentsRequest(
        tenantId: json['tenantId'] as int?,
        search: json['search'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tenantId': tenantId,
        'search': search,
      };
}
