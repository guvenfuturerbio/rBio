part of 'resources.dart';

class _Endpoints {
  /*final loginPath =
      '/auth/realms/GuvenComplex/protocol/openid-connect/token'.xSSOPath;*/
  final loginPath = '/AccessToken/get-token-for-rbio'.xBasePath;

  final getAllPackagePath = '/Package/get-all'.xBasePath;
  String getAllSubCategoriesPath(int id) =>
      '/Package/get-all-sub-categories/$id'.xBasePath;
  String getSubCategoryDetailPath(id) =>
      '/Package/get-all-sub-category-pages/$id'.xBasePath;
  String getSubCategoryItemsPath(id) =>
      '/Package/get-all-sub-category-items/$id'.xBasePath;
  final doPackagePaymentPath = '/Package/do-mobile-payment'.xBasePath;
  final sendNotification = '/User/send-message'.xBasePath;
  final registerStep2UiPath = '/userregister/add-step2'.xBasePath;
  final registerStep2WithOutTcPath =
      '/userregister/add-step2-without-tckn'.xBasePath;
  final registerStep3UiPath = '/userregister/add-step3'.xBasePath;
  final registerStep3WithOutTcPath =
      '/userregister/add-step3-without-tckn'.xBasePath;
  final findResourceAvailableDays =
      '/Pusula/findResourceAvailableDays'.xBasePath;
  final updateUserSystemNamePath =
      '/Authentication/update-user-system-name-pusula'.xBasePath;
  final getUserProfilePath = '/user/get-user-info'.xBasePath;
  final getActiveStreamPath = '/profile/get-active-stream'.xBasePath;
  final getProfilePicturePath = '/file/retrieve-user-profile-image'.xBasePath;
  final getCurrentApplicationVersionPath =
      '/api/v1/ApplicationMobileCheckVersion/get-current'.xDoctorBaseUrl;
  final getPatientDetailPath = '/Pusula/getPatientByToken'.xBasePath;

  String getDoctorCvDetailsPath(String doctorWebID) =>
      '/api/doctor/$doctorWebID'.xGuvenPath;

  final filterTenantsPath = '/Pusula/filterTenants'.xBasePath;
  final filterDepartmentsPath = '/Pusula/FilterDepartments'.xBasePath;
  final filterResourcesPath = '/Pusula/filterResources'.xBasePath;
  final getEventsPath = '/Pusula/getevents'.xBasePath;
  final findResourceClosestAvailablePlanPath =
      '/Pusula/findResourceClosestAvailablePlan'.xBasePath;
  final saveAppointmentPath = '/Pusula/saveAppointment'.xBasePath;

  final getAllRelativesPath = '/profile/get-all-table'.xBasePath;
  final getCountriesPath = '/Pusula/getCountries'.xBasePath;
  final forgotPasswordUiPath = '/userregister/forgot-password'.xBasePath;
  final changePasswordUiPath =
      '/userregister/change-password-with-old-password'.xBasePath;
  final updateContactInfoPath = '/pusula/UpdatePatientContactInfo'.xBasePath;
  String changeUserPasswordUiPath(String oldPassword, String password) =>
      '/user/mobile-change-user-password/$oldPassword/$password'.xBasePath;
  final addFirebaseTokenUiPath = '/user/add-user-firebaseId'.xBasePath;
  final patientCallMeUiPath = '/patientcallrequest/call-me'.xBasePath;
  String getRoomStatusUiPath(String roomId) =>
      '/liveappointment/get-room-status/$roomId'.xBasePath;
  String getOnlineAppoFilesPath(String roomId) =>
      '/file/get-patient-appointments-file-names/$roomId'.xBasePath;
  String deleteOnlineAppoFilePath(String webAppoId, String fileName) =>
      '/file/report-file-delete/$webAppoId/$fileName'.xBasePath;
  final getAllTranslatorPath = '/appointmentinterpreter/get-all'.xBasePath;
  final getUserKvkkInfoPath = '/user/get-user-kvkk-info'.xBasePath;
  final updateUserKvkkInfoPath = '/user/update-user-kvkk-info'.xBasePath;
  final addSuggestionPath = '/SuggestionRate/Add-Suggestion'.xBasePath;
  final setYoutubeSurveyUserPath = '/course/save-user'.xBasePath;
  final getCourseIdPath = '/course/get-active'.xBasePath;
  String setJitsiWebConsultantIdPath(String webConsultantId) =>
      '/CerebrumOnlineAppointment/set-mobile-appointment-entrance-c4dd4e4ac7c34592827f0dbbfc233c56/$webConsultantId'
          .xBasePath;
  final deleteProfilePicturePath = '/file/delete-profile-photo'.xBasePath;
  final uploadProfilePicturePath = '/file/profil-image-upload'.xBasePath;
  final getChatContacts = '/User/get-chat-contacts'.xBasePath;
  String downloadAppointmentSingleFilePath(String folder, String path) =>
      '/file/download-patient-appointment-single-file/$folder/$path'.xBasePath;
  final getAllFilesPath =
      '/file/get-patient-all-appointments-file-names'.xBasePath;
  String downloadAppointmentFilePath(String id, String name) =>
      '/file/report-file-download/$id/$name'.xBasePath;
  String removePatientRelativePath(String id) =>
      '/profile/remove/$id'.xBasePath;
  final getRelativeRelationshipsPath = '/user/get-relationships'.xBasePath;
  String changeActiveUserToRelativePath(String id) =>
      '/profile/set-profile/$id'.xBasePath;
  String clickPostPath(int postId) => '/socialpost/clickPost/$postId'.xBasePath;
  String filterSocialPostsPath(String search) =>
      '/socialpost/getPostWithTagsByText/$search'.xBasePath;
  String filterSocialPostsPlatform(String platform) =>
      '/socialPost/getPostWithTagsByPlatform/$platform'.xBasePath;

  String getBannerTab(String applicationName, String groupName) =>
      '/Banner/get-banner-tabs/$applicationName/$groupName'.xBasePath;
  final socialResourcePath = '/socialpost/getAllPosts'.xBasePath;
  final getAppointmentTypeViaWebConsultantIdPath =
      '/videoCall/get-stream-type-mobile'.xBasePath;
  String requestTranslatorPath(String appoId) =>
      '/appointmentinterpreter/add-update-appointment-interpreter-pusula/$appoId'
          .xBasePath;
  String uploadFileToAppoPath(String webAppoId) =>
      '/file/upload-patient-document-for-appoinment/$webAppoId'.xBasePath;

  final registerStep1UiPath = '/userregister/add-step1-pusula'.xBasePath;
  final registerStep1WithOutTcPath =
      '/userregister/add-step1-without-tckn'.xBasePath;
  final getVisitsPath = '/Pusula/getVisits'.xBasePath;
  final getLaboratoryResultsPath = '/Pusula/getLaboratoryResults'.xBasePath;
  final rateOnlineCallPath =
      '/SuggestionRate/Add-Availability-Rate-pusula'.xBasePath;
  final getRadiologyResultsPath = '/Pusula/getRadiologyResults'.xBasePath;
  final getPathologyResultsPath = '/Pusula/getPathologyResults'.xBasePath;
  final getLaboratoryPdfResultPath =
      '/Pusula/getLaboratoryResultsPdf'.xBasePath;
  final getRadiologyPdfResultPath = '/Pusula/getRadiologyResultsPdf'.xBasePath;
  final getPatientAppointmentsPath = '/Pusula/getPatientAppointments'.xBasePath;
  final cancelAppointmentPath = '/Pusula/cancelAppointment'.xBasePath;
  final getResourceVideoCallPricePath =
      '/Pusula/getResourceVideoCallPrice'.xBasePath;

  final getResourceVideoCallPriceWithVoucher =
      '/Pusula/getResourceVideoCallPriceWithVoucher'.xBasePath;
  final doMobilePaymentPath = '/Pusula/do-mobile-payment'.xBasePath;
  final doMobilePaymentWithVoucher =
      "/Pusula/do-mobile-payment-with-voucher".xBasePath;
  final fetchOnlineDepartmentsPath = '/Pusula/getOnlineDepartments'.xBasePath;
  final checkOnlineAppointmentPaymentPath =
      '/pusula/checkOnlineAppointmentPayment'.xBasePath;
  final getAvailabilityRatePath =
      '/SuggestionRate/Get-Availability-Rate-Pusula'.xBasePath;
  final addNewPatientRelativePath = '/profile/add-pusula'.xBasePath;
  String uploadPatientDocumentsPath(String webAppoId) =>
      '/file/upload-patient-document-for-appoinment/$webAppoId'.xBasePath;

  final symptomCheckerLogin = '/login'.xSymptomCheckerLogin;
  final symptomGetProposed = '/symptoms/proposed'.xSymptomCheckerRequest;
  final symptomGetSpecialisations =
      '/diagnosis/specialisations'.xSymptomCheckerRequest;
  final symptomGetBodyLocations = '/body/locations'.xSymptomCheckerRequest;
  String symptomGetBodySubLocations(int locationID) =>
      '/body/locations/$locationID'.xSymptomCheckerRequest;
  String symptomGetBodySymptoms(int locationID, int gender) =>
      '/symptoms/$locationID/$gender'.xSymptomCheckerRequest;

  String ctSaveAndRetrieveToken =
      '/AccessToken/validate-remote-token'.xBasePath;
  String ctGetUserStrip(int entegrationId, String deviceuuid) =>
      '/user/get-user-strip/$entegrationId/$deviceuuid'.xCronicTracking;
  String ctInsertNewBloodGlucoseValue =
      '/Measurement/add-blood-glucose-with-detail'.xCronicTracking;
  String ctDeleteBloodGlucoseValue =
      '/Measurement/delete-blood-glucose-with-detail'.xCronicTracking;
  String ctUpdateBloodGlucoseValue =
      '/Measurement/update-blood-glucose-with-detail'.xCronicTracking;
  String ctUploadMeasurementImage(var entegrationId, var measurementId) =>
      '/Measurement/upload-measurement-image/$entegrationId/$measurementId'
          .xCronicTracking;
  String ctGetBloodGlucoseReport =
      '/Measurement/get-my-blood-glucose-report'.xCronicTracking;
  String ctGetBloodGlucoseDataOfPerson =
      '/Measurement/get-my-blood-glucose-with-detail-and-limit-value'
          .xCronicTracking;
  String ctGetAllProfiles = '/profile/get-all'.xCronicTracking;
  String ctAddProfile = '/profile/add'.xCronicTracking;
  String ctChangeProfile(entegrationId) =>
      '/profile/set-profile/$entegrationId'.xCronicTracking;
  String ctDeleteProfile(var userId) =>
      '/profile/delete/$userId'.xCronicTracking;
  String ctAddFirebaseToken = '/user/add-user-firebaseId'.xCronicTracking;
  String ctUpdateProfile(var id) =>
      '/user/user-profile-update/$id'.xCronicTracking;
  String ctSetDefaultProfile =
      '/user/set-user-profile-default-value'.xCronicTracking;
  String ctUpdateUserStrip = '/user/add-update-user-strip'.xCronicTracking;
  String ctDeleteUserStrip(var id, var entegrationId) =>
      '/user/delete-user-strip/$id/$entegrationId'.xCronicTracking;
  String ctIsDeviceIdRegisteredForSomeUser(var deviceId, var entegrationId) =>
      '/SugarDevice/is-device-id-registered-for-some-user/$deviceId/$entegrationId'
          .xCronicTracking;
  String ctAddHospitalHba1cMeasurement(var entegrationId) =>
      '/Measurement/add-hospital-hba1c-measurement/$entegrationId'
          .xCronicTracking;
  String ctGetHba1cMeasurementList(var entegrationId) =>
      '/Measurement/get-list-hospital-hba1c-measurement/$entegrationId'
          .xCronicTracking;
  String ctGetMedicineByFilter(String text) =>
      '/Medicine/get-by-filter/$text'.xCronicTracking;

  String ctInsertNewBpValue = '/Measurement/add-bp-with-detail'.xCronicTracking;
  String ctDeleteBpMeasurement =
      '/Measurement/delete-bp-with-detail'.xCronicTracking;
  String ctGetBpMeasurement =
      '/Measurement/get-bp-measurements'.xCronicTracking;
  String ctUpdateBpMeasurement =
      '/Measurement/update-bp-measurement'.xCronicTracking;

  String dcLogin(String userName, String password) =>
      '/AccessToken/get-token-for-rbio?userName=$userName&password=$password'
          .xBasePath;
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
  String get xBasePath {
    final String? path = getIt<KeyManager>().get(Keys.baseUrl);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xBasePath null');
    }
  }

  String get xGuvenPath {
    final String? path = getIt<KeyManager>().get(Keys.dev4Guven);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xGuvenPath null');
    }
  }

  String get xSymptomCheckerLogin {
    final String? path = getIt<KeyManager>().get(Keys.symtonCheckerLogin);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xSymptomCheckerLogin null');
    }
  }

  String get xSymptomCheckerRequest {
    final String? path = getIt<KeyManager>().get(Keys.symtomRequestLogin);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xSymptomCheckerRequest null');
    }
  }

  String get xCronicTracking {
    final String? path = getIt<KeyManager>().get(Keys.chronicTrackingBaseUrl);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xCronicTracking null');
    }
  }

  String get xDoctorBaseUrl {
    final String? path = getIt<KeyManager>().get(Keys.doctorBaseUrl);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('xDoctorBaseUrl null');
    }
  }
}
