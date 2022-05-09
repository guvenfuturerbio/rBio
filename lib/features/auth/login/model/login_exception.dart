import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_exception.freezed.dart';

@freezed
class LoginExceptions with _$LoginExceptions implements Exception {
  const factory LoginExceptions.invalidUser() = _LoginInvalidUser;
  const factory LoginExceptions.accountNotFullySetUp() = _LoginAccountNotFullySetUp;
  const factory LoginExceptions.accountDisabled() = _LoginAccountDisabled;
  const factory LoginExceptions.serverError() = _LoginServerError;
  const factory LoginExceptions.networkError() = _LoginNetworkError;
  const factory LoginExceptions.undefined() = _LoginUndefined;
}
