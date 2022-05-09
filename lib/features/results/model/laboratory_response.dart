class LaboratoryResponse {
  DateTime? approvedAt;
  String? caution;
  List<LaboratoryResponse>? children;
  String? group;
  double? high;
  int? id;
  bool? isCritical;
  double? low;
  String? name;
  String? patient;
  int? patientId;
  DateTime? requestedAt;
  String? result;
  int? resultType;
  int? state;
  DateTime? takenAt;
  int? type;
  String? unit;
  double? value;
  int? visitId;

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
        approvedAt: DateTime.parse(json["approvedAt"] as String),
        caution: json["caution"] as String?,
        children: List<LaboratoryResponse>.from(
          (json["children"] as List).map(
            (x) => LaboratoryResponse.fromJson(x as Map<String, dynamic>),
          ),
        ),
        group: json["group"] as String?,
        high: json["high"] as double?,
        id: json["id"] as int?,
        isCritical: json["isCritical"] as bool?,
        low: json["low"] as double?,
        name: json["name"] as String?,
        patient: json["patient"] as String?,
        patientId: json["patientId"] as int?,
        requestedAt: DateTime.parse(json["requestedAt"] as String),
        result: json["result"] as String?,
        resultType: json["resultType"] as int?,
        state: json["state"] as int?,
        takenAt: DateTime.parse(json["takenAt"] as String),
        type: json["type"] as int?,
        unit: json["unit"] as String?,
        value: json["value"] as double?,
        visitId: json["visitId"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "approvedAt": approvedAt?.toIso8601String(),
        "caution": caution,
        "children": List<dynamic>.from(children!.map((x) => x.toJson())),
        "group": group,
        "high": high,
        "id": id,
        "isCritical": isCritical,
        "low": low,
        "name": name,
        "patient": patient,
        "patientId": patientId,
        "requestedAt": requestedAt?.toIso8601String(),
        "result": result,
        "resultType": resultType,
        "state": state,
        "takenAt": takenAt?.toIso8601String(),
        "type": type,
        "unit": unit,
        "value": value,
        "visitId": visitId,
      };
}
