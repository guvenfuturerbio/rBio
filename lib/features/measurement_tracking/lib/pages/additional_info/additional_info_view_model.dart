import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../helper/resources.dart';
import '../../models/appointment_models/Appointment.dart';
import '../../models/appointment_models/doctor.dart';
import '../../models/user/additional_info_model.dart';
import '../../models/user/country.dart';
import '../../notifiers/user_profiles_notifier.dart';
import '../../services/user_service.dart';
import '../../widgets/gradient_dialog.dart';
import '../../widgets/loading_page.dart';

enum StateProcess { LOADING, ERROR, DONE }

class AdditionalInfoViewModel extends ChangeNotifier {
  List<Country> _countryList;
  StateProcess _stateProcess;
  List<Country> _filteredCountryList;
  String _nationalityCode;
  String _phoneCountryCode;
  BuildContext context;
  Doctor doctor;
  Appointment appointment;
  LoadingPage progressDialog;
  AdditionalInfoViewModel(
      {BuildContext context, Doctor doctor, Appointment appointment}) {
    this.context = context;
    this.doctor = doctor;
    this.appointment = appointment;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      fetchAllCountry();
    });
  }

  Future<void> fetchAllCountry() async {
    _stateProcess = StateProcess.LOADING;
    notifyListeners();
    try {
      this._countryList = await UserService().getAllCountry();
      _stateProcess = StateProcess.DONE;
      notifyListeners();
    } catch (e) {
      _stateProcess = StateProcess.ERROR;
      notifyListeners();
    }
  }

  List<Country> filterCountryList(String text) {
    List<Country> filteredCountry = [];
    for (var data in countryList) {
      if (("+" + data.phoneCode).contains(text)) {
        filteredCountry.add(data);
      }
    }
    return filteredCountry;
  }

  Future<void> addAdditionalInformation(
      String identification, String phone) async {
    if (checkRequiredField(identification, phone)) {
      showLoadingDialog();
      await Future.delayed(Duration(milliseconds: 300));
      this._stateProcess = StateProcess.LOADING;
      notifyListeners();
      try {
        await UserService().addAdditionalInfo(
            AdditionalInfoModel(
                country: nationalityCode,
                identificationNumber: identification,
                phoneNumber: phoneCountryCode + phone),
            UserProfilesNotifier().selection.id);
        this._stateProcess = StateProcess.DONE;
        hideDialog(context);
        Navigator.pushNamed(context, Routes.CREDIT_CARD,
            arguments: [appointment, doctor]);
        notifyListeners();
      } catch (e) {
        this._stateProcess = StateProcess.ERROR;
        hideDialog(context);
        showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
        notifyListeners();
      }
    } else {
      showInformationDialog(LocaleProvider.current.fill_all_field);
    }
  }

  List<Country> get filteredCountryList => this._filteredCountryList;

  List<Country> get countryList => this._countryList;

  StateProcess get stateProcess => this._stateProcess;

  setNationalityCode(String text) {
    this._nationalityCode = text;
    notifyListeners();
  }

  String get nationalityCode => this._nationalityCode ?? "TR";

  setPhoneCountryCode(String text) {
    this._phoneCountryCode = text;
    notifyListeners();
  }

  String get phoneCountryCode => this._phoneCountryCode ?? "+90";

  checkRequiredField(String identificationNumber, String phoneNumber) {
    bool isValid = false;
    if (identificationNumber.trim().length > 0) {
      if (phoneNumber.trim().length > 0) {
        isValid = true;
      }
    }
    return isValid;
  }

  showInformationDialog(String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        });
  }

  showLoadingDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            progressDialog = progressDialog ?? LoadingPage(""));
  }

  hideDialog(BuildContext context) {
    if (progressDialog != null && progressDialog.isShowing()) {
      Navigator.of(context).pop();
      progressDialog = null;
    }
  }
}
