part of '../repository/doctor_repository.dart';

abstract class DoctorApiService {
  final IDioHelper helper;
  DoctorApiService(this.helper);

  Future<RbioLoginResponse> login(String userId, String password);
  Future<List<Appointment>> getAllAppointment(
      AppointmentFilter appointmentFilter);
  Future<List<DoctorPatientModel>> getMySugarPatient(
      GetMyPatientFilter getMyPatientFilter);
  Future<List<DoctorPatientModel>> getMyScalePatient(
      GetMyPatientFilter getMyPatientFilter);
  Future<List<DoctorPatientModel>> getMyBpPatient(
      GetMyPatientFilter getMyPatientFilter);
  Future<DoctorPatientDetailModel> getMyPatientDetail(int patientId);
  Future<bool> updateMyPatientLimit(
      int patientId, UpdateMyPatientLimit updateMyPatientLimit);
  Future<List<BloodGlucose>> getMyPatientBloodGlucose(
      int patientId, GetMyPatientFilter getMyPatientFilter);
  Future<List<BloodGlucose>> getMyPatientScale(
      int patientId, GetMyPatientFilter getMyPatientFilter);
  Future<List<BloodGlucose>> getMyPatientBloodPressure(
      int patientId, GetMyPatientFilter getMyPatientFilter);
}
