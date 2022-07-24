part of 'app_config.dart';

abstract class IAppEndpoints {
  AccessTokenEndpoints get accessToken;
  AppointmentInterpreterEndpoints get appointmentInterpreter;
  DoctorEndpoints get doctor;
  FileEndpoints get file;
  MeasurementEndpoints get measurement;
  PackageEndpoints get package;
  ProfileEndpoints get profile;
  PusulaEndpoints get pusula;
  SingleEndpoints get single;
  SocialPostEndpoints get socialPost;
  SuggestionRateEndpoints get suggestionRate;
  SymptomCheckerEndpoints get symptom;
  TreatmentEndpoints get treatment;
  UserEndpoints get user;
  UserRegisterEndpoints get userRegister;
}

abstract class AccessTokenEndpoints {
  String get loginPath;
  String get userLoginStarter;
  String get verifyConfirmation2fa;
}

abstract class AppointmentInterpreterEndpoints {
  String get getAllTranslatorPath;
  String requestTranslatorPath(String appoId);
}

abstract class DoctorEndpoints {
  String get getMyBpPatient;
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

abstract class FileEndpoints {
  String get getProfilePicturePath;
  String deleteOnlineAppoFilePath(String webAppoId, String fileName);
  String get deleteProfilePicturePath;
  String downloadAppointmentFilePath(String id, String name);
  String downloadAppointmentSingleFilePath(String folder, String path);
  String get getAllFilesPath;
  String getOnlineAppoFilesPath(String roomId);
  String uploadFileToAppoPath(String webAppoId);
  String get uploadProfilePicturePath;
  String uploadPatientDocumentsPath(String webAppoId);
}

abstract class MeasurementEndpoints {
  String get ctInsertNewBloodGlucoseValue;
  String get ctDeleteBloodGlucoseValue;
  String get ctUpdateBloodGlucoseValue;
  String ctUploadMeasurementImage(entegrationId, measurementId);
  String get ctGetBloodGlucoseReport;
  String get ctGetBloodGlucoseDataOfPerson;
  String ctAddHospitalHba1cMeasurement(entegrationId);
  String ctGetHba1cMeasurementList(entegrationId);
  String get ctInsertNewBpValue;
  String get ctDeleteBpMeasurement;
  String get ctGetBpMeasurement;
  String get ctUpdateBpMeasurement;
}

abstract class PackageEndpoints {
  String get getAllPackagePath;
  String getAllSubCategoriesPath(int id);
  String getSubCategoryDetailPath(id);
  String getSubCategoryItemsPath(id);
  String get doPackagePaymentPath;
}

abstract class ProfileEndpoints {
  String get getAllRelativesPath;
  String changeActiveUserToRelativePath(String id);
  String get addNewPatientRelativePath;
  String get getAllProfiles;
  String get addProfile;
  String get getActiveStreamPath;
}

abstract class PusulaEndpoints {
  String get findResourceAvailableDays;
  String get getPatientDetailPath;
  String get filterTenantsPath;
  String get filterDepartmentsPath;
  String get filterResourcesPath;
  String get findResourceClosestAvailablePlanPath;
  String get getCountriesPath;
  String get getEventsPath;
  String get getLaboratoryResultsPath;
  String get getVisitsPath;
  String get saveAppointmentPath;
  String get updatePusulaContactInfoPath;
  String get cancelAppointmentPath;
  String get checkOnlineAppointmentPaymentPath;
  String get doMobilePaymentPath;
  String get doMobilePaymentWithVoucher;
  String get fetchOnlineDepartmentsPath;
  String get getLaboratoryPdfResultPath;
  String get getPathologyResultsPath;
  String get getPatientAppointmentsPath;
  String get getRadiologyPdfResultPath;
  String get getRadiologyResultsPath;
  String get getResourceVideoCallPricePath;
  String get getResourceVideoCallPriceWithVoucher;
}

abstract class SingleEndpoints {
  String getDoctorCvDetailsPath(String doctorWebID);
  String getBannerTab(String applicationName, String groupName);
  String ctIsDeviceIdRegisteredForSomeUser(var deviceId, var entegrationId);
  String get updateUserSystemNamePath;
  String get getAppointmentTypeViaWebConsultantIdPath;
  String setJitsiWebConsultantIdPath(String webConsultantId);
  String sendOnlineAppointmentNotificationPusula(
    String appointmentId,
    String fromDate,
  );
}

abstract class SocialPostEndpoints {
  String clickPostPath(int postId);
  String getPostWithTagsByText(String search);
  String getPostWithTagsByPlatform(String platform);
  String get getAllPosts;
}

abstract class SuggestionRateEndpoints {
  String get addSuggestionPath;
  String get getAvailabilityRatePath;
  String get rateOnlineCallPath;
}

abstract class SymptomCheckerEndpoints {
  String get symptomGetProposed;
  String get symptomGetSpecialisations;
  String get symptomGetBodyLocations;
  String symptomGetBodySubLocations(int locationID);
  String symptomGetBodySymptoms(int locationID, int gender);
  String get symptomCheckerLogin;
}

abstract class TreatmentEndpoints {
  String getTreatmentNoteWithDiet(int? entegrationId);
  String getTreatmentNoteWithDietDoctor(int patientId);
  String treatmentGetDetail(int itemType, int id);
  String addTreatmentNote(int? entegrationId);
  String addDiet(int patientId);
  String deleteNoteDiet(int itemType, int id);
  String addTreatmentNoteDoctor(int patientId);
}

abstract class UserEndpoints {
  String get getRelativeRelationshipsPath;
  String get getUserProfilePath;
  String get addFirebaseTokenUiPath;
  String get sendNotification;
  String ctGetUserStrip(int entegrationId, String deviceuuid);
  String get ctAddFirebaseToken;
  String ctUpdateProfile(id);
  String get ctSetDefaultProfile;
  String ctDeleteUserStrip(int id, entegrationId);
  String get updateContactInfoPath;
  String get getChatContacts;
  String get ctUpdateUserStrip;
  String changeUserPasswordUiPath(String oldPassword, String password);
  String get getUserKvkkInfoPath;
  String get updateUserKvkkInfoPath;
}

abstract class UserRegisterEndpoints {
  String consentFormPath(String locale);
  String get addStep1;
  String get addStep2;
  String get addStep3;
  String get forgotPassword;
  String get changePassword;
  String get syncronizeOneDoseUser;
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
}
