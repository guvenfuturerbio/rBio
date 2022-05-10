class RadiologyResponse {
  String? approvedAt;
  String? group;
  int? id;
  String? name;
  String? patient;
  int? patientId;
  String? report;
  String? reportLink;
  int? reportState;
  String? requestedAt;
  String? takenAt;
  int? visitId;

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
    approvedAt = json['approvedAt'] as String?;
    group = json['group'] as String?;
    id = json['id'] as int?;
    name = json['name'] as String?;
    patient = json['patient'] as String?;
    patientId = json['patientId'] as int?;
    report = json['report'] as String?;
    reportLink = json['reportLink'] as String?;
    reportState = json['reportState'] as int?;
    requestedAt = json['requestedAt'] as String?;
    takenAt = json['takenAt'] as String?;
    visitId = json['visitId'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> radiologyResult = <String, dynamic>{};
    radiologyResult['approvedAt'] = approvedAt;
    radiologyResult['group'] = group;
    radiologyResult['id'] = id;
    radiologyResult['name'] = name;
    radiologyResult['patient'] = patient;
    radiologyResult['patientId'] = patientId;
    radiologyResult['report'] = report;
    radiologyResult['reportLink'] = reportLink;
    radiologyResult['reportState'] = reportState;
    radiologyResult['requestedAt'] = requestedAt;
    radiologyResult['takenAt'] = takenAt;
    radiologyResult['visitId'] = visitId;
    return radiologyResult;
  }
}
