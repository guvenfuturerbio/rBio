import 'package:flutter/material.dart';

import '../auth.dart';
import '../../../core/core.dart';
import '../../../model/model.dart';

class ForgotPasswordStep2ScreenVm extends ChangeNotifier {
  BuildContext mContext;
  final focus = FocusNode();
  LoadingDialog loadingDialog;
  final TextEditingController _temporaryController =
      new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _passwordAgainController =
      new TextEditingController();

  bool _checkLowerCase;
  bool _checkNumeric;
  bool _checkSpecial;
  bool _checkUpperCase;
  bool _checkLength;
  TextEditingController get temporaryController => this._temporaryController;

  TextEditingController get passwordController => this._passwordController;

  TextEditingController get passwordAgainController =>
      this._passwordAgainController;

  bool _passwordVisibility;

  ForgotPasswordStep2ScreenVm({
    BuildContext context,
  }) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  bool get passwordVisibility => this._passwordVisibility ?? false;

  get checkLowerCase => this._checkLowerCase ?? false;

  get checkUpperCase => this._checkUpperCase ?? false;

  get checkNumeric => this._checkNumeric ?? false;

  get checkSpecial => this._checkSpecial ?? false;

  get checkLength => this._checkLength ?? false;

  checkPasswordCapability(String password) {
    this._checkLowerCase = PasswordAdvisor().checkLowercase(password);
    this._checkUpperCase = PasswordAdvisor().checkUpperCase(password);
    this._checkSpecial = PasswordAdvisor().checkSpecialCharacter(password);
    this._checkNumeric = PasswordAdvisor().checkNumberInclude(password);
    this._checkLength = PasswordAdvisor().checkRequiredPasswordLength(password);
    notifyListeners();
  }

  togglePasswordVisibility() {
    this._passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  checkPasswordCapabilityForAll(String password) {
    return PasswordAdvisor().validateStructure(password);
  }

  void forgotPassStep2(ChangePasswordModel changePasswordModel) async {
    try {
      if (checkPasswordCapabilityForAll(changePasswordModel.newPassword)) {
        showLoadingDialog(this.mContext);
        notifyListeners();

        final response =
            await getIt<Repository>().changePasswordUi(changePasswordModel);
        await Future.delayed(Duration(milliseconds: 300));
        hideDialog(this.mContext);
        if (response.isSuccessful == true) {
          showGradientDialog(
              this.mContext,
              LocaleProvider.of(this.mContext).success_message_title,
              LocaleProvider.of(this.mContext).succefully_created_pass);
        } else {
          if (response.datum == 1) {
            showGradientDialog(
                this.mContext,
                LocaleProvider.of(this.mContext).warning,
                LocaleProvider.of(this.mContext).wrong_temporary_pass);
          } else if (response.datum == 2) {
            showGradientDialog(
                this.mContext,
                LocaleProvider.of(this.mContext).warning,
                LocaleProvider.of(this.mContext).pass_must_same);
          } else if (response.datum == 4) {
            showGradientDialog(
                this.mContext,
                LocaleProvider.of(this.mContext).warning,
                LocaleProvider.of(this.mContext).sorry_dont_transaction);
          }
        }

        notifyListeners();
      }
    } catch (error) {
      Future.delayed(const Duration(milliseconds: 500), () {
        print(error);
        hideDialog(this.mContext);
        showGradientDialog(
            this.mContext,
            LocaleProvider.of(this.mContext).warning,
            error.toString() == "network"
                ? LocaleProvider.of(this.mContext).no_network_connection
                : LocaleProvider.of(this.mContext).sorry_dont_transaction);
      });
      notifyListeners();
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

  void showLoadingDialog(BuildContext context) async {
    await new Future.delayed(new Duration(milliseconds: 30));
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
    notifyListeners();
    //builder: (BuildContext context) => WillPopScope(child:loadingDialog = LoadingDialog() , onWillPop:  () async => false,));
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }
}
