class VisitRequest {
  String? identityNumber;
  String? from;
  String? to;
  int? hasResults;
  int? isForeignPatient;

  VisitRequest({
    this.identityNumber,
    this.from,
    this.to,
    this.hasResults,
    this.isForeignPatient,
  });

  factory VisitRequest.fromJson(Map<String, dynamic> json) => VisitRequest(
        identityNumber: json['identityNumber'] as String?,
        from: json['from'] as String?,
        to: json['to'] as String?,
        hasResults: json['hasResults'] as int?,
        isForeignPatient: json['isForeignPatient'] as int?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'identityNumber': identityNumber,
        'from': from,
        'to': to,
        'hasResults': hasResults,
        'isForeignPatient': isForeignPatient,
      };
}
