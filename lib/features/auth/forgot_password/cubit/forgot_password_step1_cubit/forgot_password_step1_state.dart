part of 'forgot_password_step1_cubit.dart';

class ForgotPasswordStep1State {
  bool isError;
  String? dialogMessage;
  bool isLoading;

  ForgotPasswordStep1State({
    this.isError = false,
    this.dialogMessage,
    this.isLoading = false,
  });

  ForgotPasswordStep1State copyWith({
    bool? isError,
    String? dialogMessage,
    bool? isLoading,
  }) {
    return ForgotPasswordStep1State(
        isError: isError ?? this.isError,
        dialogMessage: dialogMessage ?? this.dialogMessage,
        isLoading: isLoading ?? this.isLoading);
  }
}
