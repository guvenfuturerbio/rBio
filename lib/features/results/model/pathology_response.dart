class PathologyResponse {
  int? patientId;
  String? procedures;
  String? status;
  int? visitId;

  PathologyResponse({
    this.patientId,
    this.procedures,
    this.status,
    this.visitId,
  });

  PathologyResponse.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'] as int?;
    procedures = json['procedures'] as String?;
    status = json['status'] as String?;
    visitId = json['visitId'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientId'] = patientId;
    data['procedures'] = procedures;
    data['status'] = status;
    data['visitId'] = visitId;
    return data;
  }
}
