import '../../../features/chronic_tracking/scale/scale.dart';
import '../../../model/model.dart';
import '../../core.dart';
import '../service/model/patient_scale_measurement.dart';

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
  Future<List<PatientScaleMeasurement>> getMyPatientScale(
    int patientId,
    GetMyPatientFilter getMyPatientFilter,
  ) =>
      apiService.getMyPatientScale(patientId, getMyPatientFilter);
  Future<List<BloodPressureModel>> getMyPatientBloodPressure(
    int patientId,
    GetMyPatientFilter getMyPatientFilter,
  ) =>
      apiService.getMyPatientBloodPressure(patientId, getMyPatientFilter);

  Future<List<RbioTreatmentModel>> getTreatmentNoteWithDietDoctor(
    int patientId,
    ScaleTreatmentRequest request,
  ) async {
    final result = <RbioTreatmentModel>[];
    final list =
        await apiService.getTreatmentNoteWithDietDoctor(patientId, request);
    result.addAll(
      (list.dietList ?? []).map(
        (e) => RbioTreatmentModel(
          id: e.id ?? -1,
          description: e.dietTitle ?? '',
          dateTime: e.dietCreateDate,
          type: TreatmentType.diet,
        ),
      ),
    );

    result.addAll(
      (list.treatmentNoteList ?? []).map(
        (e) => RbioTreatmentModel(
          id: e.id ?? -1,
          description: e.createdByName ?? '',
          dateTime: e.treatmentNoteCreateDate,
          type: TreatmentType.treatmentNote,
        ),
      ),
    );

    result.addAll(
      (list.doctorNoteList ?? []).map(
        (e) => RbioTreatmentModel(
          id: e.id ?? -1,
          description: e.treatmentNoteTitle ?? '',
          dateTime: e.treatmentNoteCreateDate,
          type: TreatmentType.doctorNote,
        ),
      ),
    );

    return result
        .xSortedBy((e) => e.dateTime ?? DateTime.now())
        .toList()
        .reversed
        .toList();
  }
}
