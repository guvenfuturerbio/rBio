part of '../../abstract/app_config.dart';

class OneDoseProfileEndpoints extends ProfileEndpoints {
  @override
  String getAllRelativesPath = '/profile/get-all-table'.xBaseUrl;

  @override
  String changeActiveUserToRelativePath(String id) =>
      '/profile/set-profile/$id'.xBaseUrl;

  @override
  String addNewPatientRelativePath = '/profile/add-relative'.xBaseUrl;

  @override
  String getAllProfiles = '/profile/get-all'.xDevApiTest;

  @override
  String addProfile = '/profile/add'.xDevApiTest;

  @override
  String getActiveStreamPath = '/profile/get-active-stream'.xBaseUrl;
}
