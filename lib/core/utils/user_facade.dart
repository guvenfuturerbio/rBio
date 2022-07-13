import 'dart:convert';

import 'package:flutter/material.dart';

import '../../app/bluetooth_v2/bluetooth_v2.dart';
import '../../features/dashboard/home/view/home_screen.dart';
import '../../model/model.dart';
import '../core.dart';

abstract class UserFacade {
  Future<void> saveHomeWidgets(
    List<String> userWidgets, {
    bool isSharedClear = false,
  });
  AllUsersModel? getHomeWidgets(String tcEmailPassport);
  PatientResponse getPatient();
  Future<void> setPatient(PatientResponse patient);
  Future<void> setUserAccount(UserAccount userAccount);
  UserAccount getUserAccount();
  Future<bool> checkAccessToken();
  bool canAccessHospital();
  String getNameAndSurname();
  Future<bool?> logOutConfirmationDialog(
    BuildContext context,
  );
  Future<void> logout(
    BuildContext context,
    void Function() clearFunc,
  );
}

class UserFacadeImpl extends UserFacade {
  final IAppConfig appConfig;
  final FirebaseAnalyticsManager firebaseAnalyticsManager;
  final BluetoothLocalManager bluetoothLocalManager;
  final LocalNotificationManager localNotificationManager;
  final FirebaseMessagingManager firebaseMessagingManager;
  final ISharedPreferencesManager sharedPreferencesManager;
  final ProfileStorageImpl profileStorageImpl;
  final GlucoseStorageImpl glucoseStorageImpl;
  final BloodPressureStorageImpl bloodPressureStorageImpl;
  final Repository repository;
  final ScaleRepository scaleRepository;
  UserFacadeImpl({
    required this.appConfig,
    required this.firebaseAnalyticsManager,
    required this.bluetoothLocalManager,
    required this.localNotificationManager,
    required this.firebaseMessagingManager,
    required this.sharedPreferencesManager,
    required this.profileStorageImpl,
    required this.glucoseStorageImpl,
    required this.bloodPressureStorageImpl,
    required this.repository,
    required this.scaleRepository,
  });

  @override
  String getNameAndSurname() {
    final user = getUserAccount();
    if (user.name == null && user.surname == null) return "";
    return '${user.name} ${user.surname}';
  }

  @override
  Future<void> setPatient(PatientResponse patient) async {
    final stringData = jsonEncode(patient.toJson());
    await sharedPreferencesManager.setString(
      SharedPreferencesKeys.patient,
      stringData,
    );
  }

  @override
  PatientResponse getPatient() {
    final stringData =
        sharedPreferencesManager.getString(SharedPreferencesKeys.patient);
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

  @override
  Future<bool> checkAccessToken() async {
    final jwtToken =
        sharedPreferencesManager.getString(SharedPreferencesKeys.jwtToken);
    if (jwtToken == null) {
      return false;
    }

    try {
      await repository.getPatientDetail();
      return true;
    } catch (e, stackTrace) {
      appConfig.platform.sentryManager.captureException(
        e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
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

  @override
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

  @override
  bool canAccessHospital() =>
      sharedPreferencesManager
          .getBool(SharedPreferencesKeys.canAccessHospitalOps) ??
      false;

  @override
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

  @override
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

  @override
  Future<bool?> logOutConfirmationDialog(
    BuildContext context,
  ) async {
    final result = await Atom.show(
      RbioBaseGreyDialog(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleProvider.current.warning,
                style: appConfig.theme.dialogTheme.title(context),
              ),

              //
              R.sizes.hSizer32,

              //
              Center(
                child: Text(
                  LocaleProvider.current.logout_confirmation_description,
                  textAlign: TextAlign.center,
                  style: appConfig.theme.dialogTheme.description(context),
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

  @override
  Future<void> logout(
    BuildContext context,
    void Function() clearFunc,
  ) async {
    try {
      Atom.show(RbioLoading.progressIndicator());
      final localDevices = bluetoothLocalManager.getPairedDevices();
      if (localDevices.isNotEmpty) {
        for (var item in localDevices) {
          if (item.deviceType == DeviceType.miScale) {
            context.read<DeviceSelectedCubit>().disconnect(item);
          }
        }
      }
      await firebaseMessagingManager.saveTokenServer("");
      await _widgetsSave();
      await sharedPreferencesManager.reload();
      await repository.localCacheService.removeAll();
      clearFunc();
      await localNotificationManager.cancelAllNotifications();
      await firebaseMessagingManager.userLogout();
      glucoseStorageImpl.clear();
      bloodPressureStorageImpl.clear();
      profileStorageImpl.clear();
      await scaleRepository.clear();
      AppInheritedWidget.of(context)?.cancelStreamLocalNotification();
      kAutoConnect = true;
    } catch (e, stackTrace) {
      appConfig.platform.sentryManager.captureException(
        e,
        stackTrace: stackTrace,
      );
    } finally {
      Atom.dismiss();
      appConfig.platform.adjustManager?.trackEvent(LogOutEvent());
      firebaseAnalyticsManager.logEvent(UygulamaCikisEvent());
      Atom.to(PagePaths.login, isReplacement: true);
    }
  }

  //
  Future<void> _widgetsSave() async {
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
      SharedPreferencesKeys.firstLaunch,
      firstLaunch,
    );
    await sharedPreferencesManager.setString(
      SharedPreferencesKeys.allUsers,
      jsonEncode(sharedMap),
    );
  }
}
