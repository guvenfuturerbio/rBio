import 'dart:convert';

import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../core.dart';

enum UserType { doctor, chronic_user, basic_user }

class UserNotifier extends ChangeNotifier {
  PatientResponse patient;
  List<UserType> _userType = [];

  bool get isDoctor => _userType.contains(UserType.doctor);
  bool get isCronic => _userType.contains(UserType.chronic_user);
  bool get isPatient => _userType.contains(UserType.basic_user);
  SharedPreferencesManager sharedPreferencesManager =
      getIt<ISharedPreferencesManager>();
  Future<void> setPatient(PatientResponse patient) async {
    final stringData = jsonEncode(patient.toJson());
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.PATIENT, stringData);
  }

  PatientResponse getPatient() {
    final stringData = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.PATIENT);
    if (stringData != null) {
      final decodeData = jsonDecode(stringData);
      return PatientResponse.fromJson(decodeData);
    }

    return null;
  }

  void userTypeFetcher(RbioLoginResponse rsp) {
    if (rsp.roles.contains("Doctor")) {
      _userType.add(UserType.doctor);
    }
    if (rsp.roles.contains("cronicPatient")) {
      _userType.add(UserType.chronic_user);
    }
    if (rsp.roles.contains("AllMain")) {
      _userType.add(UserType.basic_user);
    }
  }
// Guven online user account set
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
// Güven online user account get
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
  void clear() {
    patient = null;
    _userType = [];
  }
}
