class VisitResponse {
  int countOfLaboratoryResults;
  int countOfPathologyResults;
  int countOfRadiologyResults;
  String department;
  bool hasLaboratoryResults;
  bool hasPathologyResults;
  bool hasRadiologyResults;
  int id;
  String identityNumber;
  String openingDate;
  String patient;
  int patientId;
  String physician;

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
  });

  VisitResponse.fromJson(Map<String, dynamic> json) {
    countOfLaboratoryResults = json['countOfLaboratoryResults'];
    countOfPathologyResults = json['countOfPathologyResults'];
    countOfRadiologyResults = json['countOfRadiologyResults'];
    department = json['department'];
    hasLaboratoryResults = json['hasLaboratoryResults'];
    hasPathologyResults = json['hasPathologyResults'];
    hasRadiologyResults = json['hasRadiologyResults'];
    id = json['id'];
    identityNumber = json['identityNumber'];
    openingDate = json['openingDate'];
    patient = json['patient'];
    patientId = json['patientId'];
    physician = json['physician'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countOfLaboratoryResults'] = this.countOfLaboratoryResults;
    data['countOfPathologyResults'] = this.countOfPathologyResults;
    data['countOfRadiologyResults'] = this.countOfRadiologyResults;
    data['department'] = this.department;
    data['hasLaboratoryResults'] = this.hasLaboratoryResults;
    data['hasPathologyResults'] = this.hasPathologyResults;
    data['hasRadiologyResults'] = this.hasRadiologyResults;
    data['id'] = this.id;
    data['identityNumber'] = this.identityNumber;
    data['openingDate'] = this.openingDate;
    data['patient'] = this.patient;
    data['patientId'] = this.patientId;
    data['physician'] = this.physician;
    return data;
  }
}
