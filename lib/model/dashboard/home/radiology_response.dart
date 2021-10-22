class RadiologyResponse {
  String approvedAt;
  String group;
  int id;
  String name;
  String patient;
  int patientId;
  String report;
  String reportLink;
  int reportState;
  String requestedAt;
  String takenAt;
  int visitId;

  RadiologyResponse({
    this.approvedAt,
    this.group,
    this.id,
    this.name,
    this.patient,
    this.patientId,
    this.report,
    this.reportLink,
    this.reportState,
    this.requestedAt,
    this.takenAt,
    this.visitId,
  });

  RadiologyResponse.fromJson(Map<String, dynamic> json) {
    approvedAt = json['approvedAt'];
    group = json['group'];
    id = json['id'];
    name = json['name'];
    patient = json['patient'];
    patientId = json['patientId'];
    report = json['report'];
    reportLink = json['reportLink'];
    reportState = json['reportState'];
    requestedAt = json['requestedAt'];
    takenAt = json['takenAt'];
    visitId = json['visitId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> RadiologyResult = new Map<String, dynamic>();
    RadiologyResult['approvedAt'] = this.approvedAt;
    RadiologyResult['group'] = this.group;
    RadiologyResult['id'] = this.id;
    RadiologyResult['name'] = this.name;
    RadiologyResult['patient'] = this.patient;
    RadiologyResult['patientId'] = this.patientId;
    RadiologyResult['report'] = this.report;
    RadiologyResult['reportLink'] = this.reportLink;
    RadiologyResult['reportState'] = this.reportState;
    RadiologyResult['requestedAt'] = this.requestedAt;
    RadiologyResult['takenAt'] = this.takenAt;
    RadiologyResult['visitId'] = this.visitId;
    return RadiologyResult;
  }
}
