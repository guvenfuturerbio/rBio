part of 'constants.dart';

class _Endpoints {
  final loginPath =
      '/auth/realms/GuvenComplex/protocol/openid-connect/token'.xSSOPath;

  final getAllPackagePath = '/Package/get-all'.xBasePath;
  String getAllSubCategoriesPath(int id) =>
      '/Package/get-all-sub-categories/$id'.xBasePath;
  String getSubCategoryDetailPath(id) =>
      '/Package/get-all-sub-category-pages/$id'.xBasePath;
  String getSubCategoryItemsPath(id) =>
      '/Package/get-all-sub-category-items/$id'.xBasePath;
  final doPackagePaymentPath = '/Package/do-mobile-payment'.xBasePath;

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
      '/applicationmobilecheckversion/get-current'.xBasePath;
  final getPatientDetailPath = '/Pusula/getPatientByToken'.xBasePath;

  String getDoctorCvDetailsPath(String doctorWebID) =>
      '/api/doctor/${doctorWebID}'.xGuvenPath;

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
  final socialResourcePath = '/socialpost/getAllPosts'.xBasePath;
  final getAppointmentTypeViaWebConsultantIdPath =
      '/videoCall/get-stream-type-mobile'.xBasePath;
  String requestTranslatorPath(String appoId) =>
      '/appointmentinterpreter/add-update-appointment-interpreter/$appoId'
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
  final doMobilePaymentPath = '/Pusula/do-mobile-payment'.xBasePath;
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
      '/body/locations/${locationID}'.xSymptomCheckerRequest;
  String symptomGetBodySymptoms(int locationID, int gender) =>
      '/symptoms/${locationID}/${gender}'.xSymptomCheckerRequest;

  String ct_saveAndRetrieveToken =
      '/UserRegister/save-and-retrive-token'.xCronicTracking;
  String ct_getUserStrip(var entegrationId, var deviceuuid) =>
      '/user/get-user-strip/${entegrationId}/${deviceuuid}'.xCronicTracking;
  String ct_insertNewBloodGlucoseValue =
      '/Measurement/add-blood-glucose-with-detail'.xCronicTracking;
  String ct_deleteBloodGlucoseValue =
      '/Measurement/delete-blood-glucose-with-detail'.xCronicTracking;
  String ct_updateBloodGlucoseValue =
      '/Measurement/update-blood-glucose-with-detail'.xCronicTracking;
  String ct_uploadMeasurementImage(var entegrationId, var measurementId) =>
      '/Measurement/upload-measurement-image/${entegrationId}/${measurementId}'
          .xCronicTracking;
  String ct_getBloodGlucoseReport =
      '/Measurement/get-my-blood-glucose-report'.xCronicTracking;
  String ct_getBloodGlucoseDataOfPerson =
      '/Measurement/get-my-blood-glucose-with-detail-and-limit-value'
          .xCronicTracking;
  String ct_getAllProfiles = '/profile/get-all'.xCronicTracking;
  String ct_addProfile = '/profile/add'.xCronicTracking;
  String ct_changeProfile(entegration_id) =>
      '/profile/set-profile/${entegration_id}'.xCronicTracking;
  String ct_deleteProfile(var userId) =>
      '/profile/delete/$userId'.xCronicTracking;
  String ct_addFirebaseToken = '/user/add-user-firebaseId'.xCronicTracking;
  String ct_updateProfile(var id) =>
      '/user/user-profile-update/${id}'.xCronicTracking;
  String ct_setDefaultProfile =
      '/user/set-user-profile-default-value'.xCronicTracking;
  String ct_updateUserStrip = '/user/add-update-user-strip'.xCronicTracking;
  String ct_deleteUserStrip(var id, var entegrationId) =>
      '/user/delete-user-strip/${id}/${entegrationId}'.xCronicTracking;
  String ct_isDeviceIdRegisteredForSomeUser(var deviceId, var entegrationId) =>
      '/SugarDevice/is-device-id-registered-for-some-user/${deviceId}/${entegrationId}'
          .xCronicTracking;
  String ct_addHospitalHba1cMeasurement(var entegrationId) =>
      '/Measurement/add-hospital-hba1c-measurement/${entegrationId}'
          .xCronicTracking;
  String ct_getHba1cMeasurementList(var entegrationId) =>
      '/Measurement/get-list-hospital-hba1c-measurement/${entegrationId}'
          .xCronicTracking;
  String ct_getMedicineByFilter(String text) =>
      '/Medicine/get-by-filter/${text}'.xCronicTracking;
  String ct_login = '/auth/realms/GuvenComplex/protocol/openid-connect/token'
      .xCronicTrackingSSO;
}

extension _EndpointsExtension on String {
  String get xBasePath => SecretUtils.instance.get(SecretKeys.BASE_URL) + this;
  String get xGuvenPath =>
      SecretUtils.instance.get(SecretKeys.DEV_4_GUVEN) + this;
  String get xSSOPath => SecretUtils.instance.get(SecretKeys.SSO_URL) + this;
  String get xSymptomCheckerLogin =>
      SecretUtils.instance.get(SecretKeys.SYMPTOM_CHECKER_LOGIN) + this;
  String get xSymptomCheckerRequest =>
      SecretUtils.instance.get(SecretKeys.SYMPTOM_REQUEST_URL) + this;
  String get xCronicTracking =>
      SecretUtils.instance.get(SecretKeys.CHRONIC_TRACKING_BASE_URL) + this;
  String get xCronicTrackingSSO =>
      SecretUtils.instance.get(SecretKeys.CHRONIC_SSO_URL) + this;
}
