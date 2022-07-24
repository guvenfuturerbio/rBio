part of '../../abstract/app_config.dart';

class GuvenUserEndpoints extends UserEndpoints {
  @override
  String get getRelativeRelationshipsPath => '/user/get-relationships'.xBaseUrl;

  @override
  String get getUserProfilePath => '/user/get-user-info'.xBaseUrl;

  @override
  String get addFirebaseTokenUiPath => '/user/add-user-firebaseId'.xBaseUrl;

  @override
  String get sendNotification =>
      throw RbioUndefinedEndpointException("sendNotification");

  @override
  String ctGetUserStrip(int entegrationId, String deviceuuid) =>
      throw RbioUndefinedEndpointException("ctGetUserStrip");

  @override
  String get ctAddFirebaseToken =>
      throw RbioUndefinedEndpointException("ctAddFirebaseToken");

  @override
  String ctUpdateProfile(id) =>
      throw RbioUndefinedEndpointException("ctUpdateProfile");

  @override
  String get ctSetDefaultProfile =>
      throw RbioUndefinedEndpointException("ctSetDefaultProfile");

  @override
  String ctDeleteUserStrip(int id, entegrationId) =>
      throw RbioUndefinedEndpointException("ctDeleteUserStrip");

  @override
  String get updateContactInfoPath =>
      '/pusula/UpdatePatientContactInfo'.xBaseUrl;

  @override
  String get getChatContacts =>
      throw RbioUndefinedEndpointException("getChatContacts");

  @override
  String get ctUpdateUserStrip =>
      throw RbioUndefinedEndpointException("ctUpdateUserStrip");

  @override
  String changeUserPasswordUiPath(String oldPassword, String password) =>
      '/user/mobile-change-user-password/$oldPassword/$password'.xBaseUrl;

  @override
  String get getUserKvkkInfoPath => '/user/get-user-kvkk-info'.xBaseUrl;

  @override
  String get updateUserKvkkInfoPath => '/user/update-user-kvkk-info'.xBaseUrl;
}
