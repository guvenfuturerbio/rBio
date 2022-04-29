import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

part '../model/profile_numbers.dart';

class ProfileVm extends RbioVm {
  @override
  BuildContext mContext;
  late bool isTwoFactorAuth;
  ProfileVm(this.mContext) {
    isTwoFactorAuth = getIt<ISharedPreferencesManager>()
            .getBool(SharedPreferencesKeys.isTwoFactorAuth) ??
        false;
  }

  LoadingProgress _state = LoadingProgress.loading;
  LoadingProgress get state => _state;
  set state(LoadingProgress value) {
    _state = value;
    notifyListeners();
  }

  bool _showProgressOverlay = false;
  bool get showProgressOverlay => _showProgressOverlay;
  set showProgressOverlay(bool value) {
    _showProgressOverlay = value;
    notifyListeners();
  }

  ProfileNumbers? numbers;

  Future<void> getNumbers() async {
    try {
      state = LoadingProgress.loading;
      await Future.delayed(const Duration(seconds: 1));
      numbers = ProfileNumbers(relatives: 3, followers: 10, subscriptions: 50);
      state = LoadingProgress.done;
    } catch (e) {
      state = LoadingProgress.error;
    }
  }

  Future<void> logout(BuildContext context) async {
    await getIt<UserNotifier>().logout(context);
  }

  Future<void> update2FA(bool newValue) async {
    showProgressOverlay = true;

    try {
      PatientResponse? patient = await getIt<Repository>().getPatientDetail();
      var pusulaAccount = getIt<UserNotifier>().getPatient();
      if (patient == null || patient.patientType == null) return;
      var changeInfo = ChangeContactInfoRequest();
      changeInfo.gsm = patient.gsm;
      changeInfo.gsmCountryCode = patient.gsmCountryCode;
      changeInfo.email = patient.email;
      changeInfo.patientId = pusulaAccount.id;
      changeInfo.patientType = int.parse(pusulaAccount.patientType!);
      changeInfo.nationalityId = pusulaAccount.nationalityId;
      changeInfo.hasETKApproval = pusulaAccount.hasETKApproval ?? true;
      changeInfo.hasKVKKApproval = pusulaAccount.hasKVKKApproval ?? true;
      changeInfo.isTwoFactorAuth = newValue;

      await getIt<Repository>().updateContactInfo(changeInfo);
      await getIt<ISharedPreferencesManager>().setBool(
        SharedPreferencesKeys.isTwoFactorAuth,
        newValue,
      );
      isTwoFactorAuth = newValue;
    } catch (e, stackTrace) {
      showDefaultErrorDialog(e, stackTrace);
    } finally {
      showProgressOverlay = false;
    }
  }
}
