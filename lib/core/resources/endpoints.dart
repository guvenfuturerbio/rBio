part of 'resources.dart';

class _Endpoints {
  // #region devApiTest
  final loginPath = '/AccessToken/get-token-for-rbio'.xDevApiTest;
  final addStep1 = '/UserRegister/add-step1'.xDevApiTest;
  final addStep2 = '/UserRegister/add-step2'.xDevApiTest;
  final addStep3 = '/UserRegister/add-step3'.xDevApiTest;
  final getUserProfilePath = '/user/get-user-info'.xDevApiTest;
  String getBannerTab(String applicationName, String groupName) =>
      '/Banner/get-banner-tabs/$applicationName/$groupName'.xDevApiTest;
  final addFirebaseTokenUiPath = '/user/add-user-firebaseId'.xDevApiTest;
  final forgotPassword = '/UserRegister/forgot-password'.xDevApiTest;
  final changePassword =
      '/UserRegister/change-password-with-old-password'.xDevApiTest;
  // #endregion

  final getAllPackagePath = '/Package/get-all'.xBaseUrl;
  String getAllSubCategoriesPath(int id) =>
      '/Package/get-all-sub-categories/$id'.xBaseUrl;
  String getSubCategoryDetailPath(id) =>
      '/Package/get-all-sub-category-pages/$id'.xBaseUrl;
  String getSubCategoryItemsPath(id) =>
      '/Package/get-all-sub-category-items/$id'.xBaseUrl;
  final doPackagePaymentPath = '/Package/do-mobile-payment'.xBaseUrl;
  final sendNotification = '/User/send-message'.xBaseUrl;

  final findResourceAvailableDays =
      '/Pusula/findResourceAvailableDays'.xBaseUrl;
  final updateUserSystemNamePath =
      '/Authentication/update-user-system-name-pusula'.xBaseUrl;
  final getActiveStreamPath = '/profile/get-active-stream'.xBaseUrl;
  final getProfilePicturePath = '/file/retrieve-user-profile-image'.xBaseUrl;
  final getCurrentApplicationVersionPath =
      '/api/v1/ApplicationMobileCheckVersion/get-current'.xDoctorBaseUrl;
  final getPatientDetailPath = '/Pusula/getPatientByToken'.xBaseUrl;

  String getDoctorCvDetailsPath(String doctorWebID) =>
      '/api/doctor/$doctorWebID'.xGuvenPath;

  final filterTenantsPath = '/Pusula/filterTenants'.xBaseUrl;
  final filterDepartmentsPath = '/Pusula/FilterDepartments'.xBaseUrl;
  final filterResourcesPath = '/Pusula/filterResources'.xBaseUrl;
  final getEventsPath = '/Pusula/getevents'.xBaseUrl;
  final findResourceClosestAvailablePlanPath =
      '/Pusula/findResourceClosestAvailablePlan'.xBaseUrl;
  final saveAppointmentPath = '/Pusula/saveAppointment'.xBaseUrl;
  final syncronizeOneDoseUser =
      '/UserRegister/synchronize-onedose-user'.xBaseUrl;
  final getAllRelativesPath = '/profile/get-all-table'.xDevApiTest;
  final getCountriesPath = '/Pusula/getCountries'.xBaseUrl;
  final updatePusulaContactInfoPath = '/pusula/UpdatePatientContactInfo'.xBaseUrl;
  final updateContactInfoPath =
      '/User/UpdatePatientContactInfo'.xDevApiTest;

  String changeUserPasswordUiPath(String oldPassword, String password) =>
      '/user/mobile-change-user-password/$oldPassword/$password'.xBaseUrl;
  String getRoomStatusUiPath(String roomId) =>
      '/liveappointment/get-room-status/$roomId'.xBaseUrl;
  String getOnlineAppoFilesPath(String roomId) =>
      '/file/get-patient-appointments-file-names/$roomId'.xBaseUrl;
  String deleteOnlineAppoFilePath(String webAppoId, String fileName) =>
      '/file/report-file-delete/$webAppoId/$fileName'.xBaseUrl;
  final getAllTranslatorPath = '/appointmentinterpreter/get-all'.xBaseUrl;
  final getUserKvkkInfoPath = '/user/get-user-kvkk-info'.xBaseUrl;
  final updateUserKvkkInfoPath = '/user/update-user-kvkk-info'.xBaseUrl;
  final addSuggestionPath = '/SuggestionRate/Add-Suggestion'.xBaseUrl;
  final setYoutubeSurveyUserPath = '/course/save-user'.xBaseUrl;
  final getCourseIdPath = '/course/get-active'.xBaseUrl;
  String setJitsiWebConsultantIdPath(String webConsultantId) =>
      '/CerebrumOnlineAppointment/set-mobile-appointment-entrance-c4dd4e4ac7c34592827f0dbbfc233c56/$webConsultantId'
          .xBaseUrl;
  final deleteProfilePicturePath = '/file/delete-profile-photo'.xBaseUrl;
  final uploadProfilePicturePath = '/file/profil-image-upload'.xBaseUrl;
  final getChatContacts = '/User/get-chat-contacts'.xBaseUrl;
  String downloadAppointmentSingleFilePath(String folder, String path) =>
      '/file/download-patient-appointment-single-file/$folder/$path'.xBaseUrl;
  final getAllFilesPath =
      '/file/get-patient-all-appointments-file-names'.xBaseUrl;
  String downloadAppointmentFilePath(String id, String name) =>
      '/file/report-file-download/$id/$name'.xBaseUrl;
  String removePatientRelativePath(String id) => '/profile/remove/$id'.xBaseUrl;
  final getRelativeRelationshipsPath = '/user/get-relationships'.xBaseUrl;
  String changeActiveUserToRelativePath(String id) =>
      '/profile/set-profile/$id'.xBaseUrl;
  String clickPostPath(int postId) => '/socialpost/clickPost/$postId'.xBaseUrl;
  String filterSocialPostsPath(String search) =>
      '/socialpost/getPostWithTagsByText/$search'.xBaseUrl;
  String filterSocialPostsPlatform(String platform) =>
      '/socialPost/getPostWithTagsByPlatform/$platform'.xBaseUrl;

  final socialResourcePath = '/socialpost/getAllPosts'.xBaseUrl;
  final getAppointmentTypeViaWebConsultantIdPath =
      '/videoCall/get-stream-type-mobile'.xBaseUrl;
  String requestTranslatorPath(String appoId) =>
      '/appointmentinterpreter/add-update-appointment-interpreter-pusula/$appoId'
          .xBaseUrl;
  String uploadFileToAppoPath(String webAppoId) =>
      '/file/upload-patient-document-for-appoinment/$webAppoId'.xBaseUrl;

  final getVisitsPath = '/Pusula/getVisits'.xBaseUrl;
  final getLaboratoryResultsPath = '/Pusula/getLaboratoryResults'.xBaseUrl;
  final rateOnlineCallPath =
      '/SuggestionRate/Add-Availability-Rate-pusula'.xBaseUrl;
  final getRadiologyResultsPath = '/Pusula/getRadiologyResults'.xBaseUrl;
  final getPathologyResultsPath = '/Pusula/getPathologyResults'.xBaseUrl;
  final getLaboratoryPdfResultPath = '/Pusula/getLaboratoryResultsPdf'.xBaseUrl;
  final getRadiologyPdfResultPath = '/Pusula/getRadiologyResultsPdf'.xBaseUrl;
  final getPatientAppointmentsPath = '/Pusula/getPatientAppointments'.xBaseUrl;
  final cancelAppointmentPath = '/Pusula/cancelAppointment'.xBaseUrl;
  final getResourceVideoCallPricePath =
      '/Pusula/getResourceVideoCallPrice'.xBaseUrl;

  final getResourceVideoCallPriceWithVoucher =
      '/Pusula/getResourceVideoCallPriceWithVoucher'.xBaseUrl;
  final doMobilePaymentPath = '/Pusula/do-mobile-payment'.xBaseUrl;
  final doMobilePaymentWithVoucher =
      "/Pusula/do-mobile-payment-with-voucher".xBaseUrl;
  final fetchOnlineDepartmentsPath = '/Pusula/getOnlineDepartments'.xBaseUrl;
  final checkOnlineAppointmentPaymentPath =
      '/pusula/checkOnlineAppointmentPayment'.xBaseUrl;
  final getAvailabilityRatePath =
      '/SuggestionRate/Get-Availability-Rate-Pusula'.xBaseUrl;
  final addNewPatientRelativePath = '/profile/add-pusula'.xBaseUrl;
  String uploadPatientDocumentsPath(String webAppoId) =>
      '/file/upload-patient-document-for-appoinment/$webAppoId'.xBaseUrl;

  final symptomCheckerLogin = '/login'.xSymptomCheckerLogin;
  final symptomGetProposed = '/symptoms/proposed'.xSymptomCheckerRequest;
  final symptomGetSpecialisations =
      '/diagnosis/specialisations'.xSymptomCheckerRequest;
  final symptomGetBodyLocations = '/body/locations'.xSymptomCheckerRequest;
  String symptomGetBodySubLocations(int locationID) =>
      '/body/locations/$locationID'.xSymptomCheckerRequest;
  String symptomGetBodySymptoms(int locationID, int gender) =>
      '/symptoms/$locationID/$gender'.xSymptomCheckerRequest;

  String ctSaveAndRetrieveToken = '/AccessToken/validate-remote-token'.xBaseUrl;
  String ctGetUserStrip(int entegrationId, String deviceuuid) =>
      '/user/get-user-strip/$entegrationId/$deviceuuid'.xDevApiTest;
  String ctInsertNewBloodGlucoseValue =
      '/Measurement/add-blood-glucose-with-detail'.xDevApiTest;
  String ctDeleteBloodGlucoseValue =
      '/Measurement/delete-blood-glucose-with-detail'.xDevApiTest;
  String ctUpdateBloodGlucoseValue =
      '/Measurement/update-blood-glucose-with-detail'.xDevApiTest;
  String ctUploadMeasurementImage(var entegrationId, var measurementId) =>
      '/Measurement/upload-measurement-image/$entegrationId/$measurementId'
          .xDevApiTest;
  String ctGetBloodGlucoseReport =
      '/Measurement/get-my-blood-glucose-report'.xDevApiTest;
  String ctGetBloodGlucoseDataOfPerson =
      '/Measurement/get-my-blood-glucose-with-detail-and-limit-value'
          .xDevApiTest;
  String ctGetAllProfiles = '/profile/get-all'.xDevApiTest;
  String ctAddProfile = '/profile/add'.xDevApiTest;
  String ctChangeProfile(entegrationId) =>
      '/profile/set-profile/$entegrationId'.xDevApiTest;
  String ctDeleteProfile(var userId) => '/profile/delete/$userId'.xDevApiTest;
  String ctAddFirebaseToken = '/user/add-user-firebaseId'.xDevApiTest;
  String ctUpdateProfile(var id) => '/user/user-profile-update/$id'.xDevApiTest;
  String ctSetDefaultProfile =
      '/user/set-user-profile-default-value'.xDevApiTest;
  String ctUpdateUserStrip = '/user/add-update-user-strip'.xDevApiTest;
  String ctDeleteUserStrip(var id, var entegrationId) =>
      '/user/delete-user-strip/$id/$entegrationId'.xDevApiTest;
  String ctIsDeviceIdRegisteredForSomeUser(var deviceId, var entegrationId) =>
      '/SugarDevice/is-device-id-registered-for-some-user/$deviceId/$entegrationId'
          .xDevApiTest;
  String ctAddHospitalHba1cMeasurement(var entegrationId) =>
      '/Measurement/add-hospital-hba1c-measurement/$entegrationId'.xDevApiTest;
  String ctGetHba1cMeasurementList(var entegrationId) =>
      '/Measurement/get-list-hospital-hba1c-measurement/$entegrationId'
          .xDevApiTest;
  String ctGetMedicineByFilter(String text) =>
      '/Medicine/get-by-filter/$text'.xDevApiTest;

  String ctInsertNewBpValue = '/Measurement/add-bp-with-detail'.xDevApiTest;
  String ctDeleteBpMeasurement =
      '/Measurement/delete-bp-with-detail'.xDevApiTest;
  String ctGetBpMeasurement = '/Measurement/get-bp-measurements'.xDevApiTest;
  String ctUpdateBpMeasurement =
      '/Measurement/update-bp-measurement'.xDevApiTest;

  String dcLogin(String userName, String password) =>
      '/AccessToken/get-token-for-rbio?userName=$userName&password=$password'
          .xBaseUrl;
  String dcGetAllAppointment =
      '/mobileapi/v1/MobileDoctor/all-appointment'.xDoctorBaseUrl;
  String dcGetMySugarPatient =
      '/api/v1/DoctorPatient/get-my-sugar-patient'.xDoctorBaseUrl;
  String dcGetMyScalePatient =
      '/api/v1/DoctorPatient/get-my-bmi-patient'.xDoctorBaseUrl;
  String dcGetMyBpPatient =
      '/api/v1/DoctorPatient/get-my-bp-patient'.xDoctorBaseUrl;
  String dcGetMyBMIPatient =
      '/api/v1/DoctorPatient/get-my-bmi-patient'.xDoctorBaseUrl;
  String dcGetMyPatientDetail(int patientId) =>
      '/api/v1/doctorpatient/get-my-patient-profile-detail/$patientId'
          .xDoctorBaseUrl;
  String dcUpdateMyPatientLimit(int patientId) =>
      '/api/v1/doctorpatient/update-my-patient-limit-detail/$patientId'
          .xDoctorBaseUrl;
  String dcGetMyPatientBloodGlucose(int patientId) =>
      '/api/v1/doctorpatient/get-my-patient-blood-glucose-with-detail/$patientId'
          .xDoctorBaseUrl;
  String dcGetMyPatientScale(int patientId) =>
      '/api/v1/doctorpatient/get-my-patient-bmi/$patientId'.xDoctorBaseUrl;
  String dcGetMyPatientPressure(int patientId) =>
      '/api/v1/doctorpatient/get-my-patient-bp/$patientId'.xDoctorBaseUrl;
}

extension _EndpointsExtension on String {
  String get xBaseUrl {
    final String? path = getIt<KeyManager>().get(Keys.baseUrl);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('SecretKeys.baseUrl null');
    }
  }

  String get xGuvenPath {
    final String? path = getIt<KeyManager>().get(Keys.dev4Guven);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('SecretKeys.dev4Guven null');
    }
  }

  String get xSymptomCheckerLogin {
    final String? path = getIt<KeyManager>().get(Keys.symtonCheckerLogin);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('SecretKeys.symtonCheckerLogin null');
    }
  }

  String get xSymptomCheckerRequest {
    final String? path = getIt<KeyManager>().get(Keys.symtomRequestLogin);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('SecretKeys.symtomRequestLogin null');
    }
  }

  String get xDoctorBaseUrl {
    final String? path = getIt<KeyManager>().get(Keys.doctorBaseUrl);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('SecretKeys.doctorBaseUrl null');
    }
  }

  String get xDevApiTest {
    final String? path = getIt<KeyManager>().get(Keys.devApiTest);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('SecretKeys.devApiTest null');
    }
  }
}
