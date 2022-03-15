import '../../../features/mediminder/mediminder.dart';
import '../../../model/bg_measurement/blood_glucose_report_body.dart';
import '../../../model/bg_measurement/blood_glucose_value_model.dart';
import '../../../model/bg_measurement/delete_bg_measurement_request.dart';
import '../../../model/bg_measurement/get_blood_glucose_data_of_person.dart';
import '../../../model/bg_measurement/get_hba1c_measurement_list.dart';
import '../../../model/bg_measurement/hospital_hba1c_measurement.dart';
import '../../../model/bg_measurement/update_bg_measurement_request.dart';
import '../../../model/firebase/add_firebase_body.dart';
import '../../../model/model.dart';
import '../../../model/user_profiles/save_and_retrieve_token_model.dart';
import '../../core.dart';

class ChronicTrackingRepository {
  final ChronicTrackingApiService apiService;
  final LocalCacheService localCacheService;

  ChronicTrackingRepository({
    required this.apiService,
    required this.localCacheService,
  });

  Future<GuvenResponseModel> saveAndRetrieveToken(
    SaveAndRetrieveTokenModel saveAndRetrieveToken,
    String token,
  ) =>
      apiService.saveAndRetrieveToken(saveAndRetrieveToken, token);
  Future<StripDetailModel> getUserStrip(
          int entegrationId, String? deviceUUID) =>
      apiService.getUserStrip(entegrationId, deviceUUID);
  Future<GuvenResponseModel> insertNewBloodGlucoseValue(
    BloodGlucoseValue bodyPages,
  ) =>
      apiService.insertNewBloodGlucoseValue(bodyPages);
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
  Future<GuvenResponseModel> getBloodGlucoseReport(
    BloodGlucoseReportBody bloodGlucoseReportBody,
  ) =>
      apiService.getBloodGlucoseReport(bloodGlucoseReportBody);
  Future<GuvenResponseModel> getBloodGlucoseDataOfPerson(
    GetBloodGlucoseDataOfPerson data,
  ) =>
      apiService.getBloodGlucoseDataOfPerson(data);
  Future<List<Person>> getAllProfiles() => apiService.getAllProfiles();
  Future<GuvenResponseModel> addProfile(Person person) =>
      apiService.addProfile(person);
  Future<GuvenResponseModel> changeProfile(int userId) =>
      apiService.changeProfile(userId);
  Future<GuvenResponseModel> deleteProfile(int userId) =>
      apiService.deleteProfile(userId);
  Future<GuvenResponseModel> addFirebaseToken(
    AddFirebaseToken addFirebaseToken,
  ) =>
      apiService.addFirebaseToken(addFirebaseToken);
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
  Future<GuvenResponseModel> addHospitalHba1cMeasurement(
    HospitalHba1cMeasurementModel hospitalHba1cMeasurementModel,
    int entegrationId,
  ) =>
      apiService.addHospitalHba1cMeasurement(
        hospitalHba1cMeasurementModel,
        entegrationId,
      );
  Future<GuvenResponseModel> getHba1cMeasurementList(
    GetHba1cMeasurementListModel getHba1cMeasurementListModel,
    int entegrationId,
  ) =>
      apiService.getHba1cMeasurementList(
        getHba1cMeasurementListModel,
        entegrationId,
      );

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
}
