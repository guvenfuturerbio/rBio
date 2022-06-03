part of 'app_config.dart';

abstract class IAppEndpoints {
  String get envPath;
  DoctorEndpoints get doctor;
  BaseEndpoints get base;
  DevApiEndpoints get devApi;
  CommonEndpoints get common;
  SymptomCheckerEndpoints get symptom;
  SearchEndpoints get search;
  RelativeEndpoints get relative;
}

abstract class SymptomCheckerEndpoints {
  String get symptomGetProposed;
  String get symptomGetSpecialisations;
  String get symptomGetBodyLocations;
  String symptomGetBodySubLocations(int locationID);
  String symptomGetBodySymptoms(int locationID, int gender);
  String get symptomCheckerLogin;
}

abstract class RelativeEndpoints {
  String get getAllRelativesPath;
  String removePatientRelativePath(String id);
  String changeActiveUserToRelativePath(String id);
  String get addNewPatientRelativePath;
  String get getRelativeRelationshipsPath;
}

abstract class CommonEndpoints {
  String getDoctorCvDetailsPath(String doctorWebID);
  String consentFormPath(String locale);
}

abstract class DevApiEndpoints {
  String get loginPath;
  String get addStep1;
  String get addStep2;
  String get addStep3;
  String get getUserProfilePath;
  String getBannerTab(String applicationName, String groupName);
  String get addFirebaseTokenUiPath;
  String get forgotPassword;
  String get changePassword;
  String get sendNotification;
  String ctGetUserStrip(int entegrationId, String deviceuuid);
  String get ctInsertNewBloodGlucoseValue;
  String get ctDeleteBloodGlucoseValue;
  String get ctUpdateBloodGlucoseValue;
  String ctUploadMeasurementImage(var entegrationId, var measurementId);
  String get ctGetBloodGlucoseReport;
  String get ctGetBloodGlucoseDataOfPerson;
  String get ctGetAllProfiles;
  String get ctAddProfile;
  String ctChangeProfile(entegrationId);
  String ctDeleteProfile(var userId);
  String get ctAddFirebaseToken;
  String ctUpdateProfile(var id);
  String get ctSetDefaultProfile;
  String ctDeleteUserStrip(int id, var entegrationId);
  String ctIsDeviceIdRegisteredForSomeUser(var deviceId, var entegrationId);
  String ctAddHospitalHba1cMeasurement(var entegrationId);
  String ctGetHba1cMeasurementList(var entegrationId);
  String ctGetMedicineByFilter(String text);
  String get ctInsertNewBpValue;
  String get ctDeleteBpMeasurement;
  String get ctGetBpMeasurement;
  String get ctUpdateBpMeasurement;
  String get updateContactInfoPath;
  String get getChatContacts;
  String get ctUpdateUserStrip;

  String getTreatmentNoteWithDiet(int? entegrationId);
  String getTreatmentNoteWithDietDoctor(int patientId);
  String treatmentGetDetail(int itemType, int id);
  String addTreatmentNote(int? entegrationId);
  String addTreatmentNoteDoctor(int patientId);
  String addDiet(int patientId);
  String deleteNoteDiet(int itemType, int id);
}

abstract class SearchEndpoints {
  String getPostWithTagsByText(String search);
  String getPostWithTagsByPlatform(String platform);
  String get getAllPosts;
}

abstract class BaseEndpoints {
  String get userLoginStarter;
  String get verifyConfirmation2fa;
  String get getAllPackagePath;
  String getAllSubCategoriesPath(int id);
  String getSubCategoryDetailPath(id);
  String getSubCategoryItemsPath(id);
  String get doPackagePaymentPath;
  String get findResourceAvailableDays;
  String get updateUserSystemNamePath;
  String get getActiveStreamPath;
  String get getProfilePicturePath;
  String get getPatientDetailPath;
  String get filterTenantsPath;
  String get filterDepartmentsPath;
  String get filterResourcesPath;
  String get getEventsPath;
  String get findResourceClosestAvailablePlanPath;
  String get saveAppointmentPath;
  String get syncronizeOneDoseUser;
  String get getCountriesPath;
  String get updatePusulaContactInfoPath;
  String changeUserPasswordUiPath(String oldPassword, String password);
  String getRoomStatusUiPath(String roomId);
  String getOnlineAppoFilesPath(String roomId);
  String deleteOnlineAppoFilePath(String webAppoId, String fileName);
  String get getAllTranslatorPath;
  String get getUserKvkkInfoPath;
  String get updateUserKvkkInfoPath;
  String get addSuggestionPath;
  String get setYoutubeSurveyUserPath;
  String get getCourseIdPath;
  String setJitsiWebConsultantIdPath(String webConsultantId);
  String get deleteProfilePicturePath;
  String get uploadProfilePicturePath;
  String downloadAppointmentSingleFilePath(String folder, String path);
  String get getAllFilesPath;
  String downloadAppointmentFilePath(String id, String name);
  String clickPostPath(int postId);
  String get getAppointmentTypeViaWebConsultantIdPath;
  String requestTranslatorPath(String appoId);
  String uploadFileToAppoPath(String webAppoId);
  String get getVisitsPath;
  String get getLaboratoryResultsPath;
  String get rateOnlineCallPath;
  String get getRadiologyResultsPath;
  String get getPathologyResultsPath;
  String get getLaboratoryPdfResultPath;
  String get getRadiologyPdfResultPath;
  String get getPatientAppointmentsPath;
  String get cancelAppointmentPath;
  String get getResourceVideoCallPricePath;
  String get getResourceVideoCallPriceWithVoucher;
  String get doMobilePaymentPath;
  String get doMobilePaymentWithVoucher;
  String get fetchOnlineDepartmentsPath;
  String get checkOnlineAppointmentPaymentPath;
  String get getAvailabilityRatePath;
  String uploadPatientDocumentsPath(String webAppoId);
  String get ctSaveAndRetrieveToken;
}

abstract class DoctorEndpoints {
  String get getMyBpPatient;
  String login(String userName, String password, String consentId);
  String get getAllAppointment;
  String get getMySugarPatient;
  String get getMyScalePatient;
  String get getMyBMIPatient;
  String getMyPatientDetail(int patientId);
  String updateMyPatientLimit(int patientId);
  String getMyPatientBloodGlucose(int patientId);
  String getMyPatientScale(int patientId);
  String getMyPatientPressure(int patientId);
  String get getCurrentApplicationVersionPath;
}

extension EndpointsExtension on String {
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

  String get xApiGuven {
    final String? path = getIt<KeyManager>().get(Keys.apiGuven);
    if (path != null) {
      return path + this;
    } else {
      throw Exception('SecretKeys.ApiGuven null');
    }
  }
}
