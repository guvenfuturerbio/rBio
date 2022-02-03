import 'dart:convert';

import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../core.dart';

enum UserType { doctor, chronicUser, basicUser }

class UserNotifier extends ChangeNotifier {
  PatientResponse? patient;
  List<UserType> _userType = [];
  //
  String? firebaseID;
  String? firebaseEmail;
  String? firebasePassword;
  //
  bool get isDoctor => _userType.contains(UserType.doctor);
  bool get isCronic => _userType.contains(UserType.chronicUser);
  bool get isPatient => _userType.contains(UserType.basicUser);

  final sharedPreferencesManager = getIt<ISharedPreferencesManager>();

  Future<void> setPatient(PatientResponse patient) async {
    final stringData = jsonEncode(patient.toJson());
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.patient, stringData);
  }

  PatientResponse getPatient() {
    final stringData = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.patient);
    if (stringData != null) {
      final decodeData = jsonDecode(stringData);
      if (decodeData is Map<String, dynamic>?) {
        if (decodeData != null) {
          return PatientResponse.fromJson(decodeData);
        }
      }
    }

    throw Exception("patient null");
  }

  void userTypeFetcher(RbioLoginResponse rsp) {
    if (rsp.roles?.contains("Doctor") ?? false) {
      _userType.add(UserType.doctor);
    }
    if (rsp.roles?.contains("cronicPatient") ?? false) {
      _userType.add(UserType.chronicUser);
    }
    if (rsp.roles?.contains("AllMain") ?? false) {
      _userType.add(UserType.basicUser);
    }
  }

// Guven online user account set
  Future<void> setUserAccount(UserAccount userAccount) async {
    bool? _canAccessHospitalOps;

    if (userAccount.nationality == "TC") {
      final identificationNumber = userAccount.identificationNumber;
      if (identificationNumber != null && identificationNumber != '') {
        _canAccessHospitalOps = true;
      }
    } else {
      final passaportNumber = userAccount.passaportNumber;
      if (userAccount.passaportNumber != null && passaportNumber != '') {
        _canAccessHospitalOps = true;
      }
    }

    await sharedPreferencesManager.setString(
      SharedPreferencesKeys.userAccount,
      jsonEncode(
        userAccount.toJson(),
      ),
    );
    await sharedPreferencesManager.setBool(
      SharedPreferencesKeys.canAccessHospitalOps,
      _canAccessHospitalOps ?? false,
    );
  }

  // Güven online user account get
  UserAccount getUserAccount() {
    final userAccountStr =
        sharedPreferencesManager.getString(SharedPreferencesKeys.userAccount);
    if (userAccountStr != null) {
      final decodeData = jsonDecode(userAccountStr);
      if (decodeData is Map<String, dynamic>?) {
        if (decodeData != null) {
          final model = UserAccount.fromJson(decodeData);
          return model;
        }
      }
    }

    throw Exception('UserAccount null');
  }

  Future<bool> checkAccessToken() async {
    final jwtToken =
        sharedPreferencesManager.getString(SharedPreferencesKeys.jwtToken);
    if (jwtToken == null) {
      return false;
    }

    try {
      await getIt<Repository>().getPatientDetail();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool canAccessHospital() =>
      sharedPreferencesManager
          .getBool(SharedPreferencesKeys.canAccessHospitalOps) ??
      false;
  void clear() {
    patient = null;
    _userType = [];
  }

  //
  AllUsersModel getHomeWidgets(String tcEmailPassport) {
    final sharedData =
        sharedPreferencesManager.getString(SharedPreferencesKeys.allUsers);
    if (sharedData == null) {
      throw Exception("allUser null");
    } else {
      final sharedMap = jsonDecode(sharedData) as Map<String, dynamic>;
      final userExist = sharedMap.containsKey(tcEmailPassport);
      if (userExist) {
        return AllUsersModel.fromJson(sharedMap[tcEmailPassport]);
      } else {
        throw Exception("user doesnt exist");
      }
    }
  }

  //
  Future<void> saveHomeWidgets(
    List<String> userWidgets, {
    bool isSharedClear = false,
  }) async {
    final currentUserName =
        sharedPreferencesManager.getString(SharedPreferencesKeys.loginUserName);
    if (currentUserName == null) return;
    final sharedData =
        sharedPreferencesManager.getString(SharedPreferencesKeys.allUsers);
    Map<String, dynamic> sharedMap;
    if (sharedData == null) {
      sharedMap = {};
    } else {
      sharedMap = jsonDecode(sharedData);
    }
    sharedMap.addAll(
      {
        currentUserName: AllUsersModel(
          useWidgets: userWidgets,
        ).toJson(),
      },
    );
    if (isSharedClear) {
      await sharedPreferencesManager.clear();
    }
    await sharedPreferencesManager.setString(
      SharedPreferencesKeys.allUsers,
      jsonEncode(sharedMap),
    );
  }

  Future<void> logout() async {
    try {
      Atom.show(RbioLoading.progressIndicator());
      await FirebaseMessagingManager.instance.setTokenToServer("");
      await getIt<UserNotifier>().widgetsSave();
      await getIt<ISharedPreferencesManager>().reload();
      await getIt<Repository>().localCacheService.removeAll();
      getIt<UserNotifier>().clear();
      FirebaseMessagingManager.handleLogout();
      getIt<GlucoseStorageImpl>().clear();
      getIt<ScaleStorageImpl>().clear();
      getIt<BloodPressureStorageImpl>().clear();
      getIt<ProfileStorageImpl>().clear();
    } catch (e) {
      LoggerUtils.instance.e(e);
    } finally {
      Atom.dismiss();
      Atom.to(PagePaths.login, isReplacement: true);
    }
  }

  //
  Future<void> widgetsSave() async {
    final sharedData =
        sharedPreferencesManager.getString(SharedPreferencesKeys.allUsers);
    Map<String, dynamic> sharedMap;
    if (sharedData == null) {
      sharedMap = {};
    } else {
      sharedMap = jsonDecode(sharedData);
    }
    await sharedPreferencesManager.clear();
    await sharedPreferencesManager.setString(
      SharedPreferencesKeys.allUsers,
      jsonEncode(sharedMap),
    );
  }
}
