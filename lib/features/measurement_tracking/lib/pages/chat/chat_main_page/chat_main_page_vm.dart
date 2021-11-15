import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/doctor/utils/progress/progress_dialog.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/notifiers/user_profiles_notifier.dart';
import 'package:onedosehealth/pages/additional_info/additional_info_view_model.dart';
import 'package:onedosehealth/services/user_service.dart';
import 'package:onedosehealth/widgets/gradient_dialog.dart';

import '../chat_person.dart';

class ChatMainPageVm extends ChangeNotifier {
  List<ChatPerson> _myChatList;
  BuildContext mContext;
  ProgressDialog progressDialog;
  StateProcess _stateProcess;
  ChatMainPageVm({BuildContext context}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchMyChatList();
    });
  }

  List<ChatPerson> get myChatList => this._myChatList;

  StateProcess get stateProcess => this._stateProcess;

  fetchMyChatList() async {
    showLoadingDialog();
    this._stateProcess = StateProcess.LOADING;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 500));
    try {
      this._myChatList = await UserService()
          .getDoctorData(UserProfilesNotifier().selection.id);
      this._stateProcess = StateProcess.DONE;
      notifyListeners();
      hideDialog(mContext);
    } catch (e) {
      print(e.toString());
      this._stateProcess = StateProcess.ERROR;
      notifyListeners();
      hideDialog(mContext);
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
    }
  }

  showLoadingDialog() {
    showDialog(
        context: mContext,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            progressDialog = progressDialog ?? ProgressDialog());
  }

  hideDialog(BuildContext context) {
    if (progressDialog != null && progressDialog.isShowing()) {
      Navigator.of(context).pop();
      progressDialog = null;
    }
  }

  showInformationDialog(String text) {
    showDialog(
        context: mContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.of(mContext).warning, text);
        });
  }
}
