class FilterResourcesRequest {
  int? departmentId;
  int? tenantId;
  String? search;
  int? appointmentType;

  FilterResourcesRequest({
    this.departmentId,
    this.tenantId,
    this.search,
    this.appointmentType,
  });

  factory FilterResourcesRequest.fromJson(Map<String, dynamic> json) =>
      FilterResourcesRequest(
        departmentId: json['departmentId'],
        tenantId: json['tenantId'],
        search: json['search'],
        appointmentType: json['appointmentType'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'departmentId': departmentId,
        'tenantId': tenantId,
        'search': search,
        'appointmentType': appointmentType,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterResourcesRequest &&
        other.departmentId == departmentId &&
        other.tenantId == tenantId &&
        other.search == search &&
        other.appointmentType == appointmentType;
  }

  @override
  int get hashCode {
    return departmentId.hashCode ^
        tenantId.hashCode ^
        search.hashCode ^
        appointmentType.hashCode;
  }
}
