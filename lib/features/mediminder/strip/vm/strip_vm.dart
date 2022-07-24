import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../mediminder.dart';

class StripVm with ChangeNotifier {
  StripDetailModel stripDetailModel = StripDetailModel();
  BuildContext mContext;
  ProgressDialog? progressDialog;

  StripVm(this.mContext) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await loadValues();
    });
  }

  int initCount = 0;
  int alarmCount = 0; // Alarm
  int stripCount = 0; // Mevcut
  int usedStripCount = 0; // Kullanılan
  Person? userLocal;

  Future<void> loadValues() async {
    // showLoadingDialog();
    // await Future.delayed(const Duration(milliseconds: 200));

    try {
      // TODO loadValues
      stripDetailModel.alarmCount = 10;
      stripDetailModel.currentCount = 50;
      stripDetailModel.deviceUUID = "ID";
      stripDetailModel.entegrationId = 10;
      stripDetailModel.isNotificationActive = true;

      // if (getIt<ISharedPreferencesManager>()
      //     .containsKey(SharedPreferencesKeys.usedStripCount)) {
      //   usedStripCount = getIt<ISharedPreferencesManager>()
      //           .getInt(SharedPreferencesKeys.usedStripCount) ??
      //       0;
      // } else {
      //   usedStripCount = 0;
      //   await getIt<ISharedPreferencesManager>()
      //       .setInt(SharedPreferencesKeys.usedStripCount, 0);
      // }

      // userLocal = getIt<ProfileStorageImpl>().getFirst();
      // if (userLocal != null) {
      //   stripDetailModel = (await getIt<ChronicTrackingRepository>()
      //       .getUserStrip(userLocal!.id ?? 0, userLocal!.deviceUUID));
      //   stripDetailModel.deviceUUID = userLocal!.deviceUUID!;
      //   alarmCount = stripDetailModel.alarmCount;
      //   stripDetailModel.entegrationId = userLocal!.id!;
      //   stripCount = stripDetailModel.currentCount;
      //   initCount = stripDetailModel.currentCount;
      // }
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.e(e);
    } finally {
      hideDialog(mContext);
      notifyListeners();
    }
  }

  void incrementBy(int value) {
    stripCount = stripCount + value;
    notifyListeners();
  }

  void decrementBy(int value) {
    if (stripCount - value > 0) {
      stripCount = stripCount - value;
    } else {
      stripCount = 0;
    }
    notifyListeners();
  }

  void changeTo(int value) {
    if (value > 0) {
      stripCount = value;
      notifyListeners();
    }
  }

  void setAlarmCount(int value) {
    alarmCount = value;
  }

  Future<void> saveData() async {
    final diff = initCount - stripCount;
    if (diff > 0) {
      final newUseStripCount = (getIt<ISharedPreferencesManager>()
                  .getInt(SharedPreferencesKeys.usedStripCount) ??
              0) +
          diff;
      await getIt<ISharedPreferencesManager>()
          .setInt(SharedPreferencesKeys.usedStripCount, newUseStripCount);
      usedStripCount = newUseStripCount;
    }

    stripDetailModel.alarmCount = alarmCount;
    stripDetailModel.currentCount = stripCount;
    stripDetailModel.deviceUUID = userLocal!.deviceUUID!;
    stripDetailModel.entegrationId = userLocal!.id!;

    await getIt<ChronicTrackingRepository>().updateUserStrip(stripDetailModel);

    Fluttertoast.showToast(
      msg: "Kaydedildi",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    checkAlarmAndSendNotification(stripDetailModel);
    Utils.instance.hideKeyboard(mContext);
    notifyListeners();
  }

  void showLoadingDialog() {
    showDialog(
      context: mContext,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          progressDialog = progressDialog ?? const ProgressDialog(),
    );
  }

  void hideDialog(BuildContext context) {
    if (progressDialog != null) {
      if (progressDialog!.isShowing()) {
        Atom.dismiss();
        progressDialog = null;
      }
    }
  }

  static Future<void> checkAlarmAndSendNotification(
    StripDetailModel stripDetailModel,
  ) async {
    if (stripDetailModel.alarmCount >= stripDetailModel.currentCount) {
      getIt<LocalNotificationManager>().show(
        LocaleProvider.current.strip_count_low,
        stripLocaleProviderFetcher(
          stripDetailModel.currentCount.toString(),
        ),
      );
    }
  }

  static String stripLocaleProviderFetcher(String localPvString) {
    return LocaleProvider.current.you_have_strip.replaceFirst(
      LocaleProvider.current.strpCnt,
      localPvString,
    );
  }

  static void decrementAndSave(int value) async {
    final userLocal = getIt<ProfileStorageImpl>().getFirst();
    final sharedPrefs = getIt<ISharedPreferencesManager>();
    final stripDetailModel = await getIt<ChronicTrackingRepository>()
        .getUserStrip(userLocal.id!, userLocal.deviceUUID);
    stripDetailModel.deviceUUID = userLocal.deviceUUID!;
    stripDetailModel.entegrationId = userLocal.id!;
    if (stripDetailModel.currentCount - value > 0) {
      stripDetailModel.currentCount = stripDetailModel.currentCount - value;
    } else {
      stripDetailModel.currentCount = 0;
    }
    checkAlarmAndSendNotification(stripDetailModel);
    await sharedPrefs.setInt(
        SharedPreferencesKeys.usedStripCount,
        (sharedPrefs.getInt(SharedPreferencesKeys.usedStripCount) ?? 0) +
            value);
    getIt<ChronicTrackingRepository>().updateUserStrip(stripDetailModel);
  }
}
