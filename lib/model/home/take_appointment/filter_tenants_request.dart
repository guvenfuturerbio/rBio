class FilterTenantsRequest {
  int? departmanId;

  FilterTenantsRequest({
    this.departmanId,
  });

  factory FilterTenantsRequest.fromJson(Map<String, dynamic> json) =>
      FilterTenantsRequest(
        departmanId: json['departmanId'] as int?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'departmanId': departmanId,
      };
}
