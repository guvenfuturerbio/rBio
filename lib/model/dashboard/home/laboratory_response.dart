class LaboratoryResponse {
  DateTime approvedAt;
  String caution;
  List<LaboratoryResponse> children;
  String group;
  double high;
  int id;
  bool isCritical;
  double low;
  String name;
  String patient;
  int patientId;
  DateTime requestedAt;
  String result;
  int resultType;
  int state;
  DateTime takenAt;
  int type;
  String unit;
  double value;
  int visitId;

  LaboratoryResponse({
    this.approvedAt,
    this.caution,
    this.children,
    this.group,
    this.high,
    this.id,
    this.isCritical,
    this.low,
    this.name,
    this.patient,
    this.patientId,
    this.requestedAt,
    this.result,
    this.resultType,
    this.state,
    this.takenAt,
    this.type,
    this.unit,
    this.value,
    this.visitId,
  });

  factory LaboratoryResponse.fromJson(Map<String, dynamic> json) =>
      LaboratoryResponse(
        approvedAt: DateTime.parse(json["approvedAt"]),
        caution: json["caution"],
        children: List<LaboratoryResponse>.from(
            json["children"].map((x) => LaboratoryResponse.fromJson(x))),
        group: json["group"],
        high: json["high"],
        id: json["id"],
        isCritical: json["isCritical"],
        low: json["low"],
        name: json["name"],
        patient: json["patient"],
        patientId: json["patientId"],
        requestedAt: DateTime.parse(json["requestedAt"]),
        result: json["result"],
        resultType: json["resultType"],
        state: json["state"],
        takenAt: DateTime.parse(json["takenAt"]),
        type: json["type"],
        unit: json["unit"],
        value: json["value"],
        visitId: json["visitId"],
      );

  Map<String, dynamic> toJson() => {
        "approvedAt": approvedAt.toIso8601String(),
        "caution": caution,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "group": group,
        "high": high,
        "id": id,
        "isCritical": isCritical,
        "low": low,
        "name": name,
        "patient": patient,
        "patientId": patientId,
        "requestedAt": requestedAt.toIso8601String(),
        "result": result,
        "resultType": resultType,
        "state": state,
        "takenAt": takenAt.toIso8601String(),
        "type": type,
        "unit": unit,
        "value": value,
        "visitId": visitId,
      };
}
