import 'dart:convert';

import '../data/repository/repository.dart';
import '../enums/shared_preferences_keys.dart';
import '../locator.dart';
import '../manager/shared_preferences_manager.dart';
import '../../model/shared/user_account_info.dart';

class UserInfo {
  final ISharedPreferencesManager sharedPreferencesManager;
  UserInfo(this.sharedPreferencesManager);

  Future<void> setUserAccount(UserAccount userAccount) async {
    bool _canAccessHospitalOps;

    if (userAccount.nationality == "TC") {
      if (userAccount.identificationNumber.isNotEmpty &&
          userAccount.identificationNumber != null) {
        _canAccessHospitalOps = true;
      }
    } else {
      if (userAccount.passaportNumber.isNotEmpty &&
          userAccount.passaportNumber != null) {
        _canAccessHospitalOps = true;
      }
    }

    await sharedPreferencesManager.setString(
        SharedPreferencesKeys.USERACCOUNT, jsonEncode(userAccount.toJson()));
    await sharedPreferencesManager.setBool(
        SharedPreferencesKeys.CANACCESSHOSPITALOPS, _canAccessHospitalOps);
  }

  UserAccount getUserAccount() {
    final userAccountStr =
        sharedPreferencesManager.getString(SharedPreferencesKeys.USERACCOUNT);
    if (userAccountStr != null) {
      final model = UserAccount.fromJson(jsonDecode(userAccountStr));
      return model;
    }

    return null;
  }

  Future<bool> checkAccessToken() async {
    final jwtToken =
        sharedPreferencesManager.getString(SharedPreferencesKeys.JWT_TOKEN);
    if (jwtToken == null) {
      return false;
    }

    var response = await getIt<Repository>().getPatientDetail();
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  bool canAccessHospital() => sharedPreferencesManager
      .getBool(SharedPreferencesKeys.CANACCESSHOSPITALOPS);
}
