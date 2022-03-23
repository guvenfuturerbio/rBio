part of 'resources.dart';

class _ApiEnums {
  final forgotPassword = _ForgotPassword();
  final changePassword = _ChangePassword();
  final register = _Register();
}

class _ForgotPassword {
  final userNotFound = 1;
  final phoneNumberNotMatch = 2;
}

class _ChangePassword {
  final oldError = 1;
  final confirmError = 2;
  final success = 3;
  final systemError = 4;
}

class _Register {
  final userNotExist = 1;
  final userExistActived = 2;
  final userExistNotActived = 3;
  // final MailExist = 4;
  final kpsError = 5;
  final step2PasswordPass = 6;
  final wrongSmsCode = 7;
  final smsTimeOut = 8;
  final correctSmsCode = 9;
  final userSaved = 10;
  final keyCloakConfig = 11;
  final keyCloakServerError = 12;
  final smsTimeOutUserDeleted = 13;
  final step2PasswordPassNoSendSms = 14;
  final userCheckPhoneError = 15;
  final userExistOnProile = 16;
  final canNotBeSentSms = 17;
  final userSavedOneDose = 18;
  final unexpectedRegisterFlow = 19;
}
