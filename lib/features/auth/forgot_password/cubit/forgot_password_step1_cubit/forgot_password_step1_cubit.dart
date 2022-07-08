import 'package:bloc/bloc.dart';

import '../../../../../core/core.dart';
import '../../../register/model/model.dart';

part 'forgot_password_step1_state.dart';

class ForgotPasswordStep1Cubit extends Cubit<ForgotPasswordStep1State> {
  ForgotPasswordStep1Cubit(this.repository) : super(ForgotPasswordStep1State());
  late final Repository repository;

  void forgotPassStep1(UserRegistrationStep1Model userRegistrationStep1) async {
    emit(state.copyWith(isLoading: true));

    final either = await repository.forgotPassword(userRegistrationStep1);
    await either.fold(
      (response) async {
        await Future.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(isLoading: false));
        Atom.to(
          PagePaths.forgotPasswordStep2,
          queryParameters: {
            'identityNumber': userRegistrationStep1.identificationNumber ?? '',
          },
        );
      },
      (error) {
        error.when(
          userNotFound: () {
            showDialog(
              LocaleProvider.current.user_not_found,
            );
          },
          phoneNumberNotMatch: () {
            showDialog(
              LocaleProvider.current.user_phone_not_match,
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
