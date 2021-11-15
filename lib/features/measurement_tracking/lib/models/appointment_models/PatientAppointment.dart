import 'package:onedosehealth/models/appointment_models/AppointmentTypeCategory.dart';
import 'package:onedosehealth/models/appointment_models/Availability.dart';
import 'package:onedosehealth/models/appointment_models/DoctorHospitalDepartment.dart';
import 'package:onedosehealth/models/appointment_models/Patient.dart';

class PatientAppointment {
  AppointmentTypeCategory appointmentTypeCategory;
  Availability availability;
  DoctorHospitalDepartment doctorHospitalDepartment;
  Patient patient;
  bool canDelete;
  String pnrNumber;
  bool isOldAppointment;
  String legacyId;
  String webUrl;
  String webConsultAppId;
  Null appointmentInterpreterId;
  int id;

  PatientAppointment(
      {this.appointmentTypeCategory,
      this.availability,
      this.doctorHospitalDepartment,
      this.patient,
      this.canDelete,
      this.pnrNumber,
      this.isOldAppointment,
      this.legacyId,
      this.webUrl,
      this.webConsultAppId,
      this.appointmentInterpreterId,
      this.id});

  PatientAppointment.fromJson(Map<String, dynamic> json) {
    appointmentTypeCategory = json['appointment_type_category'] != null
        ? new AppointmentTypeCategory.fromJson(
            json['appointment_type_category'])
        : null;
    availability = json['availability'] != null
        ? new Availability.fromJson(json['availability'])
        : null;
    doctorHospitalDepartment = json['doctor_hospital_department'] != null
        ? new DoctorHospitalDepartment.fromJson(
            json['doctor_hospital_department'])
        : null;
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    canDelete = json['can_delete'];
    pnrNumber = json['pnr_number'];
    isOldAppointment = json['is_old_appointment'];
    legacyId = json['legacy_id'];
    webUrl = json['web_url'];
    webConsultAppId = json['web_consult_app_id'];
    appointmentInterpreterId = json['appointment_interpreter_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointmentTypeCategory != null) {
      data['appointment_type_category'] = this.appointmentTypeCategory.toJson();
    }
    if (this.availability != null) {
      data['availability'] = this.availability.toJson();
    }
    if (this.doctorHospitalDepartment != null) {
      data['doctor_hospital_department'] =
          this.doctorHospitalDepartment.toJson();
    }
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    data['can_delete'] = this.canDelete;
    data['pnr_number'] = this.pnrNumber;
    data['is_old_appointment'] = this.isOldAppointment;
    data['legacy_id'] = this.legacyId;
    data['web_url'] = this.webUrl;
    data['web_consult_app_id'] = this.webConsultAppId;
    data['appointment_interpreter_id'] = this.appointmentInterpreterId;
    data['id'] = this.id;
    return data;
  }
}
