part of '../../abstract/app_config.dart';

class GuvenProfileEndpoints extends ProfileEndpoints {
  @override
  String getAllRelativesPath = '/profile/get-all-table'.xBaseUrl;

  @override
  String changeActiveUserToRelativePath(String id) =>
      '/profile/set-profile/$id'.xBaseUrl;

  @override
  String addNewPatientRelativePath = '/profile/add-relative'.xBaseUrl;

  @override
  String get getAllProfiles =>
      throw RbioUndefinedEndpointException("getAllProfiles");

  @override
  String get addProfile => throw RbioUndefinedEndpointException("addProfile");

  @override
  String getActiveStreamPath = '/profile/get-active-stream'.xBaseUrl;
}
