import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
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

  void passwordFetcher(String fromPwController) {
    textFromPass = fromPwController;
  }

  void passwordAgainFetcher(String fromPwAgainController) {
    textFromPassAgain = fromPwAgainController;
  }

  Future<void> selectDate(BuildContext context) async {
    selectedDate ??= DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(selectedDate!.year - 150),
      lastDate: DateTime(selectedDate!.year + 1),
      helpText:
          LocaleProvider.of(context).select_birth_date, // Can be used as title
      cancelText: LocaleProvider.of(context).btn_cancel,
      confirmText: LocaleProvider.of(context).btn_confirm,
      // locale: new Locale(Intl.getCurrentLocale().toLowerCase()),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: getIt<ITheme>().secondaryColor,
            accentColor: getIt<ITheme>().mainColor,
            colorScheme: ColorScheme.light(
              primary: getIt<ITheme>().mainColor,
            ),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    notifyListeners();
  }

  Future<void> registerStep1(
    RegisterStep1PusulaModel userRegistrationStep1,
    UserRegistrationStep1Model registerStep1Model,
  ) async {
    try {
      showLoadingDialog(mContext);
      GuvenResponseModel response;
      if ((userRegistrationStep1.identityNumber ?? '').trim().isEmpty ||
          (registerStep1Model.identificationNumber ?? '').trim().isEmpty) {
        isWithOutTCKN = true;
        response = await getIt<Repository>()
            .registerStep1WithOutTc(registerStep1Model);
      } else {
        isWithOutTCKN = false;
        response =
            await getIt<Repository>().registerStep1Ui(userRegistrationStep1);
      }

      hideDialog(mContext);
      if (response.datum == 18 ||
          response.datum == 19 ||
          response.datum == 21 ||
          response.datum == 1 ||
          response.datum == 3) {
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
      } else if (response.datum == 5 || response.datum == 2) {
        showInfoDialog(
          LocaleProvider.of(mContext).warning,
          "TC Kimlik numarası hatalı",
        );
      } else if (response.datum == 4) {
        showInfoDialog(
          LocaleProvider.of(mContext).warning,
          LocaleProvider.of(mContext).already_registered_mail,
        );
      } else if (response.datum == 15) {
        showInfoDialog(
          LocaleProvider.of(mContext).warning,
          LocaleProvider.of(mContext).already_registered_phone,
        );
      } else if (response.datum == 16) {
        showInfoDialog(
          LocaleProvider.of(mContext).warning,
          LocaleProvider.of(mContext).credential_already_exist,
        );
      } else {
        showInfoDialog(
          LocaleProvider.of(mContext).warning,
          response.message.toString(),
        );
      }
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
    if (checkPasswordCapabilityForAll((isWithoutTCKN
            ? userRegistrationStep2Model.password
            : userRegistrationStep2.password) ??
        '')) {
      try {
        showLoadingDialog(mContext);
        GuvenResponseModel response;
        if (isWithoutTCKN) {
          response = await getIt<Repository>()
              .registerStep2WithOutTc(userRegistrationStep2Model);
        } else {
          response =
              await getIt<Repository>().registerStep2Ui(userRegistrationStep2);
        }

        hideDialog(mContext);
        if (response.isSuccessful == true) {
          if (response.datum == 6) {
            Atom.to(
              PagePaths.registerStep3,
              queryParameters: {
                'isWithoutTCKN': isWithoutTCKN.toString(),
                'userRegistrationStep2Model':
                    jsonEncode(userRegistrationStep2Model.toJson())
              },
            );
          }
        } else {
          showInfoDialog(
            LocaleProvider.of(mContext).warning,
            response.message.toString(),
          );
        }
      } catch (error, stackTrace) {
        showDelayedErrorDialog(
          error,
          stackTrace,
          () => hideDialog(mContext),
        );
      }
    }
  }

  bool checkPasswordCapabilityForAll(String password) =>
      PasswordAdvisor().validateStructureByPattern(password);

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
