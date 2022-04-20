import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../shared/consent_form/consent_form_dialog.dart';
import '../auth.dart';

class RegisterStep2ScreenVm extends RbioVm {
  @override
  BuildContext mContext;
  RegisterStep2ScreenVm(this.mContext) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      fetchConsentFormState();
    });
  }

  late bool isWithOutTCKN;
  String textFromPass = '';
  String textFromPassAgain = '';

  DateTime? selectedDate;
  bool isTcCitizen = true;
  LoadingDialog? loadingDialog;

  bool _clickedGeneralForm = false;
  bool get clickedGeneralForm => _clickedGeneralForm;

  bool passwordFetcher(String fromPwController) {
    textFromPass = fromPwController;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&.*~-]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(fromPwController);
  }

  void passwordAgainFetcher(String fromPwAgainController) {
    textFromPassAgain = fromPwAgainController;
  }

  Future<void> selectDate(BuildContext context) async {
    selectedDate ??= DateTime.now();

    final DateTime? picked = await showRbioDatePicker(
      context,
      title: LocaleProvider.of(context).select_birth_date,
      initialDateTime: selectedDate!,
      maximumDate: DateTime.now(),
      minimumDate: DateTime(1900),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    notifyListeners();
  }

  Future<void> registerStep1(
    AddStep1Model userRegistrationStep1,
    UserRegistrationStep1Model registerStep1Model,
  ) async {
    try {
      showLoadingDialog(mContext);
      late GuvenResponseModel response;
      if ((userRegistrationStep1.identityNumber ?? '').trim().isEmpty &&
          (registerStep1Model.identificationNumber ?? '').trim().isEmpty) {
        // isWithOutTCKN = true;
        // response = await getIt<Repository>().registerStep1WithOutTc(registerStep1Model);
      } else {
        isWithOutTCKN = false;
        response = await getIt<Repository>().addStep1(userRegistrationStep1);
      }

      hideDialog(mContext);

      if (response.datum == 18) {
        UserRegistrationStep2Model userRegisterStep2 =
            UserRegistrationStep2Model();
        userRegisterStep2.userRegistrationStep1 = registerStep1Model;
        userRegisterStep2.password = textFromPass;
        userRegisterStep2.repassword = textFromPassAgain;

        // Burada old modele dönüştürülmeyecek ikinci bir model oluşturuyoruz.
        UserRegistrationStep2Model userRegisterStep2Model =
            UserRegistrationStep2Model();
        userRegisterStep2Model.userRegistrationStep1 = registerStep1Model;
        userRegisterStep2Model.password = textFromPass;
        userRegisterStep2Model.repassword = textFromPassAgain;

        if (textFromPass.isNotEmpty && textFromPassAgain.isNotEmpty) {
          registerStep2(
            userRegisterStep2,
            userRegisterStep2Model,
            isWithOutTCKN,
          );
        } else {
          showInfoDialog(
            LocaleProvider.of(mContext).warning,
            LocaleProvider.of(mContext).fill_all_field,
          );
        }
      } else {
        final datumError = response.datum is Map<String, dynamic>;
        if (datumError) {
          if (response.datum["error"] == R.apiEnums.register.kpsError) {
            // TCKimlikNo, Ad, Soyad veya Doğum Yılı hatası
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.current.wrong_tc_number,
            );
          } else if (response.datum["error"] ==
              R.apiEnums.register.unexpectedRegisterFlow) {
            // Üzgünüz uyarısı
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.current.sorry_dont_transaction,
            );
          }
        } else {
          if (response.datum == R.apiEnums.register.userExistOnProile) {
            // Kimlik bilgileri bir hesaba bağlı olarak zaten mevcuttur
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.of(mContext).credential_already_exist,
            );
          } else {
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.current.sorry_dont_transaction,
            );
          }
        }
      }
    } on RbioNotSuccessfulException catch (e) {
      hideDialog(mContext);
      showInfoDialog(
        LocaleProvider.of(mContext).warning,
        e.xGetMessage,
      );
    } catch (error, stackTrace) {
      showDelayedErrorDialog(
        error,
        stackTrace,
        () => hideDialog(mContext),
      );
    } finally {
      notifyListeners();
    }
  }

  void fetchConsentFormState() {
    _clickedGeneralForm = getIt<UserManager>().getApplicationConsentFormState();
    notifyListeners();
  }

  void toggleGeneralFormClick() {
    _clickedGeneralForm = !clickedGeneralForm;
    if (clickedGeneralForm) {}
    notifyListeners();
  }

  void showApplicationContestForm() {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ConsentFormDialog(
          title: LocaleProvider.current.approve_consent_form,
          text: LocaleProvider.current.application_consent_form_text,
          alwaysAsk: false,
        );
      },
    ).then(
      (value) async {
        if (value != null && value) {
          _clickedGeneralForm = true;
          notifyListeners();
        } else if (value != null && !value) {
          _clickedGeneralForm = false;
          notifyListeners();
        }
      },
    );
  }

  void registerStep2(
    UserRegistrationStep2Model userRegistrationStep2,
    UserRegistrationStep2Model userRegistrationStep2Model,
    bool isWithoutTCKN,
  ) async {
    final checkValue = isWithoutTCKN
        ? userRegistrationStep2Model.password
        : userRegistrationStep2.password;

    if (checkPasswordCapabilityForAll(checkValue ?? '')) {
      try {
        showLoadingDialog(mContext);
        GuvenResponseModel? response;
        if (isWithoutTCKN) {
          // response = await getIt<Repository>().registerStep2WithOutTc(userRegistrationStep2Model);
        } else {
          response = await getIt<Repository>().addStep2(userRegistrationStep2);
        }

        hideDialog(mContext);
        if (response?.isSuccessful == true) {
          if (response?.datum == R.apiEnums.register.step2PasswordPass) {
            Atom.to(
              PagePaths.registerStep3,
              queryParameters: {
                'isWithoutTCKN': isWithoutTCKN.toString(),
                'userRegistrationStep2Model':
                    jsonEncode(userRegistrationStep2Model.toJson())
              },
            );
          } else {
            showInfoDialog(
              LocaleProvider.of(mContext).warning,
              LocaleProvider.current.sorry_dont_transaction,
            );
          }
        } else {
          showInfoDialog(
            LocaleProvider.of(mContext).warning,
            response?.message.toString() ?? '',
          );
        }
      } catch (error, stackTrace) {
        showDelayedErrorDialog(
          error,
          stackTrace,
          () => hideDialog(mContext),
        );
      }
    } else {
      showInfoDialog(
        LocaleProvider.of(mContext).warning,
        LocaleProvider.current.password_wrong,
      );
    }
  }

  bool checkPasswordCapabilityForAll(String password) {
    return PasswordAdvisor().validateStructureByPattern(password);
  }

  void toggleCitizen() {
    isTcCitizen = !isTcCitizen;
    notifyListeners();
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null) {
      if (loadingDialog!.isShowing()) {
        Navigator.of(context).pop();
        loadingDialog = null;
      }
    }
  }
}
