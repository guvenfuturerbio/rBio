import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../features/chronic_tracking/scale/scale.dart';
import '../../../features/mediminder/mediminder.dart';
import '../../../model/bg_measurement/blood_glucose_report_body.dart';
import '../../../model/bg_measurement/blood_glucose_value_model.dart';
import '../../../model/bg_measurement/delete_bg_measurement_request.dart';
import '../../../model/bg_measurement/get_blood_glucose_data_of_person.dart';
import '../../../model/bg_measurement/get_hba1c_measurement_list.dart';
import '../../../model/bg_measurement/hospital_hba1c_measurement.dart';
import '../../../model/bg_measurement/update_bg_measurement_request.dart';
import '../../../model/model.dart';
import '../../../model/user_profiles/save_and_retrieve_token_model.dart';
import '../../core/core.dart';

part 'chronic_tracking_service_impl.dart';

abstract class ChronicTrackingApiService {
  final IDioHelper helper;
  ChronicTrackingApiService(this.helper);

  Future<GuvenResponseModel> saveAndRetrieveToken(
    SaveAndRetrieveTokenModel saveAndRetrieveToken,
    String token,
  );
  Future<StripDetailModel> getUserStrip(int entegrationId, String? deviceUUID);
  Future<GuvenResponseModel> insertNewBloodGlucoseValue(
    BloodGlucoseValue bodyPages, {
    CancelToken? cancelToken,
  });
  Future<GuvenResponseModel> deleteBloodGlucoseValue(
    DeleteBloodGlucoseMeasurementRequest deleteBloodGlucoseMeasurementRequest,
  );
  Future<GuvenResponseModel> updateBloodGlucoseValue(
    UpdateBloodGlucoseMeasurementRequest updateBloodGlucoseMeasurementRequest,
  );
  Future<GuvenResponseModel> uploadMeasurementImage(
    String file,
    int entegrationId,
    int measurementId,
  );
  Future<GuvenResponseModel> getBloodGlucoseReport(
    BloodGlucoseReportBody bloodGlucoseReportBody,
  );
  Future<GuvenResponseModel> getBloodGlucoseDataOfPerson(
    GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson,
  );
  Future<List<Person>> getAllProfiles();
  Future<GuvenResponseModel> addProfile(Person person);
  Future<GuvenResponseModel> changeProfile(int userId);
  Future<GuvenResponseModel> deleteProfile(int userId);
  Future<GuvenResponseModel> updateProfile(Person person, int id);
  Future<GuvenResponseModel> setDefaultProfile(Person person);
  Future<GuvenResponseModel> updateUserStrip(StripDetailModel stripDetailModel);
  Future<GuvenResponseModel> deleteUserStrip(int id, int entegrationId);
  Future<GuvenResponseModel> isDeviceIdRegisteredForSomeUser(
    String deviceId,
    int entegrationId,
  );
  Future<GuvenResponseModel> addHospitalHba1cMeasurement(
    HospitalHba1cMeasurementModel hospitalHba1cMeasurementModel,
    int entegrationId,
  );
  Future<GuvenResponseModel> getHba1cMeasurementList(
    GetHba1cMeasurementListModel getHba1cMeasurementListModel,
    int entegrationId,
  );
  Future<GuvenResponseModel> getMedicineByFilter(String text);

  Future<GuvenResponseModel> insertNewBpValue(AddBpWithDetail addBpWithDetail);

  Future<GuvenResponseModel> deleteBpMeasurement(
    DeleteBpMeasurements deleteBpMeasurements,
  );

  Future<GuvenResponseModel> getBpMasurement(
    GetBpMeasurements getBpMeasurements,
  );

  Future<GuvenResponseModel> updateBpMeasurement(
    UpdateBpMeasurements updateBpMeasurements,
  );

  Future<GuvenResponseModel> addTreatment(Person person, String treatment);

  Future<ScaleTreatmentResponse> getTreatmentNoteWithDiet(
    int? entegrationId,
    ScaleTreatmentRequest request,
  );

  Future<GuvenResponseModel> treatmentGetDetail(
    TreatmentItemType itemType,
    int id,
  );

  Future<GuvenResponseModel> addTreatmentNote(
    int? entegrationId,
    PatientTreatmentAddRequest model,
  );
}
