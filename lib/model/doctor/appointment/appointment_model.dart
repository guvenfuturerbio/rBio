import 'availability_model.dart';
import 'doctor_hospital_department_model.dart';
import 'patient_for_appointment_model.dart';
import 'zoom_model.dart';

class Appointment {
  PatientForAppointmentModel patient;
  AvailabilityModel availability;
  String pnrNumber;
  int appointmentTypeCategoryId;
  String webConsultAppId;
  List<String> documents;
  DoctorHospitalDepartmentModel doctorHospitalDepartment;
  int videoType;
  ZoomModel zoom;
  int id;

  Appointment({
    this.patient,
    this.availability,
    this.pnrNumber,
    this.appointmentTypeCategoryId,
    this.webConsultAppId,
    this.documents,
    this.doctorHospitalDepartment,
    this.videoType,
    this.zoom,
    this.id,
  });

  Appointment.fromJson(Map<String, dynamic> json) {
    patient = json['patient'] != null
        ? new PatientForAppointmentModel.fromJson(json['patient'])
        : null;
    availability = json['availability'] != null
        ? new AvailabilityModel.fromJson(json['availability'])
        : null;
    pnrNumber = json['pnr_number'];
    appointmentTypeCategoryId = json['appointment_type_category_id'];
    webConsultAppId = json['web_consult_app_id'];
    documents = json['documents'].cast<String>();
    doctorHospitalDepartment = json['doctor_hospital_department'] != null
        ? new DoctorHospitalDepartmentModel.fromJson(
            json['doctor_hospital_department'])
        : null;
    videoType = json['video_type'];
    zoom = json['zoom'] != null ? new ZoomModel.fromJson(json['zoom']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    if (this.availability != null) {
      data['availability'] = this.availability.toJson();
    }
    data['pnr_number'] = this.pnrNumber;
    data['appointment_type_category_id'] = this.appointmentTypeCategoryId;
    data['web_consult_app_id'] = this.webConsultAppId;
    data['documents'] = this.documents;
    if (this.doctorHospitalDepartment != null) {
      data['doctor_hospital_department'] =
          this.doctorHospitalDepartment.toJson();
    }
    data['video_type'] = this.videoType;
    if (this.zoom != null) {
      data['zoom'] = this.zoom.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}
