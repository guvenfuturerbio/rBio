// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) {
  return Doctor(
    employee: json['employee'] == null
        ? null
        : Employee.fromJson(json['employee'] as Map<String, dynamic>),
    title: json['title'] == null
        ? null
        : Title.fromJson(json['title'] as Map<String, dynamic>),
    workingTitle: json['working_title'] == null
        ? null
        : Title.fromJson(json['working_title'] as Map<String, dynamic>),
    doctorSpecialities: (json['doctor_specialities'] as List)
        ?.map((e) => e == null
            ? null
            : DoctorSpecialities.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    doctorHospitalDepartments: (json['doctor_hospital_departments'] as List)
        ?.map((e) => e == null
            ? null
            : DoctorHospitalDepartment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    doctorDiseases: (json['doctor_diseases'] as List)
        ?.map((e) => e == null
            ? null
            : DoctorDiseases.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    diplomaNo: json['diploma_no'] as String,
    employeeConsultants:
        (json['employee_consultants'] as List)?.map((e) => e as int)?.toList(),
    imgUrl: json['img_url'] as String,
    webSiteId: json['web_site_id'] as int,
    onlineAppointmentFee: (json['online_appointment_fee'] as num)?.toDouble(),
    onlineAppointmentFeeDolar:
        (json['online_appointment_fee_dolar'] as num)?.toDouble(),
    onlineAppointmentFeeEuro:
        (json['online_appointment_fee_euro'] as num)?.toDouble(),
    videoCheckUpFee: (json['video_check_up_fee'] as num)?.toDouble(),
    secondVideoCheckUpFee:
        (json['second_video_check_up_fee'] as num)?.toDouble(),
    id: json['id'] as int,
  )..doctorHospitalDepartment = json['doctor_hospital_department'] == null
      ? null
      : DoctorHospitalDepartment.fromJson(
          json['doctor_hospital_department'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'employee': instance.employee,
      'title': instance.title,
      'working_title': instance.workingTitle,
      'doctor_specialities': instance.doctorSpecialities,
      'doctor_hospital_departments': instance.doctorHospitalDepartments,
      'doctor_hospital_department': instance.doctorHospitalDepartment,
      'doctor_diseases': instance.doctorDiseases,
      'diploma_no': instance.diplomaNo,
      'employee_consultants': instance.employeeConsultants,
      'img_url': instance.imgUrl,
      'web_site_id': instance.webSiteId,
      'online_appointment_fee': instance.onlineAppointmentFee,
      'online_appointment_fee_dolar': instance.onlineAppointmentFeeDolar,
      'online_appointment_fee_euro': instance.onlineAppointmentFeeEuro,
      'video_check_up_fee': instance.videoCheckUpFee,
      'second_video_check_up_fee': instance.secondVideoCheckUpFee,
      'id': instance.id,
    };
