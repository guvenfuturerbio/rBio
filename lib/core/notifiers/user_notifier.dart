import 'dart:convert';

import 'package:flutter/material.dart';

import '../../app/bluetooth_v2/bluetooth_v2.dart';
import '../../features/dashboard/home/view/home_screen.dart';
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
  bool? isDefaultUser;
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

    return PatientResponse();
  }

  String getCurrentUserNameAndSurname() =>
      '${getUserAccount().name} ${getUserAccount().surname}';

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

    return UserAccount();
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
      final localDevices = getIt<BluetoothLocalManager>().getPairedDevices();
      if (localDevices.isNotEmpty) {
        for (var item in localDevices) {
          if (item.deviceType == DeviceType.miScale) {
            context.read<DeviceSelectedCubit>().disconnect(item);
          }
        }
      }
      await getIt<FirebaseMessagingManager>().saveTokenServer("");
      await getIt<UserNotifier>().widgetsSave();
      await getIt<ISharedPreferencesManager>().reload();
      await getIt<Repository>().localCacheService.removeAll();
      getIt<UserNotifier>().clear();
      await getIt<LocalNotificationManager>().cancelAllNotifications();
      await getIt<FirebaseMessagingManager>().userLogout();
      getIt<GlucoseStorageImpl>().clear();
      getIt<BloodPressureStorageImpl>().clear();
      getIt<ProfileStorageImpl>().clear();
      await getIt<ScaleRepository>().clear();
      AppInheritedWidget.of(context)?.cancelStreamLocalNotification();
      kAutoConnect = true;
    } catch (e) {
      LoggerUtils.instance.e(e);
    } finally {
      Atom.dismiss();
      getIt<IAppConfig>().platform.adjustManager?.trackEvent(LogOutEvent());
      getIt<FirebaseAnalyticsManager>().logEvent(UygulamaCikisEvent());
      Atom.to(PagePaths.login, isReplacement: true);
    }
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    final result = await Atom.show(
      RbioBaseGreyDialog(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleProvider.current.warning,
                style: getIt<IAppConfig>().theme.dialogTheme.title(context),
              ),
              //
              R.sizes.hSizer32,
              //

              Center(
                child: Text(
                  LocaleProvider.current.logout_confirmation_description,
                  textAlign: TextAlign.center,
                  style: getIt<IAppConfig>()
                      .theme
                      .dialogTheme
                      .description(context),
                ),
              ),

              //
              R.sizes.hSizer32,

              //
              Row(
                children: [
                  R.sizes.wSizer12,
                  Expanded(
                    child: RbioSmallDialogButton.red(
                      title: LocaleProvider.current.btn_cancel,
                      onPressed: () {
                        Atom.dismiss(false);
                      },
                    ),
                  ),
                  R.sizes.wSizer8,
                  Expanded(
                    child: RbioSmallDialogButton.green(
                      title: LocaleProvider.current.Ok,
                      onPressed: () {
                        Atom.dismiss(true);
                      },
                    ),
                  ),
                  R.sizes.wSizer12,
                ],
              ),
            ],
          ),
        ),
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
    final firstLaunch =
        sharedPreferencesManager.getBool(SharedPreferencesKeys.firstLaunch) ??
            false;
    await sharedPreferencesManager.clear();
    await sharedPreferencesManager.setBool(
        SharedPreferencesKeys.firstLaunch, firstLaunch);
    await sharedPreferencesManager.setString(
      SharedPreferencesKeys.allUsers,
      jsonEncode(sharedMap),
    );
  }
}
