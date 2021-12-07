import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/consent_form/consent_form_dialog.dart';
import '../../shared/kvkk_form/kvkk_form_screen.dart';

import '../auth.dart';
import '../../../core/core.dart';
import '../../../model/model.dart';

class RegisterStep2ScreenVm with ChangeNotifier {
  BuildContext context;
  LoadingDialog loadingDialog;
  CountryListResponse countryList;
  DateTime selectedDate;
  bool isWithOutTCKN;
  bool _clickedGeneralForm;

  bool _checkLowerCase;
  bool _checkNumeric;
  bool _checkSpecial;
  bool _checkUpperCase;
  bool _checkLength;
  bool isTcCitizen = true;

  //
  String textFromPassController;
  String textFromPassAgainController;

  RegisterStep2ScreenVm(this.context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchConsentFormState();
    });
  }

  bool get clickedGeneralForm => this._clickedGeneralForm ?? false;

  void passwordFetcher(String fromPwController) {
    textFromPassController = fromPwController;
  }

  void passwordAgainFetcher(String fromPwAgainController) {
    textFromPassAgainController = fromPwAgainController;
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
    //builder: (BuildContext context) => WillPopScope(child:loadingDialog = LoadingDialog() , onWillPop:  () async => false,));
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  Future<void> getCountries() async {
    try {
      showLoadingDialog(context);
      final response = await getIt<Repository>().getCountries();
      countryList = CountryListResponse.fromMap(response.toJson());
      notifyListeners();
      hideDialog(context);
    } catch (error) {
      //
    }
  }

  Future<void> selectDate(BuildContext context) async {
    if (selectedDate == null) {
      selectedDate = DateTime.now();
    }

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(selectedDate.year - 150),
        lastDate: DateTime(selectedDate.year + 1),
        helpText: LocaleProvider.of(context)
            .select_birth_date, // Can be used as title
        cancelText: LocaleProvider.of(context).btn_cancel,
        confirmText: LocaleProvider.of(context).btn_confirm,
        locale: new Locale(Intl.getCurrentLocale().toLowerCase()),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: getIt<ITheme>().secondaryColor,
              accentColor: getIt<ITheme>().mainColor,
              colorScheme: ColorScheme.light(
                primary: getIt<ITheme>().mainColor,
              ),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ), // This will change to light theme.
            child: child,
          );
        });
    if (picked != null && picked != selectedDate) selectedDate = picked;
    notifyListeners();
  }

  Future<void> registerStep1(RegisterStep1PusulaModel userRegistrationStep1,
      UserRegistrationStep1Model registerStep1Model) async {
    try {
      showLoadingDialog(context);
      GuvenResponseModel response;
      if (userRegistrationStep1.identityNumber.trim().isEmpty ||
          registerStep1Model.identificationNumber.trim().isEmpty) {
        isWithOutTCKN = true;
        response = await getIt<Repository>()
            .registerStep1WithOutTc(registerStep1Model);
      } else {
        isWithOutTCKN = false;
        response =
            await getIt<Repository>().registerStep1Ui(userRegistrationStep1);
      }

      hideDialog(context);
      if (response.datum == 18 ||
          response.datum == 19 ||
          response.datum == 21 ||
          response.datum == 1 ||
          response.datum == 3) {
        UserRegistrationStep2Model userRegisterStep2 =
            UserRegistrationStep2Model();
        userRegisterStep2.userRegistrationStep1 = registerStep1Model;
        userRegisterStep2.password = textFromPassController;
        userRegisterStep2.repassword = textFromPassAgainController;

        // Burada old modele dönüştürülmeyecek ikinci bir model oluşturuyoruz.
        UserRegistrationStep2Model userRegisterStep2Model =
            UserRegistrationStep2Model();
        userRegisterStep2Model.userRegistrationStep1 = registerStep1Model;
        userRegisterStep2Model.password = textFromPassController;
        userRegisterStep2Model.repassword = textFromPassAgainController;

        if (textFromPassController.length > 0 &&
            textFromPassAgainController.length > 0) {
          registerStep2(
            userRegisterStep2,
            userRegisterStep2Model,
            isWithOutTCKN,
          );
        } else {
          showGradientDialog(
            context,
            LocaleProvider.of(context).warning,
            LocaleProvider.of(context).fill_all_field,
          );
        }
      } else if (response.datum == 5 || response.datum == 2) {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            "TC Kimlik numarası hatalı");
      } else if (response.datum == 4) {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            LocaleProvider.of(context).already_registered_mail);
      } else if (response.datum == 15) {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            LocaleProvider.of(context).already_registered_phone);
      } else if (response.datum == 16) {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            LocaleProvider.of(context).credential_already_exist);
      } else {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            response.message.toString());
        AnalyticsManager()
            .sendEvent(new RegisterStep1FailEvent("Register1 User TC", 22));
      }
    } catch (error) {
      Future.delayed(const Duration(milliseconds: 500), () {
        AnalyticsManager()
            .sendEvent(new RegisterStep1FailEvent("Register1 User TC", 22));
        print(error);
        hideDialog(context);
        showGradientDialog(
            context,
            LocaleProvider.of(context).warning,
            error.toString() == "network"
                ? LocaleProvider.of(context).no_network_connection
                : LocaleProvider.of(context).sorry_dont_transaction);
      });
    }
  }

  fetchConsentFormState() async {
    this._clickedGeneralForm =
        await getIt<UserManager>().getApplicationConsentFormState();
    notifyListeners();
  }

  toggleGeneralFormClick() {
    this._clickedGeneralForm = !clickedGeneralForm;
    if (clickedGeneralForm) {}
    notifyListeners();
  }

  showApplicationContestForm() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ConsentFormDialog(
            title: LocaleProvider.current.approve_consent_form,
            text: LocaleProvider.current.application_consent_form_text,
            alwaysAsk: false,
          );
        }).then((value) async {
      if (value != null && value) {
        this._clickedGeneralForm = true;
        notifyListeners();
      } else if (value != null && !value) {
        this._clickedGeneralForm = false;
        notifyListeners();
      }
    });
  }

  //

  void registerStep2(
    UserRegistrationStep2Model userRegistrationStep2,
    UserRegistrationStep2Model userRegistrationStep2Model,
    bool isWithoutTCKN,
  ) async {
    if (checkPasswordCapabilityForAll(isWithoutTCKN
        ? userRegistrationStep2Model.password
        : userRegistrationStep2.password)) {
      try {
        showLoadingDialog(context);
        GuvenResponseModel response;
        if (isWithoutTCKN) {
          response = await getIt<Repository>()
              .registerStep2WithOutTc(userRegistrationStep2Model);
        } else {
          response =
              await getIt<Repository>().registerStep2Ui(userRegistrationStep2);
        }

        hideDialog(context);
        if (response.isSuccessful == true) {
          if (response.datum == 6) {
            Atom.to(
              PagePaths.REGISTER_STEP_3,
              queryParameters: {
                'isWithoutTCKN': isWithoutTCKN.toString(),
                'userRegistrationStep2Model':
                    jsonEncode(userRegistrationStep2Model.toJson())
              },
            );
          }
        } else {
          showGradientDialog(
            context,
            LocaleProvider.of(context).warning,
            response.message.toString(),
          );
        }
      } catch (error) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            print(error);
            hideDialog(context);
            showGradientDialog(
                context,
                LocaleProvider.of(context).warning,
                error.toString() == "network"
                    ? LocaleProvider.of(context).no_network_connection
                    : LocaleProvider.of(context).sorry_dont_transaction);
          },
        );
      }
    }
  }

  get checkLowerCase => this._checkLowerCase ?? false;

  get checkUpperCase => this._checkUpperCase ?? false;

  get checkNumeric => this._checkNumeric ?? false;

  get checkSpecial => this._checkSpecial ?? false;

  get checkLength => this._checkLength ?? false;

  void checkPasswordCapability(String password) {
    this._checkLowerCase = PasswordAdvisor().checkLowercase(password);
    this._checkUpperCase = PasswordAdvisor().checkUpperCase(password);
    this._checkSpecial = PasswordAdvisor().checkSpecialCharacter(password);
    this._checkNumeric = PasswordAdvisor().checkNumberInclude(password);
    this._checkLength = PasswordAdvisor().checkRequiredPasswordLength(password);
    notifyListeners();
  }

  bool checkPasswordCapabilityForAll(String password) =>
      PasswordAdvisor().validateStructure(password);

  void toggleCitizen() {
    isTcCitizen = !isTcCitizen;
    notifyListeners();
  }
}
