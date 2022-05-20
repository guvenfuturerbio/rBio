part of '../abstract/app_config.dart';

class OneDoseEndpoints extends IAppEndpoints {
  @override
  String get envPath => 'env/onedose/.prod.env';

  @override
  DoctorEndpoints get doctor => OneDoseDoctorEndpoints();

  @override
  BaseEndpoints get base => OneDoseBaseEndpoints();

  @override
  DevApiEndpoints get devApi => OneDoseDevApiEndpoints();

  @override
  CommonEndpoints get common => OneDoseCommonEndpoints();

  @override
  SymptomCheckerEndpoints get symptom => OneDoseSymptomCheckerEndpoints();

  @override
  SearchEndpoints get search => OneDoseSearchEndpoints();

  @override
  RelativeEndpoints get relative => OneDoseRelativeEndpoints();
}

class OneDoseRelativeEndpoints extends RelativeEndpoints {
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

class OneDoseSymptomCheckerEndpoints extends SymptomCheckerEndpoints {
  @override
  String get symptomGetProposed => '/symptoms/proposed'.xSymptomCheckerRequest;

  @override
  String get symptomGetSpecialisations =>
      '/diagnosis/specialisations'.xSymptomCheckerRequest;

  @override
  String get symptomGetBodyLocations =>
      '/body/locations'.xSymptomCheckerRequest;

  @override
  String symptomGetBodySubLocations(int locationID) =>
      '/body/locations/$locationID'.xSymptomCheckerRequest;

  @override
  String symptomGetBodySymptoms(int locationID, int gender) =>
      '/symptoms/$locationID/$gender'.xSymptomCheckerRequest;

  @override
  String get symptomCheckerLogin => '/login'.xSymptomCheckerLogin;
}

class OneDoseSearchEndpoints extends SearchEndpoints {
  @override
  String getPostWithTagsByText(String search) =>
      '/socialpost/getPostWithTagsByText/$search'.xBaseUrl;

  @override
  String getPostWithTagsByPlatform(String platform) =>
      '/socialPost/getPostWithTagsByPlatform/$platform'.xBaseUrl;

  @override
  String get getAllPosts => '/socialpost/getAllPosts'.xBaseUrl;
}

class OneDoseCommonEndpoints extends CommonEndpoints {
  @override
  String getDoctorCvDetailsPath(String doctorWebID) =>
      '/api/doctor/$doctorWebID'.xGuvenPath;

  @override
  String consentFormPath(String locale) =>
      '/userregister/get-consent-form/$locale'.xDevApiTest;
}

class OneDoseDevApiEndpoints extends DevApiEndpoints {
  @override
  String get loginPath => '/AccessToken/get-token-for-rbio'.xDevApiTest;

  @override
  String get addStep1 => '/UserRegister/add-step1'.xDevApiTest;

  @override
  String get addStep2 => '/UserRegister/add-step2'.xDevApiTest;

  @override
  String get addStep3 => '/UserRegister/add-step3'.xDevApiTest;

  @override
  String get getUserProfilePath => '/user/get-user-info'.xDevApiTest;

  @override
  String getBannerTab(String applicationName, String groupName) =>
      '/Banner/get-banner-tabs/$applicationName/$groupName'.xDevApiTest;

  @override
  String get addFirebaseTokenUiPath => '/user/add-user-firebaseId'.xDevApiTest;

  @override
  String get forgotPassword => '/UserRegister/forgot-password'.xDevApiTest;

  @override
  String get changePassword =>
      '/UserRegister/change-password-with-old-password'.xDevApiTest;

  @override
  String get sendNotification => '/User/send-message'.xDevApiTest;

  @override
  String ctGetUserStrip(int entegrationId, String deviceuuid) =>
      '/user/get-user-strip/$entegrationId/$deviceuuid'.xDevApiTest;

  @override
  String get ctInsertNewBloodGlucoseValue =>
      '/Measurement/add-blood-glucose-with-detail'.xDevApiTest;

  @override
  String get ctDeleteBloodGlucoseValue =>
      '/Measurement/delete-blood-glucose-with-detail'.xDevApiTest;

  @override
  String get ctUpdateBloodGlucoseValue =>
      '/Measurement/update-blood-glucose-with-detail'.xDevApiTest;

  @override
  String ctUploadMeasurementImage(entegrationId, measurementId) =>
      '/Measurement/upload-measurement-image/$entegrationId/$measurementId'
          .xDevApiTest;

  @override
  String get ctGetBloodGlucoseReport =>
      '/Measurement/get-my-blood-glucose-report'.xDevApiTest;

  @override
  String get ctGetBloodGlucoseDataOfPerson =>
      '/Measurement/get-my-blood-glucose-with-detail-and-limit-value'
          .xDevApiTest;

  @override
  String get ctGetAllProfiles => '/profile/get-all'.xDevApiTest;

  @override
  String get ctAddProfile => '/profile/add'.xDevApiTest;

  @override
  String ctChangeProfile(entegrationId) =>
      '/profile/set-profile/$entegrationId'.xDevApiTest;

  @override
  String ctDeleteProfile(userId) => '/profile/delete/$userId'.xDevApiTest;

  @override
  String get ctAddFirebaseToken => '/user/add-user-firebaseId'.xDevApiTest;

  @override
  String ctUpdateProfile(id) => '/user/user-profile-update/$id'.xDevApiTest;

  @override
  String get ctSetDefaultProfile =>
      '/user/set-user-profile-default-value'.xDevApiTest;

  @override
  String ctDeleteUserStrip(int id, entegrationId) =>
      '/user/delete-user-strip/$id/$entegrationId'.xDevApiTest;

  @override
  String ctIsDeviceIdRegisteredForSomeUser(deviceId, entegrationId) =>
      '/SugarDevice/is-device-id-registered-for-some-user/$deviceId/$entegrationId'
          .xDevApiTest;

  @override
  String ctAddHospitalHba1cMeasurement(entegrationId) =>
      '/Measurement/add-hospital-hba1c-measurement/$entegrationId'.xDevApiTest;

  @override
  String ctGetHba1cMeasurementList(entegrationId) =>
      '/Measurement/get-list-hospital-hba1c-measurement/$entegrationId'
          .xDevApiTest;

  @override
  String ctGetMedicineByFilter(String text) =>
      '/Medicine/get-by-filter/$text'.xDevApiTest;

  @override
  String get ctInsertNewBpValue =>
      '/Measurement/add-bp-with-detail'.xDevApiTest;

  @override
  String get ctDeleteBpMeasurement =>
      '/Measurement/delete-bp-with-detail'.xDevApiTest;

  @override
  String get ctGetBpMeasurement =>
      '/Measurement/get-bp-measurements'.xDevApiTest;

  @override
  String get ctUpdateBpMeasurement =>
      '/Measurement/update-bp-measurement'.xDevApiTest;

  @override
  String get updateContactInfoPath =>
      '/User/UpdatePatientContactInfo'.xDevApiTest;

  @override
  String get getChatContacts => '/User/get-chat-contacts'.xDevApiTest;

  @override
  String get ctUpdateUserStrip => '/user/add-update-user-strip'.xDevApiTest;

  @override
  String getTreatmentNoteWithDiet(int? entegrationId) =>
      '/Treatment/get-treatment-note-with-diet/$entegrationId'.xDevApiTest;
}

class OneDoseBaseEndpoints extends BaseEndpoints {
  @override
  String get userLoginStarter => '/AccessToken/user-login-starter'.xDevApiTest;

  @override
  String get verifyConfirmation2fa =>
      '/AccessToken/verify-confirmation-2fa'.xDevApiTest;

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
  String get doPackagePaymentPath => '/Package/do-mobile-payment'.xBaseUrl;

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
  String get getEventsPath => '/Pusula/getevents'.xBaseUrl;

  @override
  String get findResourceClosestAvailablePlanPath =>
      '/Pusula/findResourceClosestAvailablePlan'.xBaseUrl;

  @override
  String get saveAppointmentPath => '/Pusula/saveAppointment'.xBaseUrl;

  @override
  String get syncronizeOneDoseUser =>
      '/UserRegister/synchronize-onedose-user'.xBaseUrl;

  @override
  String get getCountriesPath => '/Pusula/getCountries'.xBaseUrl;

  @override
  String get updatePusulaContactInfoPath =>
      '/pusula/UpdatePatientContactInfo'.xBaseUrl;

  @override
  String changeUserPasswordUiPath(String oldPassword, String password) =>
      '/user/mobile-change-user-password/$oldPassword/$password'.xBaseUrl;

  @override
  String getRoomStatusUiPath(String roomId) =>
      '/liveappointment/get-room-status/$roomId'.xBaseUrl;

  @override
  String getOnlineAppoFilesPath(String roomId) =>
      '/file/get-patient-appointments-file-names/$roomId'.xBaseUrl;

  @override
  String deleteOnlineAppoFilePath(String webAppoId, String fileName) =>
      '/file/report-file-delete/$webAppoId/$fileName'.xBaseUrl;

  @override
  String get getAllTranslatorPath => '/appointmentinterpreter/get-all'.xBaseUrl;

  @override
  String get getUserKvkkInfoPath => '/user/get-user-kvkk-info'.xBaseUrl;

  @override
  String get updateUserKvkkInfoPath => '/user/update-user-kvkk-info'.xBaseUrl;

  @override
  String get addSuggestionPath => '/SuggestionRate/Add-Suggestion'.xBaseUrl;

  @override
  String get setYoutubeSurveyUserPath => '/course/save-user'.xBaseUrl;

  @override
  String get getCourseIdPath => '/course/get-active'.xBaseUrl;

  @override
  String setJitsiWebConsultantIdPath(String webConsultantId) =>
      '/CerebrumOnlineAppointment/set-mobile-appointment-entrance-c4dd4e4ac7c34592827f0dbbfc233c56/$webConsultantId'
          .xBaseUrl;

  @override
  String get deleteProfilePicturePath => '/file/delete-profile-photo'.xBaseUrl;

  @override
  String get uploadProfilePicturePath => '/file/profil-image-upload'.xBaseUrl;

  @override
  String downloadAppointmentSingleFilePath(String folder, String path) =>
      '/file/download-patient-appointment-single-file/$folder/$path'.xBaseUrl;

  @override
  String get getAllFilesPath =>
      '/file/get-patient-all-appointments-file-names'.xBaseUrl;

  @override
  String downloadAppointmentFilePath(String id, String name) =>
      '/file/report-file-download/$id/$name'.xBaseUrl;

  @override
  String clickPostPath(int postId) => '/socialpost/clickPost/$postId'.xBaseUrl;

  @override
  String get getAppointmentTypeViaWebConsultantIdPath =>
      '/videoCall/get-stream-type-mobile'.xBaseUrl;

  @override
  String requestTranslatorPath(String appoId) =>
      '/appointmentinterpreter/add-update-appointment-interpreter-pusula/$appoId'
          .xBaseUrl;

  @override
  String uploadFileToAppoPath(String webAppoId) =>
      '/file/upload-patient-document-for-appoinment/$webAppoId'.xBaseUrl;

  @override
  String get getVisitsPath => '/Pusula/getVisits'.xBaseUrl;

  @override
  String get getLaboratoryResultsPath =>
      '/Pusula/getLaboratoryResults'.xBaseUrl;

  @override
  String get rateOnlineCallPath =>
      '/SuggestionRate/Add-Availability-Rate-pusula'.xBaseUrl;

  @override
  String get getRadiologyResultsPath => '/Pusula/getRadiologyResults'.xBaseUrl;

  @override
  String get getPathologyResultsPath => '/Pusula/getPathologyResults'.xBaseUrl;

  @override
  String get getLaboratoryPdfResultPath =>
      '/Pusula/getLaboratoryResultsPdf'.xBaseUrl;

  @override
  String get getRadiologyPdfResultPath =>
      '/Pusula/getRadiologyResultsPdf'.xBaseUrl;

  @override
  String get getPatientAppointmentsPath =>
      '/Pusula/getPatientAppointments'.xBaseUrl;

  @override
  String get cancelAppointmentPath => '/Pusula/cancelAppointment'.xBaseUrl;

  @override
  String get getResourceVideoCallPricePath =>
      '/Pusula/getResourceVideoCallPrice'.xBaseUrl;

  @override
  String get getResourceVideoCallPriceWithVoucher =>
      '/Pusula/getResourceVideoCallPriceWithVoucher'.xBaseUrl;

  @override
  String get doMobilePaymentPath => '/Pusula/do-mobile-payment'.xBaseUrl;

  @override
  String get doMobilePaymentWithVoucher =>
      "/Pusula/do-mobile-payment-with-voucher".xBaseUrl;

  @override
  String get fetchOnlineDepartmentsPath =>
      '/Pusula/getOnlineDepartments'.xBaseUrl;

  @override
  String get checkOnlineAppointmentPaymentPath =>
      '/pusula/checkOnlineAppointmentPayment'.xBaseUrl;

  @override
  String get getAvailabilityRatePath =>
      '/SuggestionRate/Get-Availability-Rate-Pusula'.xBaseUrl;

  @override
  String uploadPatientDocumentsPath(String webAppoId) =>
      '/file/upload-patient-document-for-appoinment/$webAppoId'.xBaseUrl;

  @override
  String get ctSaveAndRetrieveToken =>
      '/AccessToken/validate-remote-token'.xBaseUrl;
}

class OneDoseDoctorEndpoints extends DoctorEndpoints {
  @override
  String get getMyBpPatient =>
      "/api/v1/DoctorPatient/get-my-bp-patient".xDoctorBaseUrl;

  @override
  String login(userName, password) =>
      '/AccessToken/get-token-for-rbio?userName=$userName&password=$password'
          .xDoctorBaseUrl;

  @override
  String get getAllAppointment =>
      '/mobileapi/v1/MobileDoctor/all-appointment'.xDoctorBaseUrl;

  @override
  String get getMySugarPatient =>
      '/api/v1/DoctorPatient/get-my-sugar-patient'.xDoctorBaseUrl;

  @override
  String get getMyScalePatient =>
      '/api/v1/DoctorPatient/get-my-bmi-patient'.xDoctorBaseUrl;

  @override
  String get getMyBMIPatient =>
      '/api/v1/DoctorPatient/get-my-bmi-patient'.xDoctorBaseUrl;

  @override
  String getMyPatientDetail(patientId) =>
      '/api/v1/doctorpatient/get-my-patient-profile-detail/$patientId'
          .xDoctorBaseUrl;

  @override
  String updateMyPatientLimit(patientId) =>
      '/api/v1/doctorpatient/update-my-patient-limit-detail/$patientId'
          .xDoctorBaseUrl;

  @override
  String getMyPatientBloodGlucose(patientId) =>
      '/api/v1/doctorpatient/get-my-patient-blood-glucose-with-detail/$patientId'
          .xDoctorBaseUrl;

  @override
  String getMyPatientScale(patientId) =>
      '/api/v1/doctorpatient/get-my-patient-bmi/$patientId'.xDoctorBaseUrl;

  @override
  String getMyPatientPressure(patientId) =>
      '/api/v1/doctorpatient/get-my-patient-bp/$patientId'.xDoctorBaseUrl;

  @override
  String get getCurrentApplicationVersionPath =>
      '/api/v1/ApplicationMobileCheckVersion/get-current'.xDoctorBaseUrl;
}
