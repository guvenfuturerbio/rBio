part of '../repository/doctor_repository.dart';

abstract class DoctorApiService {
  final IDioHelper helper;
  DoctorApiService(this.helper);

  Future<DoctorLoginResponse> login(String userId, String password);
  Future<List<Appointment>> getAllAppointment(
      AppointmentFilter appointmentFilter);
  Future<List<DoctorPatientModel>> getMyPatients(GetMyPatientFilter getMyPatientFilter);
  Future<DoctorPatientDetailModel> getMyPatientDetail(int patientId);
  Future<bool> updateMyPatientLimit(
      int patientId, UpdateMyPatientLimit updateMyPatientLimit);
  Future<List<BloodGlucose>> getMyPatientBloodGlucose(
      int patientId, GetMyPatientFilter getMyPatientFilter);
}
