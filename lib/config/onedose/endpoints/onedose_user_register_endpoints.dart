part of '../../abstract/app_config.dart';

class OneDoseUserRegisterEndpoints extends UserRegisterEndpoints {
  @override
  String consentFormPath(String locale) =>
      '/userregister/get-consent-form/$locale'.xDevApiTest;

  @override
  String get addStep1 => '/UserRegister/add-step1'.xDevApiTest;

  @override
  String get addStep2 => '/UserRegister/add-step2'.xDevApiTest;

  @override
  String get addStep3 => '/UserRegister/add-step3'.xDevApiTest;

  @override
  String get forgotPassword => '/UserRegister/forgot-password'.xDevApiTest;

  @override
  String get changePassword =>
      '/UserRegister/change-password-with-old-password'.xDevApiTest;

  @override
  String get syncronizeOneDoseUser =>
      '/UserRegister/synchronize-onedose-user'.xBaseUrl;
}
