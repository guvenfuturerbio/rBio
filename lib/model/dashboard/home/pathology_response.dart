class PathologyResponse {
  int patientId;
  String procedures;
  String status;
  int visitId;

  PathologyResponse({
    this.patientId,
    this.procedures,
    this.status,
    this.visitId,
  });

  PathologyResponse.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    procedures = json['procedures'];
    status = json['status'];
    visitId = json['visitId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['procedures'] = this.procedures;
    data['status'] = this.status;
    data['visitId'] = this.visitId;
    return data;
  }
}
