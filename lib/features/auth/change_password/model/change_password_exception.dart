import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_exception.freezed.dart';

@freezed
class ChangePasswordExceptions with _$ChangePasswordExceptions implements Exception {
  const factory ChangePasswordExceptions.oldError() = _ChangePasswordOldError;
  const factory ChangePasswordExceptions.confirmError() = _ChangePasswordConfirmError;
  const factory ChangePasswordExceptions.systemError() = _ChangePasswordSystemError;
  const factory ChangePasswordExceptions.undefined() = _ChangePasswordUndefined;
}
