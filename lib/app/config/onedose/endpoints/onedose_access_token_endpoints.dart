part of '../../abstract/app_config.dart';

class OneDoseAccessTokenEndpoints extends AccessTokenEndpoints {
  @override
  String loginPath = '/AccessToken/get-token-for-rbio'.xDevApiTest;

  @override
  String userLoginStarter = '/AccessToken/user-login-starter'.xDevApiTest;

  @override
  String verifyConfirmation2fa =
      '/AccessToken/verify-confirmation-2fa'.xDevApiTest;
}
