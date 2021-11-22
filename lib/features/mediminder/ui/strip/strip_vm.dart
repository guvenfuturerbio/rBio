import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/mediminder_common.dart';

class StripVm with ChangeNotifier {
  StripDetailModel stripDetailModel = StripDetailModel();
  BuildContext mContext;
  ProgressDialog progressDialog;

  StripVm(this.mContext) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await loadValues();
    });
  }

  int initCount = 0;
  int alarmCount = 0;
  int stripCount = 0;
  int usedStripCount = 0;

  Future<void> loadValues() async {
    showLoadingDialog();
    await Future.delayed(Duration(milliseconds: 200));

    try {
      if (getIt<ISharedPreferencesManager>()
          .containsKey(SharedPreferencesKeys.usedStripCount)) {
        usedStripCount = getIt<ISharedPreferencesManager>()
            .getInt(SharedPreferencesKeys.usedStripCount);
      } else {
        usedStripCount = 0;
        await getIt<ISharedPreferencesManager>()
            .setInt(SharedPreferencesKeys.usedStripCount, 0);
      }

      if (Mediminder.instance.selection != null) {
        stripDetailModel = await getIt<MediminderRepository>().getUserStrips(
                Mediminder.instance.selection?.id,
                Mediminder.instance.selection?.deviceUUID) ??
            StripDetailModel();

        stripDetailModel.deviceUUID = Mediminder.instance.selection?.deviceUUID;
        alarmCount = stripDetailModel.alarmCount;
        stripDetailModel.entegrationId = Mediminder.instance.selection?.id;
        stripCount = stripDetailModel.currentCount;
        initCount = stripDetailModel.currentCount;
      }
    } catch (e) {
      print(e);
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
      final newUseStripCount = getIt<ISharedPreferencesManager>()
              .getInt(SharedPreferencesKeys.usedStripCount) +
          diff;
      await getIt<ISharedPreferencesManager>()
          .setInt(SharedPreferencesKeys.usedStripCount, newUseStripCount);
      usedStripCount = newUseStripCount;
    }

    stripDetailModel.alarmCount = alarmCount;
    stripDetailModel.currentCount = stripCount;
    stripDetailModel.deviceUUID = Mediminder.instance.selection?.deviceUUID;
    stripDetailModel.entegrationId = Mediminder.instance.selection?.id;

    await getIt<MediminderRepository>().setUserStrips(stripDetailModel);

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
    KeyboardDismissOnTap.hideKeyboard(mContext);
    notifyListeners();
  }

  void showLoadingDialog() {
    showDialog(
      context: mContext,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          progressDialog = progressDialog ?? ProgressDialog(),
    );
  }

  void hideDialog(BuildContext context) {
    if (progressDialog != null && progressDialog.isShowing()) {
      Navigator.of(context).pop();
      progressDialog = null;
    }
  }

  static Future<void> checkAlarmAndSendNotification(
    StripDetailModel stripDetailModel,
  ) async {
    if (stripDetailModel.alarmCount >= stripDetailModel.currentCount) {
      await getIt<LocalNotificationsManager>().showNotification(
        'Strip Count is Low',
        'You have ${stripDetailModel.currentCount.toString()} strips left',
      );
    }
  }

  static void decrementAndSave(int value) async {
    final sharedPrefs = getIt<ISharedPreferencesManager>();
    final int usedStripCount =
        (sharedPrefs.getInt(SharedPreferencesKeys.usedStripCount) ??
            sharedPrefs.setInt(SharedPreferencesKeys.usedStripCount, 0));
    final stripDetailModel = await getIt<MediminderRepository>().getUserStrips(
            Mediminder.instance.selection?.id,
            Mediminder.instance.selection?.deviceUUID) ??
        StripDetailModel();
    stripDetailModel.deviceUUID = Mediminder.instance.selection?.deviceUUID;
    stripDetailModel.entegrationId = Mediminder.instance.selection?.id;
    if (stripDetailModel.currentCount - value > 0) {
      stripDetailModel.currentCount = stripDetailModel.currentCount - value;
    } else {
      stripDetailModel.currentCount = 0;
    }
    checkAlarmAndSendNotification(stripDetailModel);
    await sharedPrefs.setInt(SharedPreferencesKeys.usedStripCount,
        sharedPrefs.getInt(SharedPreferencesKeys.usedStripCount) + value);
    getIt<MediminderRepository>().setUserStrips(stripDetailModel);
  }
}
