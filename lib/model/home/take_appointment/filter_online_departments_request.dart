class FilterOnlineDepartmentsRequest {
  int tenantId;
  String appointmentType;

  FilterOnlineDepartmentsRequest({
    this.tenantId,
    this.appointmentType,
  });

  factory FilterOnlineDepartmentsRequest.fromJson(Map<String, dynamic> json) =>
      FilterOnlineDepartmentsRequest(
        tenantId: json['tenantId'] as int,
        appointmentType: json['appointmentType'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tenantId': tenantId,
        'appointmentType': appointmentType,
      };
}
