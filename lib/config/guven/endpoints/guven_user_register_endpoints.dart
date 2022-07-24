part of '../../abstract/app_config.dart';

class GuvenUserRegisterEndpoints extends UserRegisterEndpoints {
  @override
  String consentFormPath(String locale) =>
      "/UserRegister/get-consent-form/$locale".xBaseUrl;

  @override
  String get addStep1 => '/userregister/add-step1-pusula'.xBaseUrl;

  @override
  String get addStep2 => "/userregister/add-step2".xBaseUrl;

  @override
  String get addStep3 => '/userregister/add-step3'.xBaseUrl;

  @override
  String get forgotPassword => '/userregister/forgot-password'.xBaseUrl;

  @override
  String get changePassword =>
      '/userregister/change-password-with-old-password'.xBaseUrl;

  @override
  String get syncronizeOneDoseUser =>
      throw RbioUndefinedEndpointException("syncronizeOneDoseUser");
}
