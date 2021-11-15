

import 'HospitalDepartment.dart';

class DoctorHospitalDepartment {
  HospitalDepartment hospitalDepartment;
  bool areAppointmentsAvailable;
  bool isSgkAgreementPossible;
  bool isWebAppointmentAvailable;
  String doctorLegacyId;
  int id;

  DoctorHospitalDepartment(
      {this.hospitalDepartment,
        this.areAppointmentsAvailable,
        this.isSgkAgreementPossible,
        this.isWebAppointmentAvailable,
        this.doctorLegacyId,
        this.id});

  DoctorHospitalDepartment.fromJson(Map<String, dynamic> json) {
    hospitalDepartment = json['hospital_department'] != null
        ? new HospitalDepartment.fromJson(json['hospital_department'])
        : null;
    areAppointmentsAvailable = json['are_appointments_available'];
    isSgkAgreementPossible = json['is_sgk_agreement_possible'];
    isWebAppointmentAvailable = json['is_web_appointment_available'];
    doctorLegacyId = json['doctor_legacy_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hospitalDepartment != null) {
      data['hospital_department'] = this.hospitalDepartment.toJson();
    }
    data['are_appointments_available'] = this.areAppointmentsAvailable;
    data['is_sgk_agreement_possible'] = this.isSgkAgreementPossible;
    data['is_web_appointment_available'] = this.isWebAppointmentAvailable;
    data['doctor_legacy_id'] = this.doctorLegacyId;
    data['id'] = this.id;
    return data;
  }
}
