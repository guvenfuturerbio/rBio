import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../mediminder.dart';

class Hba1cReminderListVm extends ChangeNotifier {
  BuildContext mContext;
  Hba1cReminderListVm(this.mContext) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAll();
      await generateUniqueIdForSchedule();
    });
  }

  final random = Random();

  List<Hba1CForScheduleModel> _hba1cForScheduled;
  List<Hba1CForScheduleModel> get hba1cForScheduled =>
      this._hba1cForScheduled ?? [];

  List<int> _generatedIdForSchedule;
  List<int> get generatedIdForSchedule => this._generatedIdForSchedule;

  Future<void> fetchAll() async {
    List<String> jsonList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.hba1cList);
    List<Hba1CForScheduleModel> prefList = [];
    if (jsonList == null) {
      return;
    } else {
      for (String jsonMedicine in jsonList) {
        final tempHba1cElement =
            Hba1CForScheduleModel.fromJson(jsonDecode(jsonMedicine));
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

  Future<void> removeScheduledHba1c(
      Hba1CForScheduleModel hba1cForSchedule) async {
    // Vm'de ki listeden item'ı sil
    this
        ._hba1cForScheduled
        .removeWhere((hba1c) => hba1c.id == hba1cForSchedule.id);

    // Notification'ı iptal et
    await getIt<LocalNotificationsManager>().cancel(hba1cForSchedule.id);

    // Shared Preferences'da ki listeyi güncelle
    List<String> hba1cJsonList = [];
    if (this._hba1cForScheduled.length != 0) {
      for (var hba1cElement in this._hba1cForScheduled) {
        String hba1cJson = jsonEncode(hba1cElement.toJson());
        hba1cJsonList.add(hba1cJson);
      }
    }
    await getIt<ISharedPreferencesManager>()
        .setStringList(SharedPreferencesKeys.hba1cList, hba1cJsonList);

    notifyListeners();
  }

  Future<void> generateUniqueIdForSchedule() async {
    List<int> numberList = [];
    List<String> jsonList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.hba1cList);

    List<int> prefList = [];
    if (jsonList != null) {
      for (String jsonHba1c in jsonList) {
        Map<String, dynamic> userMap = jsonDecode(jsonHba1c);
        final tempHba1c = Hba1CForScheduleModel.fromJson(userMap);
        prefList.add(tempHba1c.id);
      }
    }

    bool isAdded = false;
    while (!isAdded) {
      int randomNumber = 20000 + random.nextInt(10000);
      // Prevent Generate Duplicate Ids
      if (!numberList.contains(randomNumber) &&
          !prefList.contains(randomNumber)) {
        isAdded = true;
        numberList.add(randomNumber);
      }
    }

    this._generatedIdForSchedule = numberList;
    notifyListeners();
  }
}
