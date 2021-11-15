// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentAppointment _$PaymentAppointmentFromJson(Map<String, dynamic> json) {
  return PaymentAppointment(
    appointmentDate: json['appointment_date'] as String,
    appointmentTypeCategoryId: json['appointment_type_category_id'] as int,
    availabilityId: json['availability_id'] as int,
    doctorHospitalDepartmentId: json['doctor_hospital_department_id'] as int,
    doctorId: json['doctor_id'] as String,
    isNormalPaymentAppointment: json['is_normal_appointment'] as bool,
    patientId: json['patient_id'] as int,
    patientIdentificationId: json['patient_identification_id'] as String,
    patientUserName: json['patient_user_name'] as String,
    patientUserPhoneNumber: json['patient_user_phone_number'] as String,
  );
}

Map<String, dynamic> _$PaymentAppointmentToJson(PaymentAppointment instance) =>
    <String, dynamic>{
      'appointment_date': instance.appointmentDate,
      'appointment_type_category_id': instance.appointmentTypeCategoryId,
      'availability_id': instance.availabilityId,
      'doctor_hospital_department_id': instance.doctorHospitalDepartmentId,
      'doctor_id': instance.doctorId,
      'is_normal_appointment': instance.isNormalPaymentAppointment,
      'patient_id': instance.patientId,
      'patient_identification_id': instance.patientIdentificationId,
      'patient_user_name': instance.patientUserName,
      'patient_user_phone_number': instance.patientUserPhoneNumber,
    };
