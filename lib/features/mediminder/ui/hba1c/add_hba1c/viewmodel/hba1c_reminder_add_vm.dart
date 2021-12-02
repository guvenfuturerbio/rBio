import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../../../../core/core.dart';
import '../../../../../../core/enums/remindable.dart';
import '../../../../../../core/timezone/timezone.dart';
import '../../../../managers/local_notifications_manager.dart';
import '../../../../../../model/mediminder/hba1c_for_schedule_model.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../list_hba1c/view/hba1c_reminderlist_screen.dart';

class Hba1cReminderAddVm extends ChangeNotifier {
  BuildContext mContext;
  Remindable mRemindable;

  Hba1cReminderAddVm(this.mContext, this.mRemindable);

  final timeZone = TimeZone();
  tz.Location location;

  String remindDate = "";
  Future<void> setRemindDate(String time) async {
    remindDate = time;
    notifyListeners();
  }

  String lastMeasurementDate = "";
  Future<void> setLastMeasurementDate(String time) async {
    lastMeasurementDate = time;
    remindDate = (DateTime.parse(time).add(Duration(days: 90)))
            .isBefore(DateTime.now().add(Duration(minutes: 5)))
        ? DateTime.now().add(Duration(minutes: 5)).toString()
        : (DateTime.parse(time).add(Duration(days: 90))).toString();
    notifyListeners();
  }

  double previousResult = 0;
  Future<void> setPreviousResult(double result) async {
    previousResult = result;
    notifyListeners();
  }

  Future<void> createNotification(Hba1CForScheduleModel hba1cModel) async {
    await timeZoneFetcher();
    await getIt<LocalNotificationsManager>().createHba1c(
      hba1cModel,
      scheduledDateForHba,
    );
    await saveScheduledHba1c(hba1cModel);
    Atom.historyBack();
  }

  var scheduledDateForHba;
  Future<void> timeZoneFetcher() async {
    String timeZoneName = await timeZone.getTimeZoneName();
    location = await timeZone.getLocation(timeZoneName);
    scheduledDateForHba = tz.TZDateTime.from(
      DateTime.parse(remindDate),
      location,
    );
  }

  Future<void> saveScheduledHba1c(Hba1CForScheduleModel hba1c) async {
    String newHba1cJson = jsonEncode(hba1c.toJson());
    List<String> hba1cJsonList = [];

    final sharedList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.hba1cList);
    if (sharedList != null) {
      hba1cJsonList = sharedList;
    }

    hba1cJsonList.add(newHba1cJson);
    await getIt<ISharedPreferencesManager>()
        .setStringList(SharedPreferencesKeys.hba1cList, hba1cJsonList);
  }
}
