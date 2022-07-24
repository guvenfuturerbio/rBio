part of '../../abstract/app_config.dart';

class OneDoseDoctorEndpoints extends DoctorEndpoints {
  @override
  String get getMyBpPatient =>
      "/api/v1/DoctorPatient/get-my-bp-patient".xDoctorBaseUrl;

  @override
  String get getAllAppointment =>
      '/mobileapi/v1/MobileDoctor/all-appointment'.xDoctorBaseUrl;

  @override
  String get getMySugarPatient =>
      '/api/v1/DoctorPatient/get-my-sugar-patient'.xDoctorBaseUrl;

  @override
  String get getMyScalePatient =>
      '/api/v1/DoctorPatient/get-my-bmi-patient'.xDoctorBaseUrl;

  @override
  String get getMyBMIPatient =>
      '/api/v1/DoctorPatient/get-my-bmi-patient'.xDoctorBaseUrl;

  @override
  String getMyPatientDetail(patientId) =>
      '/api/v1/doctorpatient/get-my-patient-profile-detail/$patientId'
          .xDoctorBaseUrl;

  @override
  String updateMyPatientLimit(patientId) =>
      '/api/v1/doctorpatient/update-my-patient-limit-detail/$patientId'
          .xDoctorBaseUrl;

  @override
  String getMyPatientBloodGlucose(patientId) =>
      '/api/v1/doctorpatient/get-my-patient-blood-glucose-with-detail/$patientId'
          .xDoctorBaseUrl;

  @override
  String getMyPatientScale(patientId) =>
      '/api/v1/doctorpatient/get-my-patient-bmi/$patientId'.xDoctorBaseUrl;

  @override
  String getMyPatientPressure(patientId) =>
      '/api/v1/doctorpatient/get-my-patient-bp/$patientId'.xDoctorBaseUrl;

  @override
  String get getCurrentApplicationVersionPath =>
      '/api/v1/ApplicationMobileCheckVersion/get-current'.xDoctorBaseUrl;
}
