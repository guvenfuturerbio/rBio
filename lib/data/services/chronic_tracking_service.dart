import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../features/chronic_tracking/scale/scale.dart';
import '../../../features/mediminder/mediminder.dart';
import '../../config/config.dart';
import '../../core/core.dart';
import '../../features/auth/shared/shared.dart';
import '../../features/chronic_tracking/blood_glucose/model/model.dart';
import '../../features/chronic_tracking/blood_pressure/model/model.dart';

part 'chronic_tracking_service_impl.dart';

abstract class ChronicTrackingApiService {
  final IDioHelper helper;
  ChronicTrackingApiService(this.helper);

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
  Future<GuvenResponseModel> getBloodGlucoseDataOfPerson(
    GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson,
  );
  Future<List<Person>> getAllProfiles();
  Future<GuvenResponseModel> addProfile(Person person);
  Future<GuvenResponseModel> updateProfile(Person person, int id);
  Future<GuvenResponseModel> setDefaultProfile(Person person);
  Future<GuvenResponseModel> updateUserStrip(StripDetailModel stripDetailModel);
  Future<GuvenResponseModel> deleteUserStrip(int id, int entegrationId);
  Future<GuvenResponseModel> isDeviceIdRegisteredForSomeUser(
    String deviceId,
    int entegrationId,
  );
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
