// ignore_for_file: todo

part of '../abstract/app_config.dart';

class GuvenEndpoints extends IAppEndpoints {
  @override
  String get envPath => throw UnimplementedError();

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
}

class GuvenSymptomCheckerEndpoints extends SymptomCheckerEndpoints {
  @override
  // TODO: implement symptomGetBodyLocations
  String get symptomGetBodyLocations => throw UnimplementedError();

  @override
  String symptomGetBodySubLocations(int locationID) {
    // TODO: implement symptomGetBodySubLocations
    throw UnimplementedError();
  }

  @override
  String symptomGetBodySymptoms(int locationID, int gender) {
    // TODO: implement symptomGetBodySymptoms
    throw UnimplementedError();
  }

  @override
  // TODO: implement symptomGetProposed
  String get symptomGetProposed => throw UnimplementedError();

  @override
  // TODO: implement symptomGetSpecialisations
  String get symptomGetSpecialisations => throw UnimplementedError();

  @override
  // TODO: implement symptomCheckerLogin
  String get symptomCheckerLogin => throw UnimplementedError();
}

class GuvenCommonEndpoints extends CommonEndpoints {
  @override
  String getDoctorCvDetailsPath(String doctorWebID) =>
      '/api/doctor/$doctorWebID'.xGuvenPath;

  @override
  // TODO: implement consentFormPath
  String consentFormPath(String locale) => throw UnimplementedError();
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
  // TODO: implement ctAddFirebaseToken
  String get ctAddFirebaseToken => throw UnimplementedError();

  @override
  String ctAddHospitalHba1cMeasurement(entegrationId) {
    // TODO: implement ctAddHospitalHba1cMeasurement
    throw UnimplementedError();
  }

  @override
  String get ctAddProfile => throw UnimplementedError();

  @override
  String ctChangeProfile(entegrationId) {
    // TODO: implement ctChangeProfile
    throw UnimplementedError();
  }

  @override
  // TODO: implement ctDeleteBloodGlucoseValue
  String get ctDeleteBloodGlucoseValue => throw UnimplementedError();

  @override
  // TODO: implement ctDeleteBpMeasurement
  String get ctDeleteBpMeasurement => throw UnimplementedError();

  @override
  String ctDeleteProfile(userId) {
    // TODO: implement ctDeleteProfile
    throw UnimplementedError();
  }

  @override
  String ctDeleteUserStrip(int id, entegrationId) {
    // TODO: implement ctDeleteUserStrip
    throw UnimplementedError();
  }

  @override
  // TODO: implement ctGetAllProfiles
  String get ctGetAllProfiles => throw UnimplementedError();

  @override
  // TODO: implement ctGetBloodGlucoseDataOfPerson
  String get ctGetBloodGlucoseDataOfPerson => throw UnimplementedError();

  @override
  // TODO: implement ctGetBloodGlucoseReport
  String get ctGetBloodGlucoseReport => throw UnimplementedError();

  @override
  // TODO: implement ctGetBpMeasurement
  String get ctGetBpMeasurement => throw UnimplementedError();

  @override
  String ctGetHba1cMeasurementList(entegrationId) {
    // TODO: implement ctGetHba1cMeasurementList
    throw UnimplementedError();
  }

  @override
  String ctGetMedicineByFilter(String text) {
    // TODO: implement ctGetMedicineByFilter
    throw UnimplementedError();
  }

  @override
  String ctGetUserStrip(int entegrationId, String deviceuuid) {
    // TODO: implement ctGetUserStrip
    throw UnimplementedError();
  }

  @override
  // TODO: implement ctInsertNewBloodGlucoseValue
  String get ctInsertNewBloodGlucoseValue => throw UnimplementedError();

  @override
  // TODO: implement ctInsertNewBpValue
  String get ctInsertNewBpValue => throw UnimplementedError();

  @override
  String ctIsDeviceIdRegisteredForSomeUser(deviceId, entegrationId) {
    // TODO: implement ctIsDeviceIdRegisteredForSomeUser
    throw UnimplementedError();
  }

  @override
  // TODO: implement ctSetDefaultProfile
  String get ctSetDefaultProfile => throw UnimplementedError();

  @override
  // TODO: implement ctUpdateBloodGlucoseValue
  String get ctUpdateBloodGlucoseValue => throw UnimplementedError();

  @override
  // TODO: implement ctUpdateBpMeasurement
  String get ctUpdateBpMeasurement => throw UnimplementedError();

  @override
  String ctUpdateProfile(id) {
    // TODO: implement ctUpdateProfile
    throw UnimplementedError();
  }

  @override
  String ctUploadMeasurementImage(entegrationId, measurementId) {
    // TODO: implement ctUploadMeasurementImage
    throw UnimplementedError();
  }

  @override
  // TODO: implement forgotPassword
  String get forgotPassword => '/userregister/forgot-password'.xBaseUrl;

  @override
  String getBannerTab(String applicationName, String groupName) {
    // TODO: implement getBannerTab
    throw UnimplementedError();
  }

  @override
  String get getUserProfilePath => '/user/get-user-info'.xBaseUrl;

  @override
  String get loginPath => "AccessToken/get-token-for-guven-online".xBaseUrl;

  @override
  // TODO: implement sendNotification
  String get sendNotification => throw UnimplementedError();

  @override
  String get getAllRelativesPath => '/profile/get-all-table'.xBaseUrl;

  @override
  String get updateContactInfoPath =>
      '/pusula/UpdatePatientContactInfo'.xBaseUrl;

  @override
  // TODO: implement getChatContacts
  String get getChatContacts => throw UnimplementedError();

  @override
  // TODO: implement ctUpdateUserStrip
  String get ctUpdateUserStrip => throw UnimplementedError();
}

class GuvenBaseEndpoints extends BaseEndpoints {
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
  // TODO: implement findResourceAvailableDays
  String get findResourceAvailableDays => throw UnimplementedError();

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
  String changeActiveUserToRelativePath(String id) =>
      '/profile/set-profile/$id'.xBaseUrl;

  @override
  String changeUserPasswordUiPath(String oldPassword, String password) =>
      '/user/mobile-change-user-password/$oldPassword/$password'.xBaseUrl;

  @override
  String clickPostPath(int postId) => '/SocialPost/clickPost/$postId'.xBaseUrl;

  @override
  String deleteOnlineAppoFilePath(String webAppoId, String fileName) =>
      '/file/report-file-delete/$webAppoId/$fileName'.xBaseUrl;

  @override
  // TODO: implement deleteProfilePicturePath
  String get deleteProfilePicturePath => throw UnimplementedError();

  @override
  String downloadAppointmentFilePath(String id, String name) =>
      '/file/report-file-download/$id/$name'.xBaseUrl;

  @override
  String downloadAppointmentSingleFilePath(String folder, String path) =>
      '/file/download-patient-appointment-single-file/$folder/$path'.xBaseUrl;

  @override
  String filterSocialPostsPath(String search) =>
      '/SocialPost/getPostWithTagsByText/$search'.xBaseUrl;

  @override
  String filterSocialPostsPlatform(String platform) {
    // TODO: implement filterSocialPostsPlatform
    throw UnimplementedError();
  }

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
  String get getRelativeRelationshipsPath => '/user/get-relationships'.xBaseUrl;

  @override
  String getRoomStatusUiPath(String roomId) =>
      '/liveappointment/get-room-status/$roomId'.xBaseUrl;

  @override
  String get getUserKvkkInfoPath => '/user/get-user-kvkk-info'.xBaseUrl;

  @override
  String get getVisitsPath => '/Pusula/getVisits'.xBaseUrl;

  @override
  String removePatientRelativePath(String id) => '/profile/remove/$id'.xBaseUrl;

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
  String get socialResourcePath => '/SocialPost/getAllPosts'.xBaseUrl;

  @override
  // TODO: implement syncronizeOneDoseUser
  String get syncronizeOneDoseUser => throw UnimplementedError();

  @override
  // TODO: implement updatePusulaContactInfoPath
  String get updatePusulaContactInfoPath => throw UnimplementedError();

  @override
  String get updateUserKvkkInfoPath => '/user/update-user-kvkk-info'.xBaseUrl;

  @override
  String uploadFileToAppoPath(String webAppoId) =>
      '/file/upload-patient-document-for-appoinment/$webAppoId'.xBaseUrl;

  @override
  // TODO: implement uploadProfilePicturePath
  String get uploadProfilePicturePath => throw UnimplementedError();

  @override
  String get addNewPatientRelativePath => '/profile/add-pusula'.xBaseUrl;

  @override
  String get cancelAppointmentPath => '/Pusula/cancelAppointment'.xBaseUrl;

  @override
  String get checkOnlineAppointmentPaymentPath =>
      '/pusula/checkOnlineAppointmentPayment'.xBaseUrl;

  @override
  // TODO: implement ctSaveAndRetrieveToken
  String get ctSaveAndRetrieveToken => throw UnimplementedError();

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
  // TODO: implement getAllAppointment
  String get getAllAppointment => throw UnimplementedError();

  @override
  // TODO: implement getMyBMIPatient
  String get getMyBMIPatient => throw UnimplementedError();

  @override
  // TODO: implement getMyBpPatient
  String get getMyBpPatient => throw UnimplementedError();

  @override
  String getMyPatientBloodGlucose(int patientId) {
    // TODO: implement getMyPatientBloodGlucose
    throw UnimplementedError();
  }

  @override
  String getMyPatientDetail(int patientId) {
    // TODO: implement getMyPatientDetail
    throw UnimplementedError();
  }

  @override
  String getMyPatientPressure(int patientId) {
    // TODO: implement getMyPatientPressure
    throw UnimplementedError();
  }

  @override
  String getMyPatientScale(int patientId) {
    // TODO: implement getMyPatientScale
    throw UnimplementedError();
  }

  @override
  // TODO: implement getMyScalePatient
  String get getMyScalePatient => throw UnimplementedError();

  @override
  // TODO: implement getMySugarPatient
  String get getMySugarPatient => throw UnimplementedError();

  @override
  String login(String userName, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  String updateMyPatientLimit(int patientId) {
    // TODO: implement updateMyPatientLimit
    throw UnimplementedError();
  }

  @override
  String get getCurrentApplicationVersionPath =>
      '/applicationmobilecheckversion/get-current'.xBaseUrl;
}
