import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onedosehealth/features/mediminder/models/hba1c_for_schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Hba1cListPageVm extends ChangeNotifier {
  BuildContext mContext;
  List<Hba1CForSchedule> _hba1cForScheduled;
  List<int> _generatedIdForSchedule;
  Hba1cListPageVm(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchHba1cReminderList();
      await generateUniqueIdForSchedule();
    });
  }

  List<Hba1CForSchedule> get hba1cForScheduled => this._hba1cForScheduled ?? [];
  List<int> get generatedIdForSchedule => this._generatedIdForSchedule;

  fetchHba1cReminderList() async {
    notifyListeners();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> jsonList = sharedUser.getStringList('hba1cList');
    List<Hba1CForSchedule> prefList = [];
    if (jsonList == null) {
      return;
    } else {
      for (String jsonMedicine in jsonList) {
        Map userMap = jsonDecode(jsonMedicine);
        Hba1CForSchedule tempHba1cElement = Hba1CForSchedule.fromJson(userMap);
        print(userMap);
        if (DateTime.parse(tempHba1cElement.reminderDate)
            .isAfter(DateTime.now())) {
          prefList.add(tempHba1cElement);
        } else {
          removeScheduledHba1c(tempHba1cElement);
        }
      }
      this._hba1cForScheduled = prefList;
      notifyListeners();
    }
  }

  removeScheduledHba1c(Hba1CForSchedule hba1cForSchedule) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> hba1cJsonList = [];

    this
        ._hba1cForScheduled
        .removeWhere((hba1c) => hba1c.id == hba1cForSchedule.id);
    flutterLocalNotificationsPlugin.cancel(hba1cForSchedule.id);
    if (this._hba1cForScheduled.length != 0) {
      for (var hba1cElement in this._hba1cForScheduled) {
        String hba1cJson = jsonEncode(hba1cElement.toJson());
        hba1cJsonList.add(hba1cJson);
      }
    }
    sharedUser.setStringList('hba1cList', hba1cJsonList);
    notifyListeners();
  }

  generateUniqueIdForSchedule() async {
    List<int> numberList = [];
    Random random = new Random();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> jsonList = sharedUser.getStringList('hba1cList');
    List<int> prefList = [];
    if (jsonList != null) {
      for (String jsonHba1c in jsonList) {
        Map userMap = jsonDecode(jsonHba1c);
        Hba1CForSchedule tempHba1c = Hba1CForSchedule.fromJson(userMap);
        prefList.add(tempHba1c.id);
      }
    }
    bool isAdded = false;
    while (!isAdded) {
      int randomNumber = 20000 + random.nextInt(10000);
      if (!numberList.contains(randomNumber) &&
          !prefList.contains(randomNumber)) {
        //prevent generate duplicate ids
        print('Number listesine ekleme yapıldı!');
        isAdded = true;
        numberList.add(randomNumber);
      }
    }
    this._generatedIdForSchedule = numberList;
    notifyListeners();
  }
}
