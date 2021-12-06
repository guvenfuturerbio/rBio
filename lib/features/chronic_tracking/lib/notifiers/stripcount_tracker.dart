import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onedosehealth/features/mediminder/mediminder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/progress_dialog.dart';
import '../locator.dart';
import '../widgets/utils/base_provider_repository.dart';
import 'user_profiles_notifier.dart';

class StripCountTracker with ChangeNotifier {
  UserProfilesNotifier notifier = locator<UserProfilesNotifier>();
  StripDetailModel stripDetailModel = new StripDetailModel();
  final BuildContext context;
  int stripCount = 0;
  ProgressDialog progressDialog;
  StripCountTracker(this.context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await loadValues();
    });
  }
  int initCount;
  SharedPreferences prefs;
  int alarmCount = 0;
  int usedStripCount = 0;
  static const STRIP_COUNT_KEY = "strip_count";
  static const USED_STRIP_COUNT_KEY = "used_strip_count";
  static const ALARM_COUNT_KEY = "strip_alarm_count";

  loadValues() async {
    showLoadingDialog();
    await Future.delayed(Duration(milliseconds: 200));
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      prefs = await _prefs;
      //Check
      if (prefs.containsKey('usedStripCount')) {
        usedStripCount = prefs.getInt('usedStripCount');
      } else {
        usedStripCount = 0;
        prefs.setInt('usedStripCount', 0);
      }

      if (UserProfilesNotifier().selection != null) {
        stripDetailModel = (await BaseProviderRepository().getUserStrips(
                UserProfilesNotifier().selection?.id,
                UserProfilesNotifier().selection?.deviceUUID) ??
            new StripDetailModel());
        stripDetailModel.deviceUUID =
            UserProfilesNotifier().selection?.deviceUUID;
        alarmCount = stripDetailModel.alarmCount;
        stripDetailModel.entegrationId = UserProfilesNotifier().selection?.id;
        stripCount = stripDetailModel.currentCount;
        initCount = stripDetailModel.currentCount;
      }
      hideDialog(context);
      notifyListeners();
    } catch (e) {
      hideDialog(context);
    }
  }

  showLoadingDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            progressDialog = progressDialog ?? ProgressDialog());
  }

  hideDialog(BuildContext context) {
    if (progressDialog != null && progressDialog.isShowing()) {
      Navigator.of(context).pop();
      progressDialog = null;
    }
  }

  void decrementBy(int value) {
    if (stripCount - value > 0) {
      stripCount = stripCount - value;
    } else {
      stripCount = 0;
    }
    notifyListeners();
  }

  static decrementAndSave(int value) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    StripDetailModel stripDetailModel = (await BaseProviderRepository()
            .getUserStrips(UserProfilesNotifier().selection?.id,
                UserProfilesNotifier().selection?.deviceUUID) ??
        new StripDetailModel());
    stripDetailModel.deviceUUID = UserProfilesNotifier().selection?.deviceUUID;
    stripDetailModel.entegrationId = UserProfilesNotifier().selection?.id;
    if (stripDetailModel.currentCount - value > 0) {
      stripDetailModel.currentCount = stripDetailModel.currentCount - value;
    } else {
      stripDetailModel.currentCount = 0;
    }
    checkAlarmAndSendNotification(stripDetailModel);
    prefs.setInt('usedStripCount', prefs.getInt('usedStripCount') + value);

    BaseProviderRepository().setUserStrips(stripDetailModel);
  }

  void incrementBy(int value) {
    stripCount = stripCount + value;
    notifyListeners();
  }

  void changeTo(int value) {
    print("Changing value to $value");
    if (value > 0) {
      stripCount = value;
    }
    //notifyListeners();
  }

  setAlarmCount(int value) {
    alarmCount = value;
    //  notifyListeners();
  }

  updateServer() {
    if (initCount - stripCount > 0) {
      prefs.setInt('usedStripCount',
          prefs.getInt('usedStripCount') + (initCount - stripCount));
      usedStripCount = prefs.getInt('usedStripCount');
    }
    stripDetailModel.alarmCount = alarmCount;
    stripDetailModel.currentCount = stripCount;
    stripDetailModel.deviceUUID = UserProfilesNotifier().selection?.deviceUUID;
    stripDetailModel.entegrationId = UserProfilesNotifier().selection?.id;
    BaseProviderRepository().setUserStrips(stripDetailModel);
    Fluttertoast.showToast(
        msg: "Kaydedildi",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
    checkAlarmAndSendNotification(stripDetailModel);
    notifyListeners();
  }
}

var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

checkAlarmAndSendNotification(StripDetailModel stripDetailModel) async {
  if (stripDetailModel.alarmCount >= stripDetailModel.currentCount) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('12', 'Strip Alert',
            channelDescription: 'Low Strip Count',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const IOSNotificationDetails iosPlatformChannelSpecificts =
        IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecificts,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Strip Count is Low',
      'You have ' + stripDetailModel.currentCount.toString() + " strips left",
      platformChannelSpecifics,
    );
  }
}
