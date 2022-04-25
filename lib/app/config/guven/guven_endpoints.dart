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
  String getDoctorCvDetailsPath(String doctorWebID) {
    // TODO: implement getDoctorCvDetailsPath
    throw UnimplementedError();
  }

  @override
  // TODO: implement consentFormPath
  String consentFormPath(String locale) => throw UnimplementedError();
}

class GuvenDevApiEndpoints extends DevApiEndpoints {
  @override
  // TODO: implement addFirebaseTokenUiPath
  String get addFirebaseTokenUiPath => throw UnimplementedError();

  @override
  // TODO: implement addStep1
  String get addStep1 => throw UnimplementedError();

  @override
  // TODO: implement addStep2
  String get addStep2 => throw UnimplementedError();

  @override
  // TODO: implement addStep3
  String get addStep3 => throw UnimplementedError();

  @override
  // TODO: implement changePassword
  String get changePassword => throw UnimplementedError();

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
  String get forgotPassword => throw UnimplementedError();

  @override
  String getBannerTab(String applicationName, String groupName) {
    // TODO: implement getBannerTab
    throw UnimplementedError();
  }

  @override
  // TODO: implement getUserProfilePath
  String get getUserProfilePath => throw UnimplementedError();

  @override
  // TODO: implement loginPath
  String get loginPath => throw UnimplementedError();

  @override
  // TODO: implement sendNotification
  String get sendNotification => throw UnimplementedError();

  @override
  // TODO: implement getAllRelativesPath
  String get getAllRelativesPath => throw UnimplementedError();

  @override
  // TODO: implement updateContactInfoPath
  String get updateContactInfoPath => throw UnimplementedError();

  @override
  // TODO: implement getChatContacts
  String get getChatContacts => throw UnimplementedError();

  @override
  // TODO: implement ctUpdateUserStrip
  String get ctUpdateUserStrip => throw UnimplementedError();
}

class GuvenBaseEndpoints extends BaseEndpoints {
  @override
  String get getAllPackagePath => throw UnimplementedError();

  @override
  String getAllSubCategoriesPath(int id) => throw UnimplementedError();

  @override
  String getSubCategoryDetailPath(id) => throw UnimplementedError();

  @override
  String getSubCategoryItemsPath(id) => throw UnimplementedError();

  @override
  // TODO: implement doPackagePaymentPath
  String get doPackagePaymentPath => throw UnimplementedError();

  @override
  // TODO: implement findResourceAvailableDays
  String get findResourceAvailableDays => throw UnimplementedError();

  @override
  // TODO: implement updateUserSystemNamePath
  String get updateUserSystemNamePath => throw UnimplementedError();

  @override
  // TODO: implement getActiveStreamPath
  String get getActiveStreamPath => throw UnimplementedError();

  @override
  // TODO: implement getProfilePicturePath
  String get getProfilePicturePath => throw UnimplementedError();

  @override
  // TODO: implement getPatientDetailPath
  String get getPatientDetailPath => throw UnimplementedError();

  @override
  // TODO: implement filterTenantsPath
  String get filterTenantsPath => throw UnimplementedError();

  @override
  // TODO: implement filterDepartmentsPath
  String get filterDepartmentsPath => throw UnimplementedError();

  @override
  // TODO: implement filterResourcesPath
  String get filterResourcesPath => throw UnimplementedError();

  @override
  // TODO: implement addSuggestionPath
  String get addSuggestionPath => throw UnimplementedError();

  @override
  String changeActiveUserToRelativePath(String id) {
    // TODO: implement changeActiveUserToRelativePath
    throw UnimplementedError();
  }

  @override
  String changeUserPasswordUiPath(String oldPassword, String password) {
    // TODO: implement changeUserPasswordUiPath
    throw UnimplementedError();
  }

  @override
  String clickPostPath(int postId) {
    // TODO: implement clickPostPath
    throw UnimplementedError();
  }

  @override
  String deleteOnlineAppoFilePath(String webAppoId, String fileName) {
    // TODO: implement deleteOnlineAppoFilePath
    throw UnimplementedError();
  }

  @override
  // TODO: implement deleteProfilePicturePath
  String get deleteProfilePicturePath => throw UnimplementedError();

  @override
  String downloadAppointmentFilePath(String id, String name) {
    // TODO: implement downloadAppointmentFilePath
    throw UnimplementedError();
  }

  @override
  String downloadAppointmentSingleFilePath(String folder, String path) {
    // TODO: implement downloadAppointmentSingleFilePath
    throw UnimplementedError();
  }

  @override
  String filterSocialPostsPath(String search) {
    // TODO: implement filterSocialPostsPath
    throw UnimplementedError();
  }

  @override
  String filterSocialPostsPlatform(String platform) {
    // TODO: implement filterSocialPostsPlatform
    throw UnimplementedError();
  }

  @override
  // TODO: implement findResourceClosestAvailablePlanPath
  String get findResourceClosestAvailablePlanPath => throw UnimplementedError();

  @override
  // TODO: implement getAllFilesPath
  String get getAllFilesPath => throw UnimplementedError();

  @override
  // TODO: implement getAllTranslatorPath
  String get getAllTranslatorPath => throw UnimplementedError();

  @override
  // TODO: implement getAppointmentTypeViaWebConsultantIdPath
  String get getAppointmentTypeViaWebConsultantIdPath =>
      throw UnimplementedError();

  @override
  // TODO: implement getCountriesPath
  String get getCountriesPath => throw UnimplementedError();

  @override
  // TODO: implement getCourseIdPath
  String get getCourseIdPath => throw UnimplementedError();

  @override
  // TODO: implement getEventsPath
  String get getEventsPath => throw UnimplementedError();

  @override
  // TODO: implement getLaboratoryResultsPath
  String get getLaboratoryResultsPath => throw UnimplementedError();

  @override
  String getOnlineAppoFilesPath(String roomId) {
    // TODO: implement getOnlineAppoFilesPath
    throw UnimplementedError();
  }

  @override
  // TODO: implement getRelativeRelationshipsPath
  String get getRelativeRelationshipsPath => throw UnimplementedError();

  @override
  String getRoomStatusUiPath(String roomId) {
    // TODO: implement getRoomStatusUiPath
    throw UnimplementedError();
  }

  @override
  // TODO: implement getUserKvkkInfoPath
  String get getUserKvkkInfoPath => throw UnimplementedError();

  @override
  // TODO: implement getVisitsPath
  String get getVisitsPath => throw UnimplementedError();

  @override
  String removePatientRelativePath(String id) {
    // TODO: implement removePatientRelativePath
    throw UnimplementedError();
  }

  @override
  String requestTranslatorPath(String appoId) {
    // TODO: implement requestTranslatorPath
    throw UnimplementedError();
  }

  @override
  // TODO: implement saveAppointmentPath
  String get saveAppointmentPath => throw UnimplementedError();

  @override
  String setJitsiWebConsultantIdPath(String webConsultantId) {
    // TODO: implement setJitsiWebConsultantIdPath
    throw UnimplementedError();
  }

  @override
  // TODO: implement setYoutubeSurveyUserPath
  String get setYoutubeSurveyUserPath => throw UnimplementedError();

  @override
  // TODO: implement socialResourcePath
  String get socialResourcePath => throw UnimplementedError();

  @override
  // TODO: implement syncronizeOneDoseUser
  String get syncronizeOneDoseUser => throw UnimplementedError();

  @override
  // TODO: implement updatePusulaContactInfoPath
  String get updatePusulaContactInfoPath => throw UnimplementedError();

  @override
  // TODO: implement updateUserKvkkInfoPath
  String get updateUserKvkkInfoPath => throw UnimplementedError();

  @override
  String uploadFileToAppoPath(String webAppoId) {
    // TODO: implement uploadFileToAppoPath
    throw UnimplementedError();
  }

  @override
  // TODO: implement uploadProfilePicturePath
  String get uploadProfilePicturePath => throw UnimplementedError();

  @override
  // TODO: implement addNewPatientRelativePath
  String get addNewPatientRelativePath => throw UnimplementedError();

  @override
  // TODO: implement cancelAppointmentPath
  String get cancelAppointmentPath => throw UnimplementedError();

  @override
  // TODO: implement checkOnlineAppointmentPaymentPath
  String get checkOnlineAppointmentPaymentPath => throw UnimplementedError();

  @override
  // TODO: implement ctSaveAndRetrieveToken
  String get ctSaveAndRetrieveToken => throw UnimplementedError();

  @override
  // TODO: implement doMobilePaymentPath
  String get doMobilePaymentPath => throw UnimplementedError();

  @override
  // TODO: implement doMobilePaymentWithVoucher
  String get doMobilePaymentWithVoucher => throw UnimplementedError();

  @override
  // TODO: implement fetchOnlineDepartmentsPath
  String get fetchOnlineDepartmentsPath => throw UnimplementedError();

  @override
  // TODO: implement getAvailabilityRatePath
  String get getAvailabilityRatePath => throw UnimplementedError();

  @override
  // TODO: implement getLaboratoryPdfResultPath
  String get getLaboratoryPdfResultPath => throw UnimplementedError();

  @override
  // TODO: implement getPathologyResultsPath
  String get getPathologyResultsPath => throw UnimplementedError();

  @override
  // TODO: implement getPatientAppointmentsPath
  String get getPatientAppointmentsPath => throw UnimplementedError();

  @override
  // TODO: implement getRadiologyPdfResultPath
  String get getRadiologyPdfResultPath => throw UnimplementedError();

  @override
  // TODO: implement getRadiologyResultsPath
  String get getRadiologyResultsPath => throw UnimplementedError();

  @override
  // TODO: implement getResourceVideoCallPricePath
  String get getResourceVideoCallPricePath => throw UnimplementedError();

  @override
  // TODO: implement getResourceVideoCallPriceWithVoucher
  String get getResourceVideoCallPriceWithVoucher => throw UnimplementedError();

  @override
  // TODO: implement rateOnlineCallPath
  String get rateOnlineCallPath => throw UnimplementedError();

  @override
  String uploadPatientDocumentsPath(String webAppoId) {
    // TODO: implement uploadPatientDocumentsPath
    throw UnimplementedError();
  }
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
  // TODO: implement getCurrentApplicationVersionPath
  String get getCurrentApplicationVersionPath => throw UnimplementedError();
}
