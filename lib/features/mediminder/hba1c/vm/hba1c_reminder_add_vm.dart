import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/utils/tz_helper.dart';
import '../../mediminder.dart';

class Hba1cReminderAddVm extends ChangeNotifier {
  late final BuildContext mContext;
  late final ReminderRepository reminderRepository;
  late final int? notificationId;
  int? createdDate;

  Hba1cReminderAddVm(
    this.mContext,
    this.notificationId,
    this.reminderRepository,
  ) {
    // Edit Mode
    if (notificationId != null) {
      final localModel = reminderRepository.getHba1CById(notificationId!);
      if (localModel != null) {
        createdDate = localModel.createdDate;
        final remindDate = localModel.scheduledDate.xGetTZDateTime;
        scheduledDate = remindDate.toString();
        scheduledHour = TimeOfDay(
          hour: remindDate.hour,
          minute: remindDate.minute,
        );
        lastTestDate = localModel.lastTestDate!.xGetTZDateTime.toString();
        lastTestValue = localModel.lastTestValue ?? 0;
        notifyListeners();
      }
    }
  }

  final random = Random();

  String scheduledDate = "";
  Future<void> setScheduledDate(String time) async {
    scheduledDate = time;
    notifyListeners();
  }

  TimeOfDay? scheduledHour;
  Future<void> setScheduledHour(TimeOfDay time) async {
    scheduledHour = time;
    notifyListeners();
  }

  String lastTestDate = "";
  Future<void> setLastTestDate(String time) async {
    lastTestDate = time;
    scheduledDate = (DateTime.parse(time).add(const Duration(days: 90)))
            .isBefore(DateTime.now().add(const Duration(minutes: 5)))
        ? DateTime.now().add(const Duration(minutes: 5)).toString()
        : (DateTime.parse(time).add(const Duration(days: 90))).toString();
    notifyListeners();
  }

  double lastTestValue = 0;
  Future<void> setLastTestValue(double value) async {
    lastTestValue = value;
    notifyListeners();
  }

  Future<void> createNotification(bool isCreated) async {
    final isValid = _checkValidation();
    if (!isValid) return;

    //
    if (!isCreated) {
      // Bu plana ait tüm bildirimleri sil ve iptal et.
      await reminderRepository.cancelAndRemoveNotificationHba1C(createdDate!);
    }

    final pendingList =
        await getIt<LocalNotificationManager>().getPendingNotificationIds();

    List<int> numberList = [];
    while (numberList.length <= 1) {
      int randomNumber = 10000 + random.nextInt(1000);
      // Prevent Generate Duplicate Ids
      if (!numberList.contains(randomNumber) &&
          !pendingList.contains(randomNumber)) {
        numberList.add(randomNumber.toInt());
      }
    }

    final lastMeasurementDateTime = DateTime.parse(lastTestDate);
    var lastMeasurementDateTimeTZ =
        TZHelper.instance.from(lastMeasurementDateTime.toString());

    final scheduledDateTime = DateTime.parse(scheduledDate);
    final remindDateTime = DateTime(scheduledDateTime.year,
            scheduledDateTime.month, scheduledDateTime.day)
        .add(Duration(hours: scheduledHour?.hour ?? 0))
        .add(Duration(minutes: scheduledHour?.minute ?? 0));
    var remindDateTimeTZ = TZHelper.instance.from(remindDateTime.toString());
    final currentHbaModel = Hba1CReminderModel(
      notificationId: numberList.first,
      scheduledDate: remindDateTimeTZ.millisecondsSinceEpoch,
      createdDate: TZHelper.instance.now().millisecondsSinceEpoch,
      entegrationId: getIt<ProfileStorageImpl>().getFirst().id ?? 0,
      lastTestDate: lastMeasurementDateTimeTZ.millisecondsSinceEpoch,
      lastTestValue: lastTestValue,
    );

    try {
      await getIt<ReminderNotificationsManager>().createHba1c(
        currentHbaModel,
        remindDateTimeTZ,
      );

      await saveScheduledHba1c(currentHbaModel);

      Atom.historyBack();
    } catch (e) {
      if (e.toString().contains(
          'Invalid argument (scheduledDate): Must be a date in the future')) {
        LoggerUtils.instance.i("Geçmişe hatırlatıcı oluşturulamaz.");
      }
    }
  }

  bool _checkValidation() {
    if ((lastTestDate == '') ||
        (scheduledDate == '') ||
        (scheduledHour == null)) {
      showInformationDialog();
      return false;
    }

    return true;
  }

  void showInformationDialog() {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GradientDialog(
          title: LocaleProvider.current.warning,
          text: LocaleProvider.current.fill_all_field,
        );
      },
    );
  }

  Future<void> saveScheduledHba1c(Hba1CReminderModel hba1c) async {
    final newHba1cJson = jsonEncode(hba1c.toJson());
    final sharedList = getIt<ISharedPreferencesManager>()
            .getStringList(SharedPreferencesKeys.hba1cList) ??
        [];
    sharedList.add(newHba1cJson);
    await getIt<ISharedPreferencesManager>().setStringList(
      SharedPreferencesKeys.hba1cList,
      sharedList,
    );
  }
}
