class GetVideoCallPriceResponse {
  double? patientPrice;
  String? resource;
  String? service;

  GetVideoCallPriceResponse({
    this.patientPrice,
    this.resource,
    this.service,
  });

  GetVideoCallPriceResponse.fromJson(Map<String, dynamic> json) {
    patientPrice = json['patientPrice'] as double?;
    resource = json['resource'] as String?;
    service = json['service'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientPrice'] = patientPrice;
    data['resource'] = resource;
    data['service'] = service;
    return data;
  }

  GetVideoCallPriceResponse copyWith({
    double? patientPrice,
    String? resource,
    String? service,
  }) {
    return GetVideoCallPriceResponse(
      patientPrice: patientPrice ?? this.patientPrice,
      resource: resource ?? this.resource,
      service: service ?? this.service,
    );
  }
}
