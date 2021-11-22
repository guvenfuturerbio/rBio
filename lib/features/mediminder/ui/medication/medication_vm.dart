import 'dart:convert';

import 'package:flutter/material.dart';

import '../../common/mediminder_common.dart';

class MedicationVm extends ChangeNotifier {
  BuildContext mContext;
  MedicationVm(this.mContext) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAll();
    });
  }

  List<MedicineForScheduledModel> _medicineForScheduled;
  List<MedicineForScheduledModel> get medicineForScheduled =>
      this._medicineForScheduled ?? [];

  Future<void> fetchAll() async {
    List<String> jsonList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.medicines);
    List<MedicineForScheduledModel> prefList = [];
    if (jsonList != null) {
      for (String jsonMedicine in jsonList) {
        Map<String, dynamic> jsonMap = jsonDecode(jsonMedicine);
        prefList.add(MedicineForScheduledModel.fromJson(jsonMap));
      }
      this._medicineForScheduled = prefList;
      notifyListeners();
    }
  }

  Future<void> removeMedicine(
      MedicineForScheduledModel medicineForScheduled) async {
    // Vm'de ki listeden item'ı sil
    this._medicineForScheduled.removeWhere((medicine) =>
        medicine.notificationId == medicineForScheduled.notificationId);

    // Notification'ı iptal et
    getIt<LocalNotificationsManager>()
        .cancel(medicineForScheduled.notificationId);

    // Shared Preferences'da ki listeyi güncelle
    List<String> medicineJsonList = [];
    if (this._medicineForScheduled.length != 0) {
      for (var medicines in this._medicineForScheduled) {
        String medicineJson = jsonEncode(medicines.toJson());
        medicineJsonList.add(medicineJson);
      }
    }
    await getIt<ISharedPreferencesManager>()
        .setStringList(SharedPreferencesKeys.medicines, medicineJsonList);

    notifyListeners();
  }

  String getSubTitle(MedicineForScheduledModel medicine) {
    if (medicine.medicinePeriod == MedicinePeriod.SPECIFIC_DAYS.toString()) {
      return LocaleProvider.current.every +
          " " +
          _getDayString(medicine.dayIndex) +
          (", " + _getUsageType(medicine.usageType));
    } else {
      return _getPeriodString(medicine.medicinePeriod) +
          (", " + _getUsageType(medicine.usageType)) +
          (medicine.remindable == Remindable.Medication.toString()
              ? ", " +
                  medicine.dosage.toString() +
                  " " +
                  LocaleProvider.current.hint_dosage
              : " ");
    }
  }

  String _getPeriodString(String period) {
    if (period == MedicinePeriod.EVERY_DAY.toString()) {
      return LocaleProvider.of(mContext).every_day;
    } else if (period == MedicinePeriod.SPECIFIC_DAYS.toString()) {
      return LocaleProvider.of(mContext).specific_days;
    } else {
      return LocaleProvider.of(mContext).intermittent_days;
    }
  }

  String _getDayString(int dayIndex) {
    final newIndex = dayIndex + 1;
    if (newIndex == 1) {
      return LocaleProvider.of(mContext).weekdays_monday;
    } else if (newIndex == 2) {
      return LocaleProvider.of(mContext).weekdays_tuesday;
    } else if (newIndex == 3) {
      return LocaleProvider.of(mContext).weekdays_wednesday;
    } else if (newIndex == 4) {
      return LocaleProvider.of(mContext).weekdays_thursday;
    } else if (newIndex == 5) {
      return LocaleProvider.of(mContext).weekdays_friday;
    } else if (newIndex == 6) {
      return LocaleProvider.of(mContext).weekdays_saturday;
    } else if (newIndex == 7) {
      return LocaleProvider.of(mContext).weekdays_sunday;
    } else {
      return "";
    }
  }

  String _getUsageType(String usageType) {
    if (usageType == UsageType.FULL.toString()) {
      return LocaleProvider.of(mContext).full;
    } else if (usageType == UsageType.IRRELEVANT.toString()) {
      return LocaleProvider.of(mContext).irrelevant;
    } else {
      return LocaleProvider.of(mContext).hungry;
    }
  }
}
