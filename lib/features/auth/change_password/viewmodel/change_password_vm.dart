import 'package:flutter/material.dart';


import '../../../../core/core.dart';
import '../../../../model/shared/user_login_info.dart';

class ChangePasswordScreenVm extends RbioVm {
  @override
  BuildContext mContext;
  ChangePasswordScreenVm(this.mContext);

  bool _showProgressOverlay = false;
  bool get showProgressOverlay => _showProgressOverlay;
  set showProgressOverlay(bool value) {
    _showProgressOverlay = value;
    notifyListeners();
  }

  bool oldPasswordVisibility = false;
  void toggleOldPasswordVisibility() {
    oldPasswordVisibility = !oldPasswordVisibility;
    notifyListeners();
  }

  bool passwordVisibility = false;
  void togglePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  bool passwordAgainVisibility = false;
  void togglePasswordAgainVisibility() {
    passwordAgainVisibility = !passwordAgainVisibility;
    notifyListeners();
  }

  final PasswordAdvisor passwordAdvisor = PasswordAdvisor();

  bool get checkLowerCase => passwordAdvisor.lowerCaseValue;
  bool get checkUpperCase => passwordAdvisor.upperCaseValue;
  bool get checkNumeric => passwordAdvisor.numericValue;
  bool get checkSpecial => passwordAdvisor.specialValue;
  bool get checkLength => passwordAdvisor.lengthValue;

  void checkPasswordCapability(String newPassword) {
    passwordAdvisor.checkPassword(newPassword);
    notifyListeners();
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
        showInfoDialog(
          LocaleProvider.of(mContext).warning,
          LocaleProvider.of(mContext).pass_must_same,
        );
        return;
      }
    } else {
      showInfoDialog(
        LocaleProvider.of(mContext).warning,
        LocaleProvider.of(mContext).fill_all_field,
      );
      return;
    }

    if (passwordAdvisor.validateStructure()) {
      try {
        showProgressOverlay = true;
        final response = await getIt<Repository>()
            .changeUserPasswordUi(oldPassword, password);
        showProgressOverlay = false;

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
          getIt<AdjustManager>().trackEvent(SuccessfulPasswordChangeEvent());
          getIt<FirebaseAnalyticsManager>()
              .logEvent(SifreDegistirBasariliEvent());
          showInfoDialog(
            LocaleProvider.of(mContext).success_message_title,
            LocaleProvider.of(mContext).succefully_created_pass,
          );
        } else {
          errorParse(response);
        }
      } catch (error, stackTrace) {
        getIt<AdjustManager>().trackEvent(UnsuccessfulPasswordChangeEvent());
        getIt<FirebaseAnalyticsManager>().logEvent(SifreDegistirmeHataEvent());
        showDelayedErrorDialog(error, stackTrace);
      } finally {
        showProgressOverlay = false;
      }
    }
  }

  void errorParse(GuvenResponseModel response) {
    var errorCode = response.datum;
    if (errorCode is int) {
      getIt<AdjustManager>().trackEvent(UnsuccessfulPasswordChangeEvent());
      getIt<FirebaseAnalyticsManager>().logEvent(SifreDegistirmeHataEvent());
      switch (errorCode) {
        case 1:
          {
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.of(mContext).error_old_password_wrong,
            );
            break;
          }

        case 2:
          {
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.of(mContext).error_password_mismatch,
            );
            break;
          }

        case 4:
          {
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.of(mContext).error_system_malfunction,
            );
            break;
          }

        default:
          {
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.of(mContext).sorry_dont_transaction,
            );
            break;
          }
      }
    }
  }
}
