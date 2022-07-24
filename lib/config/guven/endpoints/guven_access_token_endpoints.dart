part of '../../abstract/app_config.dart';

class GuvenAccessTokenEndpoints extends AccessTokenEndpoints {
  @override
  String loginPath = "/AccessToken/get-token-for-guven-online".xBaseUrl;

  @override
  String userLoginStarter = '/AccessToken/user-login-starter'.xBaseUrl;

  @override
  String verifyConfirmation2fa =
      '/AccessToken/verify-confirmation-2fa'.xBaseUrl;
}
