import 'department_model.dart';
import 'hospital_model.dart';

class HospitalDepartmentModel {
  DepartmentModel department;
  HospitalModel hospital;
  String legacyId;
  int id;

  HospitalDepartmentModel({
    this.department,
    this.hospital,
    this.legacyId,
    this.id,
  });

  HospitalDepartmentModel.fromJson(Map<String, dynamic> json) {
    department = json['department'] != null
        ? new DepartmentModel.fromJson(json['department'])
        : null;
    hospital = json['hospital'] != null
        ? new HospitalModel.fromJson(json['hospital'])
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
