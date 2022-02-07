part of '../imports/cronic_tracking.dart';

abstract class ChronicTrackingApiService {
  final IDioHelper helper;
  ChronicTrackingApiService(this.helper);

  Future<GuvenResponseModel> saveAndRetrieveToken(
    SaveAndRetrieveTokenModel saveAndRetrieveToken,
    String token,
  );
  Future<StripDetailModel> getUserStrip(int entegrationId, String? deviceUUID);
  Future<GuvenResponseModel> insertNewBloodGlucoseValue(
    BloodGlucoseValue bodyPages,
  );
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
  Future<GuvenResponseModel> addFirebaseToken(
    AddFirebaseToken addFirebaseToken,
  );
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
  Future<GuvenResponseModel> insertNewScaleValue(
    AddScaleMasurementBody addScaleMasurementBody,
  );
  Future<GuvenResponseModel> deleteScaleMeasurement(
    DeleteScaleMasurementBody deleteScaleMasurementBody,
  );
  Future<GuvenResponseModel> getScaleMasurement(
    GetScaleMasurementBody getScaleMasurementBody,
  );
  Future<GuvenResponseModel> updateScaleMeasurement(
    UpdateScaleMasurementBody updateScaleMasurementBody,
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
}
