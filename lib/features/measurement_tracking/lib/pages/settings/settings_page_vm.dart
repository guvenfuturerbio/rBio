import 'package:flutter/material.dart';
import 'package:onedosehealth/notifiers/language_notifiers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../database/repository/profile_repository.dart';
import '../../doctor/utils/progress/progress_dialog.dart';
import '../../generated/l10n.dart';
import '../../helper/resources.dart';
import '../../models/user_profiles/person.dart';
import '../../services/user_service.dart';
import '../../widgets/gradient_dialog.dart';
import '../ble_device_connection/ble_reactive_singleton.dart';
import '../signup&login/login_page/login_page.dart';

class SettingPageVm extends ChangeNotifier {
  final BuildContext mContext;
  ProgressDialog progressDialog;
  bool isLoading = false;
  String errorText = '';

  SettingPageVm({this.mContext}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoadingDialog();
      ProfileRepository().addListener(() {
        print('heyoooo');
        updateProfile();
      });

      await getProfiles();
    });
  }

  List<Person> personList = [ProfileRepository().activeProfile];
  Person selectedPerson = ProfileRepository().activeProfile;

  getProfiles() async {
    try {
      updateProfile();
      hideDialog();
      print('helkjfdşgjfghlkdfg');
      notifyListeners();
    } catch (e) {
      hideDialog();
      showInformationDialog('${LocaleProvider.current.sorry_dont_transaction}');
    }
  }

  updateProfile() async {
    personList = await ProfileRepository().getAllProfiles();
    selectedPerson = personList[0];
    notifyListeners();
  }

  void changeCountryCode(String locale) async {
    var prov = Provider.of<AppLanguage>(mContext, listen: false);
    prov.changeLanguage(locale);

    notifyListeners();
  }

  //dialog Section
  showLoadingDialog() {
    isLoading = true;

    showDialog(
        context: mContext,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            progressDialog = progressDialog ?? ProgressDialog());
    notifyListeners();
  }

  hideDialog() {
    if (isLoading) {
      isLoading = false;

      Navigator.of(mContext).pop('dialog');

      notifyListeners();
    }
  }

  Future showInformationDialog(String text) async {
    isLoading = false;
    errorText = '${LocaleProvider.current.we_have_an_error}';
    notifyListeners();
    await showDialog(
        context: mContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        });
  }

  logOut() async {
    await BLEHandler().stopScan();
    UserService().signOut();
    await ProfileRepository().deleteAllProfiles();

    await UserService().deleteInformationForAutoLogin();

    Navigator.of(mContext).pushAndRemoveUntil(
      MaterialPageRoute(builder: (contextTrans) => LoginPage()),
      ModalRoute.withName(Routes.LOGIN_PAGE),
    );
    notifyListeners();
  }
}
