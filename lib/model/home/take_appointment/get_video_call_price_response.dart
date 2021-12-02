class GetVideoCallPriceResponse {
  double patientPrice;
  String resource;
  String service;

  GetVideoCallPriceResponse({
    this.patientPrice,
    this.resource,
    this.service,
  });

  GetVideoCallPriceResponse.fromJson(Map<String, dynamic> json) {
    patientPrice = json['patientPrice'];
    resource = json['resource'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientPrice'] = this.patientPrice;
    data['resource'] = this.resource;
    data['service'] = this.service;
    return data;
  }

  GetVideoCallPriceResponse copyWith({
    double patientPrice,
    String resource,
    String service,
  }) {
    return GetVideoCallPriceResponse(
      patientPrice: patientPrice ?? this.patientPrice,
      resource: resource ?? this.resource,
      service: service ?? this.service,
    );
  }
}
