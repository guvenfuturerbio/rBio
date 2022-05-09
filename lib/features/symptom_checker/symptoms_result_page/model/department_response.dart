class GetDepartmentIdResponse {
  String? id;
  String? departmentName;
  String? apimedicId;

  GetDepartmentIdResponse({this.id, this.departmentName, this.apimedicId});

  GetDepartmentIdResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    departmentName = json['department_name'] as String?;
    apimedicId = json['apimedic_id'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['department_name'] = departmentName;
    data['apimedic_id'] = apimedicId;
    return data;
  }
}
