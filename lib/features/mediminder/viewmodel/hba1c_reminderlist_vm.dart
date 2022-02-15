import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/utils/tz_helper.dart';
import '../mediminder.dart';

class Hba1cReminderListVm extends ChangeNotifier {
  late BuildContext mContext;
  Hba1cReminderListVm(this.mContext) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await fetchAll();
      await generateUniqueIdForSchedule();
    });
  }

  final random = Random();

  List<Hba1CForScheduleModel> hba1cForScheduled = [];
  List<int>? generatedIdForSchedule;

  Future<void> fetchAll() async {
    final jsonList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.hba1cList);

    if (jsonList != null) {
      hba1cForScheduled = [];
      final tzNow = TZHelper.instance.now();

      for (String jsonMedicine in jsonList) {
        final tempHba1cElement =
            Hba1CForScheduleModel.fromJson(jsonDecode(jsonMedicine));
        final itemReminderDate = TZHelper.instance.fromMillisecondsSinceEpoch(
            int.tryParse(tempHba1cElement.reminderDate ?? '') ?? 0);

        if (itemReminderDate.isAfter(tzNow)) {
          hba1cForScheduled.add(tempHba1cElement);
        } else {
          removeScheduledHba1c(tempHba1cElement);
        }
      }

      notifyListeners();
    }
  }

  Future<void> removeScheduledHba1c(
      Hba1CForScheduleModel hba1cForSchedule) async {
    // Vm'de ki listeden item'ı sil
    hba1cForScheduled.removeWhere((hba1c) => hba1c.id == hba1cForSchedule.id);

    // Notification'ı iptal et
    if (hba1cForSchedule.id != null) {
      await getIt<LocalNotificationManager>()
          .cancelNotification(hba1cForSchedule.id!);
    }

    // Shared Preferences'da ki listeyi güncelle
    List<String> hba1cJsonList = [];
    if (hba1cForScheduled.isNotEmpty) {
      for (var hba1cElement in hba1cForScheduled) {
        String hba1cJson = jsonEncode(hba1cElement.toJson());
        hba1cJsonList.add(hba1cJson);
      }
    }
    await getIt<ISharedPreferencesManager>().setStringList(
      SharedPreferencesKeys.hba1cList,
      hba1cJsonList,
    );

    notifyListeners();
  }

  Future<void> generateUniqueIdForSchedule() async {
    List<int> numberList = [];
    List<String>? jsonList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.hba1cList);

    List<int> prefList = [];
    if (jsonList != null) {
      for (String jsonHba1c in jsonList) {
        Map<String, dynamic> userMap = jsonDecode(jsonHba1c);
        final tempHba1c = Hba1CForScheduleModel.fromJson(userMap);
        if (tempHba1c.id != null) {
          prefList.add(tempHba1c.id!);
        }
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

    generatedIdForSchedule = numberList;
    notifyListeners();
  }
}
