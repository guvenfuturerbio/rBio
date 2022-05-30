import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../features/chronic_tracking/scale/scale.dart';
import '../../../features/doctor/treatment/diet_detail/model/doctor_diet_list_add_request.dart';
import '../../../model/model.dart';
import '../../core.dart';
import 'model/patient_scale_measurement.dart';

part 'doctor_service_impl.dart';

abstract class DoctorApiService {
  final IDioHelper helper;
  DoctorApiService(this.helper);

  Future<RbioLoginResponse> login(
      String userId, String password, String consentId);
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
  Future<List<PatientScaleMeasurement>> getMyPatientScale(
      int patientId, GetMyPatientFilter getMyPatientFilter);
  Future<List<BloodPressureModel>> getMyPatientBloodPressure(
      int patientId, GetMyPatientFilter getMyPatientFilter);

  Future<ScaleTreatmentResponse> getTreatmentNoteWithDietDoctor(
    int patientId,
    ScaleTreatmentRequest request,
  );

  Future<GuvenResponseModel> treatmentGetDetail(int id);
  Future<GuvenResponseModel> treatmentAddDiet(
    int patientId,
    DoctorDietListAddRequest model,
  );
  Future<GuvenResponseModel> deleteNoteDiet(
    TreatmentItemType type,
    int id,
  );
}
