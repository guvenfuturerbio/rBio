part of '../../abstract/app_config.dart';

class OneDoseUserEndpoints extends UserEndpoints {
  @override
  String get getRelativeRelationshipsPath => '/user/get-relationships'.xBaseUrl;

  @override
  String get getUserProfilePath => '/user/get-user-info'.xDevApiTest;

  @override
  String get addFirebaseTokenUiPath => '/user/add-user-firebaseId'.xDevApiTest;

  @override
  String get sendNotification => '/User/send-message'.xDevApiTest;

  @override
  String ctGetUserStrip(int entegrationId, String deviceuuid) =>
      '/user/get-user-strip/$entegrationId/$deviceuuid'.xDevApiTest;

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
  String get updateContactInfoPath =>
      '/User/UpdatePatientContactInfo'.xDevApiTest;

  @override
  String get getChatContacts => '/User/get-chat-contacts'.xDevApiTest;

  @override
  String get ctUpdateUserStrip => '/user/add-update-user-strip'.xDevApiTest;

  @override
  String changeUserPasswordUiPath(String oldPassword, String password) =>
      '/user/mobile-change-user-password/$oldPassword/$password'.xDevApiTest;

  @override
  String get getUserKvkkInfoPath => '/user/get-user-kvkk-info'.xBaseUrl;

  @override
  String get updateUserKvkkInfoPath => '/user/update-user-kvkk-info'.xBaseUrl;
}
