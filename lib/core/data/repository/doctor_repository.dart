import '../../../model/model.dart';
import '../../core.dart';

class DoctorRepository {
  final DoctorApiService apiService;
  final LocalCacheService localCacheService;

  DoctorRepository({
    required this.apiService,
    required this.localCacheService,
  });

  Future<List<Appointment>> getAllAppointment(
    AppointmentFilter appointmentFilter,
  ) =>
      apiService.getAllAppointment(appointmentFilter);
  Future<List<DoctorGlucosePatientModel>> getMySugarPatient(
    GetMyPatientFilter getMyPatientFilter,
  ) =>
      apiService.getMySugarPatient(getMyPatientFilter);
  Future<List<DoctorGlucosePatientModel>> getMyScalePatient(
    GetMyPatientFilter getMyPatientFilter,
  ) =>
      apiService.getMyScalePatient(getMyPatientFilter);
  Future<List<DoctorBloodPressurePatientModel>> getMyBpPatient(
    GetMyPatientFilter getMyPatientFilter,
  ) =>
      apiService.getMyBpPatient(getMyPatientFilter);
  Future<List<DoctorBMIPatientModel>> getMyBMIPatient(
    GetMyPatientFilter getMyPatientFilter,
  ) =>
      apiService.getMyBMIPatient(getMyPatientFilter);
  Future<DoctorPatientDetailModel> getMyPatientDetail(int patientId) =>
      apiService.getMyPatientDetail(patientId);
  Future<bool> updateMyPatientLimit(
    int patientId,
    UpdateMyPatientLimit updateMyPatientLimit,
  ) =>
      apiService.updateMyPatientLimit(patientId, updateMyPatientLimit);
  Future<List<BloodGlucose>> getMyPatientBloodGlucose(
    int patientId,
    GetMyPatientFilter getMyPatientFilter,
  ) =>
      apiService.getMyPatientBloodGlucose(patientId, getMyPatientFilter);
  Future<List<ScaleModel>> getMyPatientScale(
    int patientId,
    GetMyPatientFilter getMyPatientFilter,
  ) =>
      apiService.getMyPatientScale(patientId, getMyPatientFilter);
  Future<List<BloodPressureModel>> getMyPatientBloodPressure(
    int patientId,
    GetMyPatientFilter getMyPatientFilter,
  ) =>
      apiService.getMyPatientBloodPressure(patientId, getMyPatientFilter);
}
