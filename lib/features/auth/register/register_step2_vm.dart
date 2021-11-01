import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

class RegisterStep2ScreenVm with ChangeNotifier {
  BuildContext context;
  LoadingDialog loadingDialog;
  CountryListResponse countryList;
  DateTime selectedDate;
  bool _checkLowerCase;
  bool _checkNumeric;
  bool _checkSpecial;
  bool _checkUpperCase;
  bool _checkLength;

  RegisterStep2ScreenVm(this.context) {}

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

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
  }

  get checkLowerCase => this._checkLowerCase ?? false;

  get checkUpperCase => this._checkUpperCase ?? false;

  get checkNumeric => this._checkNumeric ?? false;

  get checkSpecial => this._checkSpecial ?? false;

  get checkLength => this._checkLength ?? false;

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
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
}
