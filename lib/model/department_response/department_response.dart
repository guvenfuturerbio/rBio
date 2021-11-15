class GetDepartmentIdResponse {
  String id;
  String departmentName;
  String apimedicId;

  GetDepartmentIdResponse({this.id, this.departmentName, this.apimedicId});

  GetDepartmentIdResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentName = json['department_name'];
    apimedicId = json['apimedic_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department_name'] = this.departmentName;
    data['apimedic_id'] = this.apimedicId;
    return data;
  }
}
