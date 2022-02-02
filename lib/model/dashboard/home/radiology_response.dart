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
    final Map<String, dynamic> RadiologyResult = <String, dynamic>{};
    RadiologyResult['approvedAt'] = approvedAt;
    RadiologyResult['group'] = group;
    RadiologyResult['id'] = id;
    RadiologyResult['name'] = name;
    RadiologyResult['patient'] = patient;
    RadiologyResult['patientId'] = patientId;
    RadiologyResult['report'] = report;
    RadiologyResult['reportLink'] = reportLink;
    RadiologyResult['reportState'] = reportState;
    RadiologyResult['requestedAt'] = requestedAt;
    RadiologyResult['takenAt'] = takenAt;
    RadiologyResult['visitId'] = visitId;
    return RadiologyResult;
  }
}
