class PatientAppointmentRequest {
  int patientId;
  String from;
  String to;

  PatientAppointmentRequest({
    this.patientId,
    this.from,
    this.to,
  });

  factory PatientAppointmentRequest.fromJson(Map<String, dynamic> json) =>
      PatientAppointmentRequest(
        patientId: json['patientId'] as int,
        from: json['from'] as String,
        to: json['to'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'patientId': patientId,
        'from': from,
        'to': to,
      };
}
