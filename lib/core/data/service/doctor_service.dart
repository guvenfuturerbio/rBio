part of '../repository/doctor_repository.dart';

abstract class DoctorApiService {
  final IDioHelper helper;
  DoctorApiService(this.helper);

  Future<RbioLoginResponse> login(String userId, String password);
  Future<List<Appointment>> getAllAppointment(
      AppointmentFilter appointmentFilter);
  Future<List<DoctorGlucosePatientModel>> getMySugarPatient(
      GetMyPatientFilter getMyPatientFilter);
  Future<List<DoctorGlucosePatientModel>> getMyScalePatient(
      GetMyPatientFilter getMyPatientFilter);
  Future<List<DoctorBloodPressurePatientModel>> getMyBpPatient(
      GetMyPatientFilter getMyPatientFilter);
  Future<List<DoctorBMIPatientModel>> getMyBMIPatient(
      GetMyPatientFilter getMyPatientFilter);
  Future<DoctorPatientDetailModel> getMyPatientDetail(int patientId);
  Future<bool> updateMyPatientLimit(
      int patientId, UpdateMyPatientLimit updateMyPatientLimit);
  Future<List<BloodGlucose>> getMyPatientBloodGlucose(
      int patientId, GetMyPatientFilter getMyPatientFilter);
  Future<List<ScaleModel>> getMyPatientScale(
      int patientId, GetMyPatientFilter getMyPatientFilter);
  Future<List<BloodGlucose>> getMyPatientBloodPressure(
      int patientId, GetMyPatientFilter getMyPatientFilter);
}
