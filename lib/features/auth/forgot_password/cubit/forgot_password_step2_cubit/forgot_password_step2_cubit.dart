import 'package:bloc/bloc.dart';

import '../../../../../core/core.dart';
import '../../../change_password/model/change_password_model.dart';

part 'forgot_password_step2_state.dart';

class ForgotPasswordStep2Cubit extends Cubit<ForgotPasswordStep2State> {
  ForgotPasswordStep2Cubit({
    required this.repository,
  }) : super(ForgotPasswordStep2State());
  late final Repository repository;

  final PasswordHelper passwordHelper = PasswordHelper();

  void togglePasswordVisibility(bool value) {
    emit(state.copyWith(passwordVisibility: !value));
  }

  void checkPasswordCapability(String newPassword) {
    passwordHelper.checkPassword(newPassword);
    emit(
      state.copyWith(
        checkLength: passwordHelper.lengthValue,
        checkLowerCase: passwordHelper.lowerCaseValue,
        checkNumeric: passwordHelper.numericValue,
        checkSpecial: passwordHelper.specialValue,
        checkUpperCase: passwordHelper.upperCaseValue,
      ),
    );
  }

  void forgotPassStep2(ChangePasswordModel changePasswordModel) async {
    if (passwordHelper.validateStructure()) {
      emit(state.copyWith(isLoading: true));

      final either = await repository.changePassword(changePasswordModel);
      await either.fold(
        (response) async {
          emit(
            state.copyWith(
              isLoading: false,
              isLoginWithSuccessChangePassword: true,
            ),
          );
        },
        (error) {
          error.when(
            oldError: () {
              showDialog(
                LocaleProvider.current.wrong_temporary_pass,
              );
            },
            confirmError: () {
              showDialog(
                LocaleProvider.current.pass_must_same,
              );
            },
            systemError: () {
              showDialog(
                LocaleProvider.current.error_system_malfunction,
              );
            },
            undefined: () {
              showDialog(
                LocaleProvider.current.sorry_dont_transaction,
              );
            },
          );
        },
      );
    }
  }

  void showDialog(String description) {
    emit(
      state.copyWith(
        isError: true,
        isLoading: false,
        dialogMessage: description,
      ),
    );
    Future.delayed(
      const Duration(milliseconds: 250),
      () {
        emit(
          state.copyWith(
            isError: false,
            dialogMessage: null,
          ),
        );
      },
    );
  }
}
