import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart' as masked;

import '../../../core/core.dart';
import '../../../model/model.dart';

class ForgotPasswordStep1ScreenVm extends ChangeNotifier {
  BuildContext mContext;

  final focus = FocusNode();
  LoadingDialog loadingDialog;
  final TextEditingController _tcIdentity = new TextEditingController();
  final masked.MaskedTextController _tcPhoneNumber =
      masked.MaskedTextController(mask: '(000) 000-0000');
  final TextEditingController _fnPassport = new TextEditingController();
  final TextEditingController _fnPhone = new TextEditingController();

  final tcNoFNode = FocusNode();
  final phoneNumberFNode = FocusNode();
  final ftcNoFNode = FocusNode();
  final fphoneNumberFNode = FocusNode();

  TextEditingController get tcIdentity => this._tcIdentity;
  TextEditingController get fnPassport => this._fnPassport;
  TextEditingController get fnPhone => this._fnPhone;
  masked.MaskedTextController get tcPhoneNumber => this._tcPhoneNumber;

  ForgotPasswordStep1ScreenVm({
    BuildContext context,
  }) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  void forgotPassStep1(UserRegistrationStep1Model userRegistrationStep1) async {
    try {
      showLoadingDialog(this.mContext);
      notifyListeners();
      await getIt<Repository>().forgotPasswordUi(userRegistrationStep1);
      await Future.delayed(Duration(milliseconds: 500));
      hideDialog(this.mContext);
      Atom.to(PagePaths.FORGOT_PASSWORD_STEP_2, queryParameters: {
        'identityNumber': userRegistrationStep1.identificationNumber,
      });

      notifyListeners();
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
        notifyListeners();
      });
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
