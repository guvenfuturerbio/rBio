import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/utils/tz_helper.dart';
import '../../mediminder.dart';

class Hba1cReminderListVm extends ChangeNotifier {
  late BuildContext mContext;
  Hba1cReminderListVm(this.mContext) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await fetchAll();
    });
  }

  final random = Random();

  List<Hba1CReminderModel> hba1cForScheduled = [];

  Future<void> fetchAll() async {
    final jsonList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.hba1cList);

    if (jsonList != null) {
      hba1cForScheduled = [];
      final tzNow = TZHelper.instance.now();

      for (String jsonMedicine in jsonList) {
        final tempHba1cElement =
            Hba1CReminderModel.fromJson(jsonDecode(jsonMedicine));
        final itemReminderDate = TZHelper.instance
            .fromMillisecondsSinceEpoch(tempHba1cElement.scheduledDate);

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
      Hba1CReminderModel hba1cForSchedule) async {
    // Vm'de ki listeden item'ı sil
    hba1cForScheduled.removeWhere(
        (hba1c) => hba1c.notificationId == hba1cForSchedule.notificationId);

    // Notification'ı iptal et
    await getIt<LocalNotificationManager>()
        .cancelNotification(hba1cForSchedule.notificationId);

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
}
