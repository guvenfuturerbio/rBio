import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_exception.freezed.dart';

@freezed
class ForgotPasswordExceptions with _$ForgotPasswordExceptions implements Exception {
  const factory ForgotPasswordExceptions.userNotFound() = _ForgotPasswordUserNotFound;
  const factory ForgotPasswordExceptions.phoneNumberNotMatch() = _ForgotPasswordPhoneNumberNotMatch;
  const factory ForgotPasswordExceptions.undefined() = _ForgotPasswordUndefined;
}
