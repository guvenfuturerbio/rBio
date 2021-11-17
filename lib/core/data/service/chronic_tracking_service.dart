part of '../imports/cronic_tracking.dart';

abstract class ChronicTrackingApiService {
  final IDioHelper helper;
  ChronicTrackingApiService(this.helper);

  Future<GuvenResponseModel> saveAndRetrieveToken(
      SaveAndRetrieveTokenModel saveAndRetrieveToken);
  Future<StripDetailModel> getUserStrip(entegrationId, deviceUUID);
  Future<GuvenResponseModel> insertNewBloodGlucoseValue(
      BloodGlucoseValue bodyPages);
  Future<GuvenResponseModel> deleteBloodGlucoseValue(
      DeleteBloodGlucoseMeasurementRequest
          deleteBloodGlucoseMeasurementRequest);
  Future<GuvenResponseModel> updateBloodGlucoseValue(
      UpdateBloodGlucoseMeasurementRequest
          updateBloodGlucoseMeasurementRequest);
  Future<GuvenResponseModel> uploadMeasurementImage(
      String file, int entegrationId, int measurementId);
  Future<GuvenResponseModel> getBloodGlucoseReport(
      BloodGlucoseReportBody bloodGlucoseReportBody);
  Future<GuvenResponseModel> getBloodGlucoseDataOfPerson(
      GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson);
  Future<List<Person>> getAllProfiles();
  Future<GuvenResponseModel> addProfile(Person person);
  Future<GuvenResponseModel> changeProfile(var userId);
  Future<GuvenResponseModel> deleteProfile(var userId);
  Future<GuvenResponseModel> addFirebaseToken(
      AddFirebaseToken addFirebaseToken);
  Future<GuvenResponseModel> updateProfile(Person person, var id);
  Future<GuvenResponseModel> setDefaultProfile(Person person);
  Future<GuvenResponseModel> updateUserStrip(StripDetailModel stripDetailModel);
  Future<GuvenResponseModel> deleteUserStrip(var id, var entegrationId);
  Future<GuvenResponseModel> isDeviceIdRegisteredForSomeUser(
      var deviceId, var entegrationId);
  Future<GuvenResponseModel> addHospitalHba1cMeasurement(
      HospitalHba1cMeasurementModel hospitalHba1cMeasurementModel,
      var entegrationId);
  Future<GuvenResponseModel> getHba1cMeasurementList(
      GetHba1cMeasurementListModel getHba1cMeasurementListModel,
      var entegrationId);
  Future<GuvenResponseModel> getMedicineByFilter(String text);
}
