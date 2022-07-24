import 'package:dio/dio.dart';

import '../../../features/chronic_tracking/scale/scale.dart';
import '../../../features/mediminder/mediminder.dart';
import '../../core/core.dart';
import '../../features/auth/shared/shared.dart';
import '../../features/chronic_tracking/blood_glucose/model/model.dart';
import '../../features/chronic_tracking/blood_pressure/model/model.dart';

class ChronicTrackingRepository {
  final ChronicTrackingApiService apiService;
  final LocalCacheManager localCacheService;

  ChronicTrackingRepository({
    required this.apiService,
    required this.localCacheService,
  });

  Future<StripDetailModel> getUserStrip(
          int entegrationId, String? deviceUUID) =>
      apiService.getUserStrip(entegrationId, deviceUUID);
  Future<GuvenResponseModel> insertNewBloodGlucoseValue(
    BloodGlucoseValue bodyPages, {
    CancelToken? cancelToken,
  }) =>
      apiService.insertNewBloodGlucoseValue(bodyPages,
          cancelToken: cancelToken);
  Future<GuvenResponseModel> deleteBloodGlucoseValue(
    DeleteBloodGlucoseMeasurementRequest deleteBloodGlucoseMeasurementRequest,
  ) =>
      apiService.deleteBloodGlucoseValue(deleteBloodGlucoseMeasurementRequest);
  Future<GuvenResponseModel> updateBloodGlucoseValue(
    UpdateBloodGlucoseMeasurementRequest updateBloodGlucoseMeasurementRequest,
  ) =>
      apiService.updateBloodGlucoseValue(updateBloodGlucoseMeasurementRequest);
  Future<GuvenResponseModel> uploadMeasurementImage(
    String file,
    int entegrationId,
    int measurementId,
  ) =>
      apiService.uploadMeasurementImage(file, entegrationId, measurementId);
  Future<GuvenResponseModel> getBloodGlucoseDataOfPerson(
    GetBloodGlucoseDataOfPerson data,
  ) =>
      apiService.getBloodGlucoseDataOfPerson(data);
  Future<List<Person>> getAllProfiles() => apiService.getAllProfiles();
  Future<GuvenResponseModel> addProfile(Person person) =>
      apiService.addProfile(person);
  Future<GuvenResponseModel> updateProfile(Person person, int id) =>
      apiService.updateProfile(person, id);
  Future<GuvenResponseModel> addTreatment(Person person, String treatment) =>
      apiService.addTreatment(person, treatment);
  Future<GuvenResponseModel> setDefaultProfile(Person person) =>
      apiService.setDefaultProfile(person);
  Future<GuvenResponseModel> updateUserStrip(
    StripDetailModel stripDetailModel,
  ) =>
      apiService.updateUserStrip(stripDetailModel);
  Future<GuvenResponseModel> deleteUserStrip(int id, int entegrationId) =>
      apiService.deleteUserStrip(id, entegrationId);
  Future<GuvenResponseModel> isDeviceIdRegisteredForSomeUser(
    String deviceId,
    int entegrationId,
  ) =>
      apiService.isDeviceIdRegisteredForSomeUser(deviceId, entegrationId);

  // Bp Definitions
  Future<GuvenResponseModel> insertNewBpValue(
    AddBpWithDetail addBpWithDetail,
  ) =>
      apiService.insertNewBpValue(addBpWithDetail);
  Future<GuvenResponseModel> deleteBpMeasurement(
    DeleteBpMeasurements deleteBpMeasurements,
  ) =>
      apiService.deleteBpMeasurement(deleteBpMeasurements);
  Future<GuvenResponseModel> getBpDataOfPerson(
    GetBpMeasurements getBpMeasurements,
  ) =>
      apiService.getBpMasurement(getBpMeasurements);
  Future<GuvenResponseModel> updateBpMeasurement(
    UpdateBpMeasurements updateBpMeasurements,
  ) =>
      apiService.updateBpMeasurement(updateBpMeasurements);

  Future<List<RbioTreatmentModel>> getTreatmentNoteWithDiet(
    int? entegrationId,
    ScaleTreatmentRequest request,
  ) async {
    final result = <RbioTreatmentModel>[];
    final list =
        await apiService.getTreatmentNoteWithDiet(entegrationId, request);
    result.addAll(
      (list.dietList ?? []).map(
        (e) => RbioTreatmentModel(
          id: e.id ?? -1,
          description: e.createdByName ?? '',
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

    return result
        .xSortedBy((e) => e.dateTime ?? DateTime.now())
        .toList()
        .reversed
        .toList();
  }

  Future<ScaleTreatmentDietDetailResponse> treatmentDietGetDetail(
      int id) async {
    final guvenResponseModel =
        await apiService.treatmentGetDetail(TreatmentItemType.diet, id);
    return ScaleTreatmentDietDetailResponse.fromJson(
        guvenResponseModel.xGetMap);
  }

  Future<ScaleTreatmentDetailResponse> treatmentGetDetail(int id) async {
    final guvenResponseModel =
        await apiService.treatmentGetDetail(TreatmentItemType.treatment, id);
    return ScaleTreatmentDetailResponse.fromJson(guvenResponseModel.xGetMap);
  }

  Future<GuvenResponseModel> addTreatmentNote(
    int? entegrationId,
    PatientTreatmentAddRequest model,
  ) =>
      apiService.addTreatmentNote(entegrationId, model);
}
