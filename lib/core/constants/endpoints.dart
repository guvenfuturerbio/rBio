part of 'constants.dart';

class _Endpoints {
  final loginPath =
      '/auth/realms/GuvenComplex/protocol/openid-connect/token'.xSSOPath;

  final getAllPackagePath = '/Package/get-all'.xBasePath;
  String getAllSubCategoriesPath(id) =>
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
}

extension _EndpointsExtension on String {
  String get xBasePath => SecretUtils.instance.get(SecretKeys.BASE_URL) + this;
  String get xGuvenPath =>
      SecretUtils.instance.get(SecretKeys.DEV_4_GUVEN) + this;
  String get xSSOPath => SecretUtils.instance.get(SecretKeys.SSO_URL) + this;
}
