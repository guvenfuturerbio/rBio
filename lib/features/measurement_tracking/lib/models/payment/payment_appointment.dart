import 'package:json_annotation/json_annotation.dart';
part 'payment_appointment.g.dart';

@JsonSerializable()
class PaymentAppointment {
  @JsonKey(name: 'appointment_date')
  String appointmentDate;
  @JsonKey(name: 'appointment_type_category_id')
  int appointmentTypeCategoryId;
  @JsonKey(name: 'availability_id')
  int availabilityId;
  @JsonKey(name: 'doctor_hospital_department_id')
  int doctorHospitalDepartmentId;
  @JsonKey(name: 'doctor_id')
  String doctorId;
  @JsonKey(name: 'is_normal_appointment')
  bool isNormalPaymentAppointment;
  @JsonKey(name: 'patient_id')
  int patientId;
  @JsonKey(name: 'patient_identification_id')
  String patientIdentificationId;
  @JsonKey(name: 'patient_user_name')
  String patientUserName;
  @JsonKey(name: 'patient_user_phone_number')
  String patientUserPhoneNumber;

  PaymentAppointment({
    this.appointmentDate,
    this.appointmentTypeCategoryId,
    this.availabilityId,
    this.doctorHospitalDepartmentId,
    this.doctorId,
    this.isNormalPaymentAppointment,
    this.patientId,
    this.patientIdentificationId,
    this.patientUserName,
    this.patientUserPhoneNumber
  });

  factory PaymentAppointment.fromJson(Map<String, dynamic> json) => _$PaymentAppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentAppointmentToJson(this);
}