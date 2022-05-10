class VisitResponse {
  int? countOfLaboratoryResults;
  int? countOfPathologyResults;
  int? countOfRadiologyResults;
  String? department;
  bool? hasLaboratoryResults;
  bool? hasPathologyResults;
  bool? hasRadiologyResults;
  int? id;
  String? identityNumber;
  String? openingDate;
  String? patient;
  int? patientId;
  String? physician;
  String? tenant;
  int? tenantId;

  VisitResponse({
    this.countOfLaboratoryResults,
    this.countOfPathologyResults,
    this.countOfRadiologyResults,
    this.department,
    this.hasLaboratoryResults,
    this.hasPathologyResults,
    this.hasRadiologyResults,
    this.id,
    this.identityNumber,
    this.openingDate,
    this.patient,
    this.patientId,
    this.physician,
    this.tenant,
    this.tenantId,
  });

  VisitResponse.fromJson(Map<String, dynamic> json) {
    countOfLaboratoryResults = json['countOfLaboratoryResults'] as int?;
    countOfPathologyResults = json['countOfPathologyResults'] as int?;
    countOfRadiologyResults = json['countOfRadiologyResults'] as int?;
    department = json['department'] as String?;
    hasLaboratoryResults = json['hasLaboratoryResults'] as bool?;
    hasPathologyResults = json['hasPathologyResults'] as bool?;
    hasRadiologyResults = json['hasRadiologyResults'] as bool?;
    id = json['id'] as int?;
    identityNumber = json['identityNumber'] as String?;
    openingDate = json['openingDate'] as String?;
    patient = json['patient'] as String?;
    patientId = json['patientId'] as int?;
    physician = json['physician'] as String?;
    tenant = json['tenant'] as String?;
    tenantId = json['tenantId'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countOfLaboratoryResults'] = countOfLaboratoryResults;
    data['countOfPathologyResults'] = countOfPathologyResults;
    data['countOfRadiologyResults'] = countOfRadiologyResults;
    data['department'] = department;
    data['hasLaboratoryResults'] = hasLaboratoryResults;
    data['hasPathologyResults'] = hasPathologyResults;
    data['hasRadiologyResults'] = hasRadiologyResults;
    data['id'] = id;
    data['identityNumber'] = identityNumber;
    data['openingDate'] = openingDate;
    data['patient'] = patient;
    data['patientId'] = patientId;
    data['physician'] = physician;
    data['tenant'] = tenant;
    data['tenantId'] = tenantId;
    return data;
  }
}
