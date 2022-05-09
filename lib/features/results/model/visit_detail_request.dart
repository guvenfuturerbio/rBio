class VisitDetailRequest {
  int? visitId;
  int? patientId;

  VisitDetailRequest({
    this.patientId,
    this.visitId,
  });

  factory VisitDetailRequest.fromJson(Map<String, dynamic> json) =>
      VisitDetailRequest(
        patientId: json['PatientId'] as int?,
        visitId: json['visitId'] as int?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'visitId': visitId,
        'PatientId': patientId,
      };
}
