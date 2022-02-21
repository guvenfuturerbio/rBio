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
  AllUsersModel? getHomeWidgets(String tcEmailPassport) {
    final sharedData =
        sharedPreferencesManager.getString(SharedPreferencesKeys.allUsers);
    if (sharedData == null) {
      return null;
    } else {
      final sharedMap = jsonDecode(sharedData) as Map<String, dynamic>?;
      final userExist = sharedMap?.containsKey(tcEmailPassport);
      if (userExist ?? false) {
        return AllUsersModel.fromJson(sharedMap?[tcEmailPassport]);
      } else {
        return null;
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
    late Map<String, dynamic> sharedMap;
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

  Future<void> logout(BuildContext context) async {
    final hasLogout = await _showConfirmationDialog(context) ?? false;
    if (!hasLogout) return;

    try {
      Atom.show(RbioLoading.progressIndicator());
      await getIt<FirebaseMessagingManager>().saveTokenServer("");
      await getIt<UserNotifier>().widgetsSave();
      await getIt<ISharedPreferencesManager>().reload();
      await getIt<Repository>().localCacheService.removeAll();
      getIt<UserNotifier>().clear();
      await getIt<LocalNotificationManager>().cancelAllNotifications();
      await getIt<FirebaseMessagingManager>().userLogout();
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

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    final result = await Atom.show(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: getIt<ITheme>().cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        title: GuvenAlert.buildTitle(
          LocaleProvider.current.warning,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            R.sizes.hSizer12,

            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GuvenAlert.buildDescription(
                LocaleProvider.current.logout_confirmation_description,
              ),
            ),

            //
            R.sizes.hSizer16,

            //
            Row(
              children: [
                R.sizes.wSizer12,
                Expanded(
                  child: GuvenAlert.buildMaterialAction(
                    LocaleProvider.current.Ok,
                    () {
                      Atom.dismiss(true);
                    },
                  ),
                ),
                R.sizes.wSizer8,
                Expanded(
                  child: GuvenAlert.buildMaterialAction(
                    LocaleProvider.current.btn_cancel,
                    () {
                      Atom.dismiss(false);
                    },
                  ),
                ),
                R.sizes.wSizer12,
              ],
            ),
          ],
        ),
        actions: const [],
      ),
    );

    return result ?? false;
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
