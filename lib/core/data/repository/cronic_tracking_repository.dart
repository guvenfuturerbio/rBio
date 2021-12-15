part of '../imports/cronic_tracking.dart';

class ChronicTrackingRepository {
  final ChronicTrackingApiService apiService;
  final LocalCacheService localCacheService;

  ChronicTrackingRepository({
    @required this.apiService,
    @required this.localCacheService,
  });

  Future<LoginResponse> login(
          {String clientId,
          String grantType,
          String clientSecret,
          String scope,
          String username,
          String password}) =>
      apiService.login(
        clientId: clientId,
        grantType: grantType,
        clientSecret: clientSecret,
        scope: scope,
        username: username,
        password: password,
      );
  Future<GuvenResponseModel> saveAndRetrieveToken(
          SaveAndRetrieveTokenModel saveAndRetrieveToken, String token) =>
      apiService.saveAndRetrieveToken(saveAndRetrieveToken, token);
  Future<StripDetailModel> getUserStrip(entegrationId, deviceUUID) =>
      apiService.getUserStrip(entegrationId, deviceUUID);
  Future<GuvenResponseModel> insertNewBloodGlucoseValue(
          BloodGlucoseValue bodyPages) =>
      apiService.insertNewBloodGlucoseValue(bodyPages);
  Future<GuvenResponseModel> deleteBloodGlucoseValue(
          DeleteBloodGlucoseMeasurementRequest
              deleteBloodGlucoseMeasurementRequest) =>
      apiService.deleteBloodGlucoseValue(deleteBloodGlucoseMeasurementRequest);
  Future<GuvenResponseModel> updateBloodGlucoseValue(
          UpdateBloodGlucoseMeasurementRequest
              updateBloodGlucoseMeasurementRequest) =>
      apiService.updateBloodGlucoseValue(updateBloodGlucoseMeasurementRequest);
  Future<GuvenResponseModel> uploadMeasurementImage(
          String file, int entegrationId, int measurementId) =>
      apiService.uploadMeasurementImage(file, entegrationId, measurementId);
  Future<GuvenResponseModel> getBloodGlucoseReport(
          BloodGlucoseReportBody bloodGlucoseReportBody) =>
      apiService.getBloodGlucoseReport(bloodGlucoseReportBody);
  Future<GuvenResponseModel> getBloodGlucoseDataOfPerson(
          GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson) =>
      apiService.getBloodGlucoseDataOfPerson(getBloodGlucoseDataOfPerson);
  Future<List<Person>> getAllProfiles() => apiService.getAllProfiles();
  Future<GuvenResponseModel> addProfile(Person person) =>
      apiService.addProfile(person);
  Future<GuvenResponseModel> changeProfile(userId) =>
      apiService.changeProfile(userId);
  Future<GuvenResponseModel> deleteProfile(var userId) =>
      apiService.deleteProfile(userId);
  Future<GuvenResponseModel> addFirebaseToken(
          AddFirebaseToken addFirebaseToken) =>
      apiService.addFirebaseToken(addFirebaseToken);
  Future<GuvenResponseModel> updateProfile(Person person, int id) =>
      apiService.updateProfile(person, id);
  Future<GuvenResponseModel> setDefaultProfile(Person person) =>
      apiService.setDefaultProfile(person);
  Future<GuvenResponseModel> updateUserStrip(
          StripDetailModel stripDetailModel) =>
      apiService.updateUserStrip(stripDetailModel);
  Future<GuvenResponseModel> deleteUserStrip(var id, var entegrationId) =>
      apiService.deleteUserStrip(id, entegrationId);
  Future<GuvenResponseModel> isDeviceIdRegisteredForSomeUser(
          var deviceId, var entegrationId) =>
      apiService.isDeviceIdRegisteredForSomeUser(deviceId, entegrationId);
  Future<GuvenResponseModel> addHospitalHba1cMeasurement(
          HospitalHba1cMeasurementModel hospitalHba1cMeasurementModel,
          var entegrationId) =>
      apiService.addHospitalHba1cMeasurement(
          hospitalHba1cMeasurementModel, entegrationId);
  Future<GuvenResponseModel> getHba1cMeasurementList(
          GetHba1cMeasurementListModel getHba1cMeasurementListModel,
          var entegrationId) =>
      apiService.getHba1cMeasurementList(
          getHba1cMeasurementListModel, entegrationId);

  Future<GuvenResponseModel> insertNewScaleValue(
          AddScaleMasurementBody addScaleMasurementBody) =>
      apiService.insertNewScaleValue(addScaleMasurementBody);
  Future<GuvenResponseModel> deleteScaleMeasurement(
          DeleteScaleMasurementBody deleteScaleMasurementBody) =>
      apiService.deleteScaleMeasurement(deleteScaleMasurementBody);
  Future<GuvenResponseModel> getScaleDataOfPerson(
          GetScaleMasurementBody getScaleMasurementBody) =>
      apiService.getScaleMasurement(getScaleMasurementBody);
  Future<GuvenResponseModel> updateScaleMeasurement(
          UpdateScaleMasurementBody updateScaleMasurementBody) =>
      apiService.updateScaleMeasurement(updateScaleMasurementBody);
}
