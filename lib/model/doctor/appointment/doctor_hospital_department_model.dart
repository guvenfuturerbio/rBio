import 'hospital_department_model.dart';

class DoctorHospitalDepartmentModel {
  HospitalDepartmentModel? hospitalDepartment;
  bool? areAppointmentsAvailable;
  bool? isSgkAgreementPossible;
  bool? isWebAppointmentAvailable;
  String? doctorLegacyId;
  int? id;

  DoctorHospitalDepartmentModel({
    this.hospitalDepartment,
    this.areAppointmentsAvailable,
    this.isSgkAgreementPossible,
    this.isWebAppointmentAvailable,
    this.doctorLegacyId,
    this.id,
  });

  DoctorHospitalDepartmentModel.fromJson(Map<String, dynamic> json) {
    hospitalDepartment = json['hospital_department'] != null
        ? HospitalDepartmentModel.fromJson(
            json['hospital_department'] as Map<String, dynamic>,
          )
        : null;
    areAppointmentsAvailable = json['are_appointments_available'] as bool?;
    isSgkAgreementPossible = json['is_sgk_agreement_possible'] as bool?;
    isWebAppointmentAvailable = json['is_web_appointment_available'] as bool?;
    doctorLegacyId = json['doctor_legacy_id'] as String?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hospitalDepartment != null) {
      data['hospital_department'] = hospitalDepartment?.toJson();
    }
    data['are_appointments_available'] = areAppointmentsAvailable;
    data['is_sgk_agreement_possible'] = isSgkAgreementPossible;
    data['is_web_appointment_available'] = isWebAppointmentAvailable;
    data['doctor_legacy_id'] = doctorLegacyId;
    data['id'] = id;
    return data;
  }
}
