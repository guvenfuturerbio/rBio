import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onedosehealth/core/utils/tz_helper.dart';

import '../../../../core/core.dart';
import '../../mediminder.dart';

class BloodGlucoseReminderListVm extends ChangeNotifier {
  late BuildContext mContext;
  BloodGlucoseReminderListVm(this.mContext) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await fetchAll();
    });
  }

  List<BloodGlucoseReminderModel> medicineForScheduled = [];

  Future<void> fetchAll() async {
    List<String>? jsonList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.bloodGlucoseList);
    List<BloodGlucoseReminderModel> prefList = [];
    if (jsonList != null) {
      for (String jsonMedicine in jsonList) {
        Map<String, dynamic> jsonMap = jsonDecode(jsonMedicine);
        prefList.add(BloodGlucoseReminderModel.fromJson(jsonMap));
      }
      medicineForScheduled = prefList;
      notifyListeners();
    }
  }

  Future<void> removeAllMedicines(int createdDate) async {
    // Notificationlar'ı iptal et
    await Future.forEach<BloodGlucoseReminderModel>(
      medicineForScheduled,
      (item) async {
        if (item.createdDate == createdDate) {
          // Notification'ı iptal et
          await getIt<LocalNotificationManager>()
              .cancelNotification(item.notificationId);
        }
      },
    );

    // Vm'de ki listeden itemları'ı sil
    medicineForScheduled
        .removeWhere((medicine) => medicine.createdDate == createdDate);

    // Shared Preferences'da ki listeyi güncelle
    await _saveList();

    notifyListeners();
  }

  Future<void> removeMedicine(BloodGlucoseReminderModel item) async {
    // Vm'de ki listeden item'ı sil
    medicineForScheduled.removeWhere(
        (medicine) => medicine.notificationId == item.notificationId);

    // Notification'ı iptal et
    await getIt<LocalNotificationManager>()
        .cancelNotification(item.notificationId);

    // Shared Preferences'da ki listeyi güncelle
    await _saveList();

    notifyListeners();
  }

  Future<void> _saveList() async {
    List<String> medicineJsonList = [];
    if (medicineForScheduled.isNotEmpty) {
      for (var medicines in medicineForScheduled) {
        String medicineJson = jsonEncode(medicines.toJson());
        medicineJsonList.add(medicineJson);
      }
    }
    await getIt<ISharedPreferencesManager>().setStringList(
        SharedPreferencesKeys.bloodGlucoseList, medicineJsonList);
  }

  String getSubTitle(BloodGlucoseReminderModel medicine) {
    String result = "";

    final medicinePeriod = medicine.medicinePeriod;

    if (medicinePeriod != null) {
      if (medicinePeriod == MedicinePeriod.specificDays) {
        result += LocaleProvider.current.every;
        result += " ";
        result += _getDayString(medicine.dayIndex);
        result += ", " + medicine.usageType.xGetText;
      } else {
        result += _getPeriodString(medicine.medicinePeriod);
        result += ", " + medicine.usageType.xGetText;

        final remindable = medicine.remindable;
        if (remindable == Remindable.medication) {
          result += ", " +
              medicine.dailyDose.toString() +
              " " +
              LocaleProvider.current.hint_dosage;
        }
      }
    }

    return result;
  }

  String _getPeriodString(MedicinePeriod? period) {
    if (period == null) return '';

    switch (period) {
      case MedicinePeriod.oneTime:
        return LocaleProvider.of(mContext).one_time;

      case MedicinePeriod.everyDay:
        return LocaleProvider.of(mContext).every_day;

      case MedicinePeriod.specificDays:
        return LocaleProvider.of(mContext).specific_days;

      case MedicinePeriod.intermittentDays:
        return LocaleProvider.of(mContext).intermittent_days;

      default:
        return '';
    }
  }

  String _getDayString(int? dayIndex) {
    if (dayIndex == null) return '';

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

  Future<void> updateMedicineForScheduledModel(
    TimeOfDay newTimeOfDay,
    BloodGlucoseReminderModel selectedItem,
  ) async {
    // Bildirimin Title ve Body değerlerine erişmek için, pending listeyi getir
    final pendingNotifications =
        await getIt<LocalNotificationManager>().pendingNotificationRequests();
    final pendingItem = pendingNotifications
        .firstWhere((element) => element.id == selectedItem.notificationId);

    // Geçerli bildirim saatinin sadece saat ve dakikaasını güncelle
    final oldScheduledDate = TZHelper.instance
        .fromMillisecondsSinceEpoch(selectedItem.scheduledDate);
    final newScheduledDate =
        TZHelper.instance.changeOnlyHourMinutes(oldScheduledDate, newTimeOfDay);

    // Geçerli bildirimi iptal et
    await getIt<LocalNotificationManager>()
        .cancelNotification(selectedItem.notificationId);

    // Yeni bildirim oluştur
    await getIt<ReminderNotificationsManager>().createMedinicineOrBloodGlucose(
      selectedItem.notificationId,
      pendingItem.title ?? '',
      pendingItem.body ?? '',
      newScheduledDate,
      selectedItem.medicinePeriod ?? MedicinePeriod.oneTime,
    );

    // View modelde ki listeyi güncelle
    final medicineIndex = medicineForScheduled.indexWhere(
        (element) => element.notificationId == selectedItem.notificationId);
    medicineForScheduled = medicineForScheduled.update(
      medicineIndex,
      medicineForScheduled[medicineIndex].changeScheduledDate(
        scheduledDate: newScheduledDate.millisecondsSinceEpoch,
      ),
    );

    // Shared Preferences'da ki listeyi güncelle
    await _saveList();

    notifyListeners();
  }
}
