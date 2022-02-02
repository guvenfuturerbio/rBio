import 'department_model.dart';
import 'hospital_model.dart';

class HospitalDepartmentModel {
  DepartmentModel? department;
  HospitalModel? hospital;
  String? legacyId;
  int? id;

  HospitalDepartmentModel({
    this.department,
    this.hospital,
    this.legacyId,
    this.id,
  });

  HospitalDepartmentModel.fromJson(Map<String, dynamic> json) {
    department = json['department'] != null
        ? DepartmentModel.fromJson(json['department'] as Map<String, dynamic>)
        : null;
    hospital = json['hospital'] != null
        ? HospitalModel.fromJson(json['hospital'] as Map<String, dynamic>)
        : null;
    legacyId = json['legacy_id'] as String?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (department != null) {
      data['department'] = department?.toJson();
    }
    if (hospital != null) {
      data['hospital'] = hospital?.toJson();
    }
    data['legacy_id'] = legacyId;
    data['id'] = id;
    return data;
  }
}
