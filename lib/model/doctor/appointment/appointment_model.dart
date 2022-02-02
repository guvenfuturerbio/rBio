import 'availability_model.dart';
import 'doctor_hospital_department_model.dart';
import 'patient_for_appointment_model.dart';
import 'zoom_model.dart';

class Appointment {
  PatientForAppointmentModel? patient;
  AvailabilityModel? availability;
  String? pnrNumber;
  int? appointmentTypeCategoryId;
  String? webConsultAppId;
  List<String>? documents;
  DoctorHospitalDepartmentModel? doctorHospitalDepartment;
  int? videoType;
  ZoomModel? zoom;
  int? id;

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
        ? PatientForAppointmentModel.fromJson(
            json['patient'] as Map<String, dynamic>,
          )
        : null;
    availability = json['availability'] != null
        ? AvailabilityModel.fromJson(
            json['availability'] as Map<String, dynamic>,
          )
        : null;
    pnrNumber = json['pnr_number'] as String?;
    appointmentTypeCategoryId = json['appointment_type_category_id'] as int?;
    webConsultAppId = json['web_consult_app_id'] as String?;
    documents = json['documents'].cast<String>() as List<String>?;
    doctorHospitalDepartment = json['doctor_hospital_department'] != null
        ? DoctorHospitalDepartmentModel.fromJson(
            json['doctor_hospital_department'] as Map<String, dynamic>,
          )
        : null;
    videoType = json['video_type'] as int?;
    zoom = json['zoom'] != null
        ? ZoomModel.fromJson(json['zoom'] as Map<String, dynamic>)
        : null;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (patient != null) {
      data['patient'] = patient?.toJson();
    }
    if (availability != null) {
      data['availability'] = availability?.toJson();
    }
    data['pnr_number'] = pnrNumber;
    data['appointment_type_category_id'] = appointmentTypeCategoryId;
    data['web_consult_app_id'] = webConsultAppId;
    data['documents'] = documents;
    if (doctorHospitalDepartment != null) {
      data['doctor_hospital_department'] = doctorHospitalDepartment?.toJson();
    }
    data['video_type'] = videoType;
    if (zoom != null) {
      data['zoom'] = zoom?.toJson();
    }
    data['id'] = id;
    return data;
  }
}
