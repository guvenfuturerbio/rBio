// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_step2_cubit.dart';

class ForgotPasswordStep2State {
  bool temporaryPasswordVisibility;
  bool newPasswordAgainVisibility;
  bool passwordVisibility;
  bool checkLowerCase;
  bool checkUpperCase;
  bool checkNumeric;
  bool checkSpecial;
  bool checkLength;
  bool isLoading;
  bool isError;
  String? dialogMessage;
  bool isLoginWithSuccessChangePassword;

  ForgotPasswordStep2State({
    this.temporaryPasswordVisibility = false,
    this.newPasswordAgainVisibility = false,
    this.passwordVisibility = false,
    this.checkLowerCase = false,
    this.checkUpperCase = false,
    this.checkNumeric = false,
    this.checkSpecial = false,
    this.checkLength = false,
    this.isLoading = false,
    this.isError = false,
    this.dialogMessage,
    this.isLoginWithSuccessChangePassword = false,
  });

  ForgotPasswordStep2State copyWith({
    bool? temporaryPasswordVisibility,
    bool? newPasswordAgainVisibility,
    bool? passwordVisibility,
    bool? checkLowerCase,
    bool? checkUpperCase,
    bool? checkNumeric,
    bool? checkSpecial,
    bool? checkLength,
    bool? isLoading,
    bool? isError,
    String? dialogMessage,
    bool? isLoginWithSuccessChangePassword,
  }) {
    return ForgotPasswordStep2State(
        temporaryPasswordVisibility:
            temporaryPasswordVisibility ?? this.temporaryPasswordVisibility,
        newPasswordAgainVisibility:
            newPasswordAgainVisibility ?? this.newPasswordAgainVisibility,
        passwordVisibility: passwordVisibility ?? this.passwordVisibility,
        checkLowerCase: checkLowerCase ?? this.checkLowerCase,
        checkUpperCase: checkUpperCase ?? this.checkUpperCase,
        checkNumeric: checkNumeric ?? this.checkNumeric,
        checkSpecial: checkSpecial ?? this.checkSpecial,
        checkLength: checkLength ?? this.checkLength,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        dialogMessage: dialogMessage ?? this.dialogMessage,
        isLoginWithSuccessChangePassword: isLoginWithSuccessChangePassword ??
            this.isLoginWithSuccessChangePassword);
  }
}
