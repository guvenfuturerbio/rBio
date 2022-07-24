part of '../../abstract/app_config.dart';

class GuvenDoctorEndpoints extends DoctorEndpoints {
  @override
  String get getAllAppointment =>
      throw RbioUndefinedEndpointException("getAllAppointment");

  @override
  String get getMyBMIPatient =>
      throw RbioUndefinedEndpointException("getMyBMIPatient");

  @override
  String get getMyBpPatient =>
      throw RbioUndefinedEndpointException("getMyBpPatient");

  @override
  String getMyPatientBloodGlucose(int patientId) =>
      throw RbioUndefinedEndpointException("getMyPatientBloodGlucose");

  @override
  String getMyPatientDetail(int patientId) =>
      throw RbioUndefinedEndpointException("getMyPatientDetail");

  @override
  String getMyPatientPressure(int patientId) =>
      throw RbioUndefinedEndpointException("getMyPatientPressure");

  @override
  String getMyPatientScale(int patientId) =>
      throw RbioUndefinedEndpointException("getMyPatientScale");

  @override
  String get getMyScalePatient =>
      throw RbioUndefinedEndpointException("getMyScalePatient");

  @override
  String get getMySugarPatient =>
      throw RbioUndefinedEndpointException("getMySugarPatient");

  @override
  String updateMyPatientLimit(int patientId) =>
      throw RbioUndefinedEndpointException("updateMyPatientLimit");

  @override
  String get getCurrentApplicationVersionPath =>
      '/applicationmobilecheckversion/get-current'.xBaseUrl;
}
