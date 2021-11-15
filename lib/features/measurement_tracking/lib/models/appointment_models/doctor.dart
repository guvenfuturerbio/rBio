import 'DoctorDiseases.dart';
import 'DoctorHospitalDepartment.dart';
import 'DoctorSpecialities.dart';
import 'Title.dart';
import 'employee.dart';
import 'package:json_annotation/json_annotation.dart';
part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  @JsonKey(name: 'employee')
  Employee employee;
  @JsonKey(name: 'title')
  Title title;
  @JsonKey(name: 'working_title')
  Title workingTitle;
  @JsonKey(name: 'doctor_specialities')
  List<DoctorSpecialities> doctorSpecialities;
  @JsonKey(name: 'doctor_hospital_departments')
  List<DoctorHospitalDepartment> doctorHospitalDepartments;
  @JsonKey(name: "doctor_hospital_department")
  DoctorHospitalDepartment doctorHospitalDepartment;
  @JsonKey(name: 'doctor_diseases')
  List<DoctorDiseases> doctorDiseases;
  @JsonKey(name: 'diploma_no')
  String diplomaNo;
  @JsonKey(name: 'employee_consultants')
  List<int> employeeConsultants;
  @JsonKey(name: 'img_url')
  String imgUrl;
  @JsonKey(name: 'web_site_id')
  int webSiteId;
  @JsonKey(name: 'online_appointment_fee')
  double onlineAppointmentFee;
  @JsonKey(name: 'online_appointment_fee_dolar')
  double onlineAppointmentFeeDolar;
  @JsonKey(name: 'online_appointment_fee_euro')
  double onlineAppointmentFeeEuro;
  @JsonKey(name: 'video_check_up_fee')
  double videoCheckUpFee;
  @JsonKey(name: 'second_video_check_up_fee')
  double secondVideoCheckUpFee;
  @JsonKey(name: 'id')
  int id;

  Doctor(
      {this.employee,
        this.title,
        this.workingTitle,
        this.doctorSpecialities,
        this.doctorHospitalDepartments,
        this.doctorDiseases,
        this.diplomaNo,
        this.employeeConsultants,
        this.imgUrl,
        this.webSiteId,
        this.onlineAppointmentFee,
        this.onlineAppointmentFeeDolar,
        this.onlineAppointmentFeeEuro,
        this.videoCheckUpFee,
        this.secondVideoCheckUpFee,
        this.id});

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
