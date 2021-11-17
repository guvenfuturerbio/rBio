import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onedosehealth/features/mediminder/models/hba1c_for_schedule.dart';
import 'package:onedosehealth/features/mediminder/ui/homepage/timezone.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import 'hba1c_reminderlist_page.dart';
import 'selectedremindable.dart';

class Hba1cViewModel extends ChangeNotifier {
  BuildContext mContext;
  Remindable mRemindable;
  String remindDate = "";
  String lastMeasurementDate = "";
  ProgressDialog progressDialog;
  double previousResult = 0;
  SharedPreferences prefs;
  final timeZone = TimeZone();
  String timeZoneName = "";
  var location;
  var scheduledDateForHba;

  Hba1cViewModel(BuildContext context, Remindable remindable) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      this.mRemindable = remindable;
      this.mContext = context;
      await loadValues();
    });
  }

  timeZoneFetcher() async {
    // The device's timezone.
    timeZoneName = await timeZone.getTimeZoneName();
    // Find the 'current location'
    location = await timeZone.getLocation(timeZoneName);
    scheduledDateForHba =
        tz.TZDateTime.from(DateTime.parse(remindDate), location);
  }

  loadValues() async {
    //prefs = SharedPrefInit().sharedPreferences;
    /*prefs.getString('hba1cRemindDate') ??
        await prefs.setString('hba1cRemindDate', "");
    prefs.getString('lastMeasurementDate') ??
        await prefs.setString('lastMeasurementDate', "");
    prefs.getDouble('previousResult') ??
        await prefs.setDouble('previousResult', 0.0);
    remindDate = prefs.getString('hba1cRemindDate');
    lastMeasurementDate = prefs.getString('lastMeasurementDate');
    previousResult = prefs.getDouble('previousResult');*/
    notifyListeners();
  }

  setRemind(String time) async {
    remindDate = time;
    /*await prefs.setString('hba1cRemindDate', time.toString());*/
    notifyListeners();
  }

  setLastMeasurementDate(String time) async {
    lastMeasurementDate = time;
    remindDate = (DateTime.parse(time).add(Duration(days: 90)))
            .isBefore(DateTime.now().add(Duration(minutes: 5)))
        ? DateTime.now().add(Duration(minutes: 5)).toString()
        : (DateTime.parse(time).add(Duration(days: 90))).toString();
    /*await prefs.setString('hba1cRemindDate', remindDate.toString());
    await prefs.setString('lastMeasurementDate', time.toString());*/
    notifyListeners();
  }

  setPreviousResult(double result) async {
    previousResult = result;
    //await prefs.setDouble('previousResult', result);
    notifyListeners();
  }

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  setRemindDate(Hba1CForSchedule hba1cModel) async {
    await timeZoneFetcher();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            '13', 'Hba1c Reminder', 'Hba1c measurement needed',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const IOSNotificationDetails iosPlatformChannelSpecificts =
        IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecificts);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        hba1cModel.id,
        "Hba1c Ölçümü",
        "Hba1c ölçümü zamanınız geldi",
        scheduledDateForHba,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    saveScheduledHba1c(hba1cModel);
    /* Navigator.of(mContext)
        .popUntil(ModalRoute.withName(Routes.MY_MEDICINES_PAGE));*/
    Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (_) => Hba1cReminderListPage(remindable: mRemindable)));
  }

  saveScheduledHba1c(Hba1CForSchedule hba1c) async {
    Map<String, dynamic> tempMap = hba1c.toJson();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String newHba1cJson = jsonEncode(tempMap);
    List<String> hba1cJsonList = [];
    if (sharedUser.getStringList('hba1cList') == null) {
      hba1cJsonList.add(newHba1cJson);
    } else {
      hba1cJsonList = sharedUser.getStringList('hba1cList');
      hba1cJsonList.add(newHba1cJson);
    }
    sharedUser.setStringList('hba1cList', hba1cJsonList);
  }
}
