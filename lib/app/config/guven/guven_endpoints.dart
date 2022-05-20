part of '../abstract/app_config.dart';

class GuvenEndpoints extends IAppEndpoints {
  @override
  String get envPath => 'env/guven/.prod.env';

  @override
  BaseEndpoints get base => GuvenBaseEndpoints();

  @override
  DoctorEndpoints get doctor => GuvenDoctorEndpoints();

  @override
  DevApiEndpoints get devApi => GuvenDevApiEndpoints();

  @override
  CommonEndpoints get common => GuvenCommonEndpoints();

  @override
  SymptomCheckerEndpoints get symptom => GuvenSymptomCheckerEndpoints();

  @override
  SearchEndpoints get search => GuvenSearchEndpoints();

  @override
  RelativeEndpoints get relative => GuvenRelativeEndpoints();
}

class GuvenRelativeEndpoints extends RelativeEndpoints {
  @override
  String get getAllRelativesPath => '/profile/get-all-table'.xBaseUrl;

  @override
  String removePatientRelativePath(String id) => '/profile/remove/$id'.xBaseUrl;

  @override
  String changeActiveUserToRelativePath(String id) =>
      '/profile/set-profile/$id'.xBaseUrl;

  @override
  String get addNewPatientRelativePath => '/profile/add-pusula'.xBaseUrl;

  @override
  String get getRelativeRelationshipsPath => '/user/get-relationships'.xBaseUrl;
}

class GuvenSymptomCheckerEndpoints extends SymptomCheckerEndpoints {
  @override
  String get symptomGetBodyLocations =>
      throw RbioUndefinedEndpointException("symptomGetBodyLocations");

  @override
  String symptomGetBodySubLocations(int locationID) => 'env/onedose/.prod.env';

  @override
  String symptomGetBodySymptoms(int locationID, int gender) =>
      throw RbioUndefinedEndpointException("symptomGetBodySymptoms");

  @override
  String get symptomGetProposed =>
      throw RbioUndefinedEndpointException("symptomGetProposed");

  @override
  String get symptomGetSpecialisations =>
      throw RbioUndefinedEndpointException("symptomGetSpecialisations");

  @override
  String get symptomCheckerLogin =>
      throw RbioUndefinedEndpointException("symptomCheckerLogin");
}

class GuvenCommonEndpoints extends CommonEndpoints {
  @override
  String getDoctorCvDetailsPath(String doctorWebID) =>
      '/api/doctor/$doctorWebID'.xGuvenPath;

  @override
  String consentFormPath(String locale) =>
      "/UserRegister/get-consent-form/$locale".xBaseUrl;
}

class GuvenSearchEndpoints extends SearchEndpoints {
  @override
  String getPostWithTagsByText(String search) =>
      '/SocialPost/getPostWithTagsByText/$search'.xBaseUrl;

  @override
  String getPostWithTagsByPlatform(String platform) =>
      throw RbioUndefinedEndpointException("getPostWithTagsByPlatform");

  @override
  String get getAllPosts => '/SocialPost/getAllPosts'.xBaseUrl;
}

class GuvenDevApiEndpoints extends DevApiEndpoints {
  @override
  String get addFirebaseTokenUiPath => '/user/add-user-firebaseId'.xBaseUrl;

  @override
  String get addStep1 => '/userregister/add-step1-pusula'.xBaseUrl;

  @override
  String get addStep2 => "/userregister/add-step2".xBaseUrl;

  @override
  String get addStep3 => '/userregister/add-step3'.xBaseUrl;

  @override
  String get changePassword =>
      '/userregister/change-password-with-old-password'.xBaseUrl;

  @override
  String get ctAddFirebaseToken =>
      throw RbioUndefinedEndpointException("ctAddFirebaseToken");

  @override
  String ctAddHospitalHba1cMeasurement(entegrationId) =>
      throw RbioUndefinedEndpointException("ctAddHospitalHba1cMeasurement");

  @override
  String get ctAddProfile =>
      throw RbioUndefinedEndpointException("ctAddProfile");

  @override
  String ctChangeProfile(entegrationId) =>
      throw RbioUndefinedEndpointException("ctChangeProfile");

  @override
  String get ctDeleteBloodGlucoseValue =>
      throw RbioUndefinedEndpointException("ctDeleteBloodGlucoseValue");

  @override
  String get ctDeleteBpMeasurement =>
      throw RbioUndefinedEndpointException("ctDeleteBpMeasurement");

  @override
  String ctDeleteProfile(userId) =>
      throw RbioUndefinedEndpointException("ctDeleteProfile");

  @override
  String ctDeleteUserStrip(int id, entegrationId) =>
      throw RbioUndefinedEndpointException("ctDeleteUserStrip");

  @override
  String get ctGetAllProfiles =>
      throw RbioUndefinedEndpointException("ctGetAllProfiles");

  @override
  String get ctGetBloodGlucoseDataOfPerson =>
      throw RbioUndefinedEndpointException("ctGetBloodGlucoseDataOfPerson");

  @override
  String get ctGetBloodGlucoseReport =>
      throw RbioUndefinedEndpointException("ctGetBloodGlucoseReport");

  @override
  String get ctGetBpMeasurement =>
      throw RbioUndefinedEndpointException("ctGetBpMeasurement");

  @override
  String ctGetHba1cMeasurementList(entegrationId) =>
      throw RbioUndefinedEndpointException("ctGetHba1cMeasurementList");

  @override
  String ctGetMedicineByFilter(String text) =>
      throw RbioUndefinedEndpointException("ctGetMedicineByFilter");

  @override
  String ctGetUserStrip(int entegrationId, String deviceuuid) =>
      throw RbioUndefinedEndpointException("ctGetUserStrip");

  @override
  String get ctInsertNewBloodGlucoseValue =>
      throw RbioUndefinedEndpointException("ctInsertNewBloodGlucoseValue");

  @override
  String get ctInsertNewBpValue =>
      throw RbioUndefinedEndpointException("ctInsertNewBpValue");

  @override
  String ctIsDeviceIdRegisteredForSomeUser(deviceId, entegrationId) =>
      throw RbioUndefinedEndpointException("ctIsDeviceIdRegisteredForSomeUser");

  @override
  String get ctSetDefaultProfile =>
      throw RbioUndefinedEndpointException("ctSetDefaultProfile");

  @override
  String get ctUpdateBloodGlucoseValue =>
      throw RbioUndefinedEndpointException("ctUpdateBloodGlucoseValue");

  @override
  String get ctUpdateBpMeasurement =>
      throw RbioUndefinedEndpointException("ctUpdateBpMeasurement");

  @override
  String ctUpdateProfile(id) =>
      throw RbioUndefinedEndpointException("ctUpdateProfile");

  @override
  String ctUploadMeasurementImage(entegrationId, measurementId) =>
      throw RbioUndefinedEndpointException("ctUploadMeasurementImage");

  @override
  String get forgotPassword => '/userregister/forgot-password'.xBaseUrl;

  @override
  String getBannerTab(String applicationName, String groupName) =>
      throw RbioUndefinedEndpointException("getBannerTab");

  @override
  String get getUserProfilePath => '/user/get-user-info'.xBaseUrl;

  @override
  String get loginPath => "/AccessToken/get-token-for-guven-online".xBaseUrl;

  @override
  String get sendNotification =>
      throw RbioUndefinedEndpointException("sendNotification");

  @override
  String get updateContactInfoPath =>
      '/pusula/UpdatePatientContactInfo'.xBaseUrl;

  @override
  String get getChatContacts =>
      throw RbioUndefinedEndpointException("getChatContacts");

  @override
  String get ctUpdateUserStrip =>
      throw RbioUndefinedEndpointException("ctUpdateUserStrip");
}

class GuvenBaseEndpoints extends BaseEndpoints {
  @override
  String get userLoginStarter => '/AccessToken/user-login-starter'.xBaseUrl;

  @override
  String get verifyConfirmation2fa =>
      '/AccessToken/verify-confirmation-2fa'.xBaseUrl;

  @override
  String get getAllPackagePath => '/Package/get-all'.xBaseUrl;

  @override
  String getAllSubCategoriesPath(int id) =>
      '/Package/get-all-sub-categories/$id'.xBaseUrl;

  @override
  String getSubCategoryDetailPath(id) =>
      '/Package/get-all-sub-category-pages/$id'.xBaseUrl;

  @override
  String getSubCategoryItemsPath(id) =>
      '/Package/get-all-sub-category-items/$id'.xBaseUrl;

  @override
  String get doPackagePaymentPath =>
      '/Package/do-mobile-payment-without-firebase'.xBaseUrl;

  @override
  String get findResourceAvailableDays =>
      '/Pusula/findResourceAvailableDays'.xBaseUrl;

  @override
  String get updateUserSystemNamePath =>
      '/Authentication/update-user-system-name-pusula'.xBaseUrl;

  @override
  String get getActiveStreamPath => '/profile/get-active-stream'.xBaseUrl;

  @override
  String get getProfilePicturePath =>
      '/file/retrieve-user-profile-image'.xBaseUrl;

  @override
  String get getPatientDetailPath => '/Pusula/getPatientByToken'.xBaseUrl;

  @override
  String get filterTenantsPath => '/Pusula/filterTenants'.xBaseUrl;

  @override
  String get filterDepartmentsPath => '/Pusula/FilterDepartments'.xBaseUrl;

  @override
  String get filterResourcesPath => '/Pusula/filterResources'.xBaseUrl;

  @override
  String get addSuggestionPath => '/SuggestionRate/Add-Suggestion'.xBaseUrl;

  @override
  String changeUserPasswordUiPath(String oldPassword, String password) =>
      '/user/mobile-change-user-password/$oldPassword/$password'.xBaseUrl;

  @override
  String clickPostPath(int postId) => '/SocialPost/clickPost/$postId'.xBaseUrl;

  @override
  String deleteOnlineAppoFilePath(String webAppoId, String fileName) =>
      '/file/report-file-delete/$webAppoId/$fileName'.xBaseUrl;

  @override
  String get deleteProfilePicturePath => '/file/delete-profile-photo'.xBaseUrl;

  @override
  String downloadAppointmentFilePath(String id, String name) =>
      '/file/report-file-download/$id/$name'.xBaseUrl;

  @override
  String downloadAppointmentSingleFilePath(String folder, String path) =>
      '/file/download-patient-appointment-single-file/$folder/$path'.xBaseUrl;

  @override
  String get findResourceClosestAvailablePlanPath =>
      '/Pusula/findResourceClosestAvailablePlan'.xBaseUrl;

  @override
  String get getAllFilesPath =>
      '/file/get-patient-all-appointments-file-names'.xBaseUrl;

  @override
  String get getAllTranslatorPath => '/appointmentinterpreter/get-all'.xBaseUrl;

  @override
  String get getAppointmentTypeViaWebConsultantIdPath =>
      '/videoCall/get-stream-type-mobile'.xBaseUrl;

  @override
  String get getCountriesPath => '/Pusula/getCountries'.xBaseUrl;

  @override
  String get getCourseIdPath => '/course/get-active'.xBaseUrl;

  @override
  String get getEventsPath => '/Pusula/getevents'.xBaseUrl;

  @override
  String get getLaboratoryResultsPath =>
      '/Pusula/getLaboratoryResults'.xBaseUrl;

  @override
  String getOnlineAppoFilesPath(String roomId) =>
      '/file/get-patient-appointments-file-names/$roomId'.xBaseUrl;

  @override
  String getRoomStatusUiPath(String roomId) =>
      '/liveappointment/get-room-status/$roomId'.xBaseUrl;

  @override
  String get getUserKvkkInfoPath => '/user/get-user-kvkk-info'.xBaseUrl;

  @override
  String get getVisitsPath => '/Pusula/getVisits'.xBaseUrl;

  @override
  String requestTranslatorPath(String appoId) =>
      '/appointmentinterpreter/add-update-appointment-interpreter-pusula/$appoId'
          .xBaseUrl;

  @override
  String get saveAppointmentPath => '/Pusula/saveAppointment'.xBaseUrl;

  @override
  String setJitsiWebConsultantIdPath(String webConsultantId) =>
      '/CerebrumOnlineAppointment/set-mobile-appointment-entrance-c4dd4e4ac7c34592827f0dbbfc233c56/$webConsultantId'
          .xBaseUrl;

  @override
  String get setYoutubeSurveyUserPath => '/course/save-user'.xBaseUrl;

  @override
  String get syncronizeOneDoseUser =>
      throw RbioUndefinedEndpointException("syncronizeOneDoseUser");

  @override
  String get updatePusulaContactInfoPath =>
      throw RbioUndefinedEndpointException("updatePusulaContactInfoPath");

  @override
  String get updateUserKvkkInfoPath => '/user/update-user-kvkk-info'.xBaseUrl;

  @override
  String uploadFileToAppoPath(String webAppoId) =>
      '/file/upload-patient-document-for-appoinment/$webAppoId'.xBaseUrl;

  @override
  String get uploadProfilePicturePath => '/file/profil-image-upload'.xBaseUrl;

  @override
  String get cancelAppointmentPath => '/Pusula/cancelAppointment'.xBaseUrl;

  @override
  String get checkOnlineAppointmentPaymentPath =>
      '/pusula/checkOnlineAppointmentPayment'.xBaseUrl;

  @override
  String get ctSaveAndRetrieveToken =>
      throw RbioUndefinedEndpointException("ctSaveAndRetrieveToken");

  @override
  String get doMobilePaymentPath =>
      '/Pusula/do-mobile-payment-without-firebase'.xBaseUrl;

  @override
  String get doMobilePaymentWithVoucher =>
      '/Pusula/do-mobile-payment-with-voucher'.xBaseUrl;

  @override
  String get fetchOnlineDepartmentsPath =>
      '/Pusula/getOnlineDepartments'.xBaseUrl;

  @override
  String get getAvailabilityRatePath =>
      '/SuggestionRate/Get-Availability-Rate-Pusula'.xBaseUrl;

  @override
  String get getLaboratoryPdfResultPath =>
      '/Pusula/getLaboratoryResultsPdf'.xBaseUrl;

  @override
  String get getPathologyResultsPath => '/Pusula/getPathologyResults'.xBaseUrl;

  @override
  String get getPatientAppointmentsPath =>
      '/Pusula/getPatientAppointments'.xBaseUrl;

  @override
  String get getRadiologyPdfResultPath =>
      '/Pusula/getRadiologyResultsPdf'.xBaseUrl;

  @override
  String get getRadiologyResultsPath => '/Pusula/getRadiologyResults'.xBaseUrl;

  @override
  String get getResourceVideoCallPricePath =>
      '/Pusula/getResourceVideoCallPrice'.xBaseUrl;

  @override
  String get getResourceVideoCallPriceWithVoucher =>
      '/Pusula/getResourceVideoCallPriceWithVoucher'.xBaseUrl;

  @override
  String get rateOnlineCallPath =>
      '/SuggestionRate/Add-Availability-Rate-pusula'.xBaseUrl;

  @override
  String uploadPatientDocumentsPath(String webAppoId) =>
      '/file/upload-patient-document-for-appoinment/$webAppoId'.xBaseUrl;
}

class GuvenDoctorEndpoints extends DoctorEndpoints {
  @override
  String get getAllAppointment =>
      throw RbioUndefinedEndpointException("getAllAppointment");

  @override
  String get getMyBMIPatient =>
      throw RbioUndefinedEndpointException("getMyBMIPatient");

  @override
  String get getMyBpPatient =>
      throw RbioUndefinedEndpointException("getMyBpPatient");

  @override
  String getMyPatientBloodGlucose(int patientId) =>
      throw RbioUndefinedEndpointException("getMyPatientBloodGlucose");

  @override
  String getMyPatientDetail(int patientId) =>
      throw RbioUndefinedEndpointException("getMyPatientDetail");

  @override
  String getMyPatientPressure(int patientId) =>
      throw RbioUndefinedEndpointException("getMyPatientPressure");

  @override
  String getMyPatientScale(int patientId) =>
      throw RbioUndefinedEndpointException("getMyPatientScale");

  @override
  String get getMyScalePatient =>
      throw RbioUndefinedEndpointException("getMyScalePatient");

  @override
  String get getMySugarPatient =>
      throw RbioUndefinedEndpointException("getMySugarPatient");

  @override
  String login(String userName, String password, String consentId) =>
      throw RbioUndefinedEndpointException("login");

  @override
  String updateMyPatientLimit(int patientId) =>
      throw RbioUndefinedEndpointException("updateMyPatientLimit");

  @override
  String get getCurrentApplicationVersionPath =>
      '/applicationmobilecheckversion/get-current'.xBaseUrl;
}
