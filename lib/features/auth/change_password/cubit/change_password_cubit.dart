import 'package:bloc/bloc.dart';
import '../../../../core/core.dart';
import '../../../../model/shared/user_login_info.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.repository) : super(ChangePasswordState());
  late final Repository repository;

  final PasswordAdvisor passwordAdvisor = PasswordAdvisor();

  void toggleOldPasswordVisibility(bool value) {
    emit(state.copyWith(oldPasswordVisibility: !value));
  }

  void togglePasswordVisibility(bool value) {
    emit(state.copyWith(passwordVisibility: !value));
  }

  void togglePasswordAgainVisibility(bool value) {
    emit(state.copyWith(passwordAgainVisibility: !value));
  }

  void checkPasswordCapability(String newPassword) {
    passwordAdvisor.checkPassword(newPassword);
    emit(
      state.copyWith(
        checkLength: passwordAdvisor.lengthValue,
        checkLowerCase: passwordAdvisor.lowerCaseValue,
        checkNumeric: passwordAdvisor.numericValue,
        checkSpecial: passwordAdvisor.specialValue,
        checkUpperCase: passwordAdvisor.upperCaseValue,
      ),
    );
  }

  Future<void> changePassword({
    required String oldPassword,
    required String password,
    required String passwordAgain,
  }) async {
    if (passwordAgain.isNotEmpty &&
        password.isNotEmpty &&
        oldPassword.isNotEmpty) {
      if (password != passwordAgain) {
        showDialog(
          LocaleProvider.current.warning,
          LocaleProvider.current.pass_must_same,
        );
        return;
      }
    } else {
      showDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.fill_all_field,
      );
      return;
    }

    if (passwordAdvisor.validateStructure()) {
      emit(state.copyWith(showProgressOverlay: true));
      try {
        final response =
            await repository.changeUserPasswordUi(oldPassword, password);
        if (response.isSuccessful == true) {
          UserLoginInfo userLoginInfo =
              getIt<UserManager>().getSavedLoginInfo();
          await getIt<ISharedPreferencesManager>()
              .setString(SharedPreferencesKeys.loginPassword, password);
          bool rememberChecked = userLoginInfo.password != "" ? true : false;
          await getIt<UserManager>().saveLoginInfo(
            userLoginInfo.username ?? '',
            userLoginInfo.password ?? '',
            rememberChecked,
            getIt<ISharedPreferencesManager>()
                    .getString(SharedPreferencesKeys.jwtToken) ??
                '',
          );
          getIt<IAppConfig>()
              .platform
              .adjustManager
              ?.trackEvent(SuccessfulPasswordChangeEvent());
          getIt<FirebaseAnalyticsManager>()
              .logEvent(SifreDegistirBasariliEvent());
          showDialog(
            LocaleProvider.current.success_message_title,
            LocaleProvider.current.succefully_created_pass,
          );
          emit(
            state.copyWith(
              showProgressOverlay: false,
              status: ChangePasswordStatus.done,
              checkLength: false,
              checkLowerCase: false,
              checkNumeric: false,
              checkSpecial: false,
              checkUpperCase: false,
            ),
          );
        } else {
          errorParse(response);
        }
      } catch (error, stackTrace) {
        getIt<IAppConfig>()
            .platform
            .sentryManager
            .captureException(error, stackTrace: stackTrace);
        getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.trackEvent(UnsuccessfulPasswordChangeEvent());
        getIt<FirebaseAnalyticsManager>().logEvent(SifreDegistirmeHataEvent());
        emit(state.copyWith(
            showProgressOverlay: false, status: ChangePasswordStatus.failure));
      }
    }
  }

  void errorParse(GuvenResponseModel response) {
    var errorCode = response.datum;
    if (errorCode is int) {
      getIt<IAppConfig>()
          .platform
          .adjustManager
          ?.trackEvent(UnsuccessfulPasswordChangeEvent());
      getIt<FirebaseAnalyticsManager>().logEvent(SifreDegistirmeHataEvent());
      switch (errorCode) {
        case 1:
          {
            showDialog(
              LocaleProvider.current.warning,
              LocaleProvider.current.error_old_password_wrong,
            );
            break;
          }

        case 2:
          {
            showDialog(
              LocaleProvider.current.warning,
              LocaleProvider.current.error_password_mismatch,
            );
            break;
          }

        case 4:
          {
            showDialog(
              LocaleProvider.current.warning,
              LocaleProvider.current.error_system_malfunction,
            );
            break;
          }

        default:
          {
            showDialog(
              LocaleProvider.current.warning,
              LocaleProvider.current.sorry_dont_transaction,
            );
            break;
          }
      }
    }
  }

  void showDialog(String title, String description) {
    emit(state.copyWith(
      status: ChangePasswordStatus.showDialog,
      dialogMessage: description,
      dialogTitle: title,
      showProgressOverlay: false,
    ));
    Future.delayed(
      const Duration(milliseconds: 250),
      () {
        emit(
          state.copyWith(
            status: ChangePasswordStatus.initial,
            dialogMessage: null,
            dialogTitle: null,
            showProgressOverlay: false,
          ),
        );
      },
    );
  }
}
