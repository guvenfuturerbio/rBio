import 'package:bloc/bloc.dart';

import '../../../../core/core.dart';
import '../../shared/shared.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required this.repository,
    required this.userManager,
    required this.adjustManager,
    required this.sentryManager,
    required this.sharedPreferencesManager,
    required this.firebaseAnalyticsManager,
  }) : super(ChangePasswordState());
  late final Repository repository;
  late final UserManager userManager;
  late final AdjustManager? adjustManager;
  late final SentryManager sentryManager;
  late final ISharedPreferencesManager sharedPreferencesManager;
  late final FirebaseAnalyticsManager firebaseAnalyticsManager;

  final PasswordHelper passwordHelper = PasswordHelper();

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

    if (passwordHelper.validateStructure()) {
      emit(state.copyWith(showProgressOverlay: true));

      try {
        final response =
            await repository.changeUserPasswordUi(oldPassword, password);
        if (response.isSuccessful == true) {
          UserLoginInfo userLoginInfo = userManager.getSavedLoginInfo();
          await sharedPreferencesManager.setString(
            SharedPreferencesKeys.loginPassword,
            password,
          );
          bool rememberChecked = userLoginInfo.password != "" ? true : false;
          await userManager.saveLoginInfo(
            userLoginInfo.username ?? '',
            userLoginInfo.password ?? '',
            rememberChecked,
            sharedPreferencesManager
                    .getString(SharedPreferencesKeys.jwtToken) ??
                '',
          );
          adjustManager?.trackEvent(SuccessfulPasswordChangeEvent());
          firebaseAnalyticsManager.logEvent(SifreDegistirBasariliEvent());
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
        sentryManager.captureException(error, stackTrace: stackTrace);
        adjustManager?.trackEvent(UnsuccessfulPasswordChangeEvent());
        firebaseAnalyticsManager.logEvent(SifreDegistirmeHataEvent());
        emit(
          state.copyWith(
            showProgressOverlay: false,
            status: ChangePasswordStatus.failure,
          ),
        );
      }
    }
  }

  void errorParse(GuvenResponseModel response) {
    var errorCode = response.datum;
    if (errorCode is int) {
      adjustManager?.trackEvent(UnsuccessfulPasswordChangeEvent());
      firebaseAnalyticsManager.logEvent(SifreDegistirmeHataEvent());

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
    emit(
      state.copyWith(
        status: ChangePasswordStatus.showDialog,
        dialogMessage: description,
        dialogTitle: title,
        showProgressOverlay: false,
      ),
    );
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
