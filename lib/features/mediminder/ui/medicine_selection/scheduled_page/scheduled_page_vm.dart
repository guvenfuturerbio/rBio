import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/medicine_for_schedule.dart';
import '../../homepage/selectedremindable.dart';
import '../medicine_period_selection.dart';

/// MG11
class ScheduledPageVm extends ChangeNotifier {
  BuildContext mContext;
  String mTitle;
  List<MedicineForScheduled> _medicineForScheduled;
  ScheduledPageVm({BuildContext context, Remindable remindable}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      this.mTitle = setTitle(remindable);
      await fetchScheduledMedicineList();
    });
  }

  String get title => this.mTitle;

  setTitle(Remindable remindable) {
    switch (remindable) {
      case Remindable.BloodGlucose:
        return LocaleProvider.of(mContext).blood_glucose_measurement;
        break;
      case Remindable.HbA1c:
        return LocaleProvider.of(mContext).hbA1c_measurement;
        break;
      case Remindable.Strip:
        return LocaleProvider.of(mContext).strip_tracker;
        break;
      case Remindable.Medication:
        return LocaleProvider.of(mContext).medication_reminder;
        break;
      default:
        return LocaleProvider.of(mContext).error;
    }
  }

  setPeriodString(String period) {
    if (period == MedicinePeriod.EVERY_DAY.toString()) {
      return LocaleProvider.of(mContext).every_day;
    } else if (period == MedicinePeriod.SPECIFIC_DAYS.toString()) {
      return LocaleProvider.of(mContext).specific_days;
    } else {
      return LocaleProvider.of(mContext).intermittent_days;
    }
  }

  setDayString(int dayIndex) {
    if (dayIndex == 1) {
      return LocaleProvider.of(mContext).weekdays_monday;
    } else if (dayIndex == 2) {
      return LocaleProvider.of(mContext).weekdays_tuesday;
    } else if (dayIndex == 3) {
      return LocaleProvider.of(mContext).weekdays_wednesday;
    } else if (dayIndex == 4) {
      return LocaleProvider.of(mContext).weekdays_thursday;
    } else if (dayIndex == 5) {
      return LocaleProvider.of(mContext).weekdays_friday;
    } else if (dayIndex == 6) {
      return LocaleProvider.of(mContext).weekdays_saturday;
    } else if (dayIndex == 7) {
      return LocaleProvider.of(mContext).weekdays_sunday;
    } else {
      return "";
    }
  }

  setUsageType(String usageType) {
    if (usageType == UsageType.FULL.toString()) {
      return LocaleProvider.of(mContext).full;
    } else if (usageType == UsageType.IRRELEVANT.toString()) {
      return LocaleProvider.of(mContext).irrelevant;
    } else {
      return LocaleProvider.of(mContext).hungry;
    }
  }

  fetchScheduledMedicineList() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> jsonList = sharedUser.getStringList('medicines');
    List<MedicineForScheduled> prefList = [];
    if (jsonList == null) {
      return;
    } else {
      for (String jsonMedicine in jsonList) {
        Map userMap = jsonDecode(jsonMedicine);
        MedicineForScheduled tempMedicine =
            MedicineForScheduled.fromJson(userMap);
        prefList.add(tempMedicine);
      }
      this._medicineForScheduled = prefList;
      notifyListeners();
    }
  }

  List<MedicineForScheduled> get medicineForScheduled =>
      this._medicineForScheduled ?? [];

  removeScheduledMedicine(MedicineForScheduled medicineForScheduled) async {
    print("id " + medicineForScheduled.notificationId.toString());
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> medicineJsonList = [];

    this._medicineForScheduled.removeWhere((medicine) =>
        medicine.notificationId == medicineForScheduled.notificationId);
    flutterLocalNotificationsPlugin.cancel(medicineForScheduled.notificationId);
    if (this._medicineForScheduled.length != 0) {
      for (var medicines in this._medicineForScheduled) {
        String medicineJson = jsonEncode(medicines.toJson());
        medicineJsonList.add(medicineJson);
      }
    }
    sharedUser.setStringList('medicines', medicineJsonList);
    notifyListeners();
  }
}
