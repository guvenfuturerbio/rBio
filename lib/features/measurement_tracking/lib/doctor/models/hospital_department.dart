import 'department.dart';
import 'hospital.dart';

class HospitalDepartment {
  Department department;
  Hospital hospital;
  String legacyId;
  int id;

  HospitalDepartment({this.department, this.hospital, this.legacyId, this.id});

  HospitalDepartment.fromJson(Map<String, dynamic> json) {
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    hospital = json['hospital'] != null
        ? new Hospital.fromJson(json['hospital'])
        : null;
    legacyId = json['legacy_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.department != null) {
      data['department'] = this.department.toJson();
    }
    if (this.hospital != null) {
      data['hospital'] = this.hospital.toJson();
    }
    data['legacy_id'] = this.legacyId;
    data['id'] = this.id;
    return data;
  }
}