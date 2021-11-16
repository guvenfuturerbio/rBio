import 'package:chopper/chopper.dart';
import 'package:intl/intl.dart';

import '../helper/build_configurations.dart';
import '../models/bg_measurement/blood_glucose_report_body.dart';
import '../models/bg_measurement/blood_glucose_value_model.dart';
import '../models/bg_measurement/delete_bg_measurement_request.dart';
import '../models/bg_measurement/get_blood_glucose_data_of_person.dart';
import '../models/bg_measurement/get_hba1c_measurement_list.dart';
import '../models/bg_measurement/hospital_hba1c_measurement.dart';
import '../models/bg_measurement/update_bg_measurement_request.dart';
import '../models/firebase/add_firebase_body.dart';
import '../models/notification/strip_detail_model.dart';
import '../models/user/additional_info_model.dart';
import '../models/user_profiles/person.dart';
import '../models/user_profiles/save_and_retrieve_token_model.dart';
import 'model_converter.dart';
import 'network_connection_service.dart';

part 'base_provider.chopper.dart';

@ChopperApi()
abstract class BaseProvider extends ChopperService {
  static BaseProvider create(String authToken) {
    final client = ChopperClient(
        baseUrl: BuildConfigurations.BASE_URL,
        services: [_$BaseProvider()],
        interceptors: [
          HeadersInterceptor(
              {'Authorization': authToken, 'Lang': Intl.getCurrentLocale()}),
          NetworkConnectionChecker(),
          HttpLoggingInterceptor(),
          (Response response) async {
            if (response.statusCode == 401) {
              chopperLogger.severe("Unauthorized");
            }
            return response;
          }
        ],
        converter: ModelConverter());
    return _$BaseProvider(client);
  }

  /// MODIFIERS AND CORRESPONDING FUNCTIONS
  /// Medicine
  @Get(path: "/Medicine/get-by-filter/{text}")
  Future<Response> getMedicineByFilter(@Path('text') String text);
  //Doctor list for chat
  @Post(path: "/Measurement/get-patient-doctors")
  Future<Response> getDoctorList(
    @Query('entegration_id') entegrationId,
  );

  /// Measurement
  @Post(path: "/Measurement/add-blood-glucose-with-detail")
  Future<Response> insertNewBloodGlucoseValue(
      @Body() BloodGlucoseValue bodyPages);

  @Post(path: "/Measurement/delete-blood-glucose-with-detail")
  Future<Response> deleteBloodGlucoseValue(
      @Body()
          DeleteBloodGlucoseMeasurementRequest
              deleteBloodGlucoseMeasurementRequest);

  @Post(path: "/Measurement/update-blood-glucose-with-detail")
  Future<Response> updateBloodGlucoseValue(
      @Body()
          UpdateBloodGlucoseMeasurementRequest
              updateBloodGlucoseMeasurementRequest);

  @Post(
      path:
          "/Measurement/upload-measurement-image/{entegration_id}/{measurement_id}",
      headers: {"Content-Type": "multipart/formdata"})
  @multipart
  Future<Response> uploadMeasurementImage(
      @PartFile('file') String file,
      @Path('entegration_id') entegrationId,
      @Path('measurement_id') measurementId);

  @Post(path: "/Measurement/add-hospital-hba1c-measurement/{entegration_id}")
  Future<Response> addHospitalHba1cMeasurement(
      @Body() HospitalHba1cMeasurementModel hospitalHba1cMeasurementModel,
      @Path('entegration_id') entegrationId);

  @Post(
      path: "/Measurement/get-list-hospital-hba1c-measurement/{entegration_id}")
  Future<Response> getHba1cMeasurementList(
      @Body() GetHba1cMeasurementListModel getHba1cMeasurementListModel,
      @Path('entegration_id') entegrationId);

  @Post(path: "/Measurement/get-my-blood-glucose-report")
  Future<Response> getBloodGlucoseReport(
      @Body() BloodGlucoseReportBody bloodGlucoseReportBody);

  @Post(path: "/Measurement/get-my-blood-glucose-with-detail-and-limit-value")
  Future<Response> getBloodGlucoseDataOfPerson(
      @Body() GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson);

  /// Department
  @Get(path: "/department/get-online-appointment-departments")
  Future<Response> getOnlineDoctorDepartments();

  /// Filter
  @Get(path: "/filter/get-online-doctor-by-department/{id}")
  Future<Response> getOnlineDoctorByDepartments(@Path('id') String id);

  @Get(path: "/MobileAppointment/get-close-by-doctor-and-date/{doctorId}")
  Future<Response> getClosestAppointment(@Path('doctorId') String id);

  /// Profile
  @Get(path: "/profile/get-all")
  Future<Response> getAllProfiles();

  @Post(path: "/profile/add")
  Future<Response> addProfile(@Body() Person person);

  @Post(path: "/profile/set-profile/{entegration_id}")
  Future<Response> changeProfile(@Path('entegration_id') userId);

  @Delete(path: "/profile/delete/{entegration_id}")
  Future<Response> deleteProfile(@Path('entegration_id') userId);

  /// User
  @Post(path: "/user/add-user-firebaseId")
  Future<Response> addFirebaseToken(@Body() AddFirebaseToken addFirebaseToken);

  @Patch(path: "/user/user-profile-update/{id}")
  Future<Response> updateProfile(@Body() Person person, @Path('id') id);

  @Post(path: "/user/set-user-profile-default-value")
  Future<Response> setDefaultProfile(@Body() Person person);

  @Get(path: "/user/has-identification-number/{entegrationId}")
  Future<Response> userHasIdentificationNumber(
      @Path('entegrationId') int entegrationId);

  @Post(path: "/user/add-identification-number/{entegrationId}")
  Future<Response> addAdditionalInformation(
      @Body() AdditionalInfoModel additionalInfoModel,
      @Path('entegrationId') int entegrationId);

  @Post(path: "/user/add-update-user-strip")
  Future<Response> updateUserStrip(@Body() StripDetailModel stripDetailModel);

  @Get(path: "/user/get-user-strip/{entegrationId}/{deviceuuid}")
  Future<Response> getUserStrip(
      @Path('entegrationId') entegrationId, @Path('deviceuuid') deviceUUID);

  @Delete(path: "/user/delete-user-strip/{id}/{entegrationId}")
  Future<Response> deleteUserStrip(
      @Path('id') id, @Path('entegrationId') entegrationId);

  /// UserRegister
  @Post(path: "/UserRegister/save-and-retrive-token")
  Future<Response> saveAndRetrieveToken(
      @Body() SaveAndRetrieveTokenModel saveAndRetrieveToken);

  /// SugarDevice
  @Get(
      path:
          "/SugarDevice/is-device-id-registered-for-some-user/{deviceId}/{entegrationId}")
  Future<Response> isDeviceIdRegisteredForSomeUser(
      @Path('deviceId') deviceId, @Path('entegrationId') entegrationId);

  /// Country
  @Get(path: "/country/get-all")
  Future<Response> fetchAllCountry();

  /// File
  @Post(
      path: "/file/profil-image-upload/{entegration_id}",
      headers: {"Content-Type": "multipart/formdata"})
  @multipart
  Future<Response> uploadProfilePicture(
      @PartFile('file') String file, @Path('entegration_id') entegrationId);

  @Get(path: "/file/retrieve-user-profile-image/{entegration_id}")
  Future<Response> getProfilePicture(@Path('entegration_id') entegrationId);

  @Delete(path: "/file/delete-profile-photo/{entegration_id}")
  Future<Response> deleteProfilePicture(@Path('entegration_id') entegrationId);

  @Get(
      path: "appointment/get-appointment-doctor-info/{dep_id}/{entegration_id}")
  Future<Response> getPatientAppointmentDoctor(
      @Path('dep_id') dep_id, @Path('entegration_id') entegration_id);

  @Get(path: "/file/get-patient-appointments-file-names/{entegration_id}/{id}")
  Future<Response> getAppointmentFiles(
      @Path('entegration_id') entegration_id, @Path('id') String roomId);

  @Delete(
      path: "/file/report-file-delete/{entegration_id}/{webAppoId}/{fileName}")
  Future<Response> deleteAppointmentFile(@Path('entegration_id') entegration_id,
      @Path('webAppoId') String webAppoId, @Path('fileName') String fileName);

  @Post(
      path:
          "/file/upload-patient-document-for-appoinment/{entegration_id}/{webAppoId}",
      headers: {"Content-Type": "multipart/formdata"})
  @multipart
  Future<Response> uploadFileToAppointment(
      @Path('entegration_id') entegration_id,
      @Path('webAppoId') String webAppoId,
      @PartFile('file') String file);

  @Get(path: "/file/report-file-download/{entegration_id}/{id}/{name}")
  Future<Response> downloadAppointmentFile(
      @Path('entegration_id') entegration_id,
      @Path('id') String id,
      @Path('name') String name);

  @Get(path: "/file/get-patient-all-appointments-file-names/{entegration_id}")
  Future<Response> getAllFiles(
    @Path('entegration_id') entegration_id,
  );

  @Get(
      path:
          "/file/download-patient-appointment-single-file/{entegration_id}/{folder}/{path}")
  Future<Response> downloadAppointmentSingleFile(
      @Path('entegration_id') entegration_id,
      @Path('folder') String folder,
      @Path('path') String path);
}
