import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../features/chronic_tracking/scale/scale.dart';
import '../../../features/doctor/treatment/diet_add_edit/diet_add_edit.dart';
import '../../../model/model.dart';
import '../../config/config.dart';
import '../../core/core.dart';

part 'doctor_service_impl.dart';

abstract class DoctorApiService {
  final IDioHelper helper;
  DoctorApiService(this.helper);

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

  Future<GuvenResponseModel> treatmentGetDetail(
    TreatmentItemType type,
    int id,
  );
  Future<GuvenResponseModel> treatmentAddDiet(
    int patientId,
    ScaleDietListAddRequest model,
  );
  Future<GuvenResponseModel> deleteNoteDiet(
    TreatmentItemType type,
    int id,
  );

  Future<GuvenResponseModel> addTreatmentNote(
    int patientId,
    PatientTreatmentAddRequest model,
  );
}
