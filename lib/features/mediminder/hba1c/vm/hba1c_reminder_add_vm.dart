import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/utils/tz_helper.dart';
import '../../mediminder.dart';

class Hba1cReminderAddVm extends ChangeNotifier {
  BuildContext mContext;
  Remindable mRemindable;

  Hba1cReminderAddVm(this.mContext, this.mRemindable);

  final random = Random();

  String remindDate = "";
  Future<void> setRemindDate(String time) async {
    remindDate = time;
    notifyListeners();
  }

  TimeOfDay? remindHour;
  Future<void> setRemindHour(TimeOfDay time) async {
    remindHour = time;
    notifyListeners();
  }

  String lastMeasurementDate = "";
  Future<void> setLastMeasurementDate(String time) async {
    lastMeasurementDate = time;
    remindDate = (DateTime.parse(time).add(const Duration(days: 90)))
            .isBefore(DateTime.now().add(const Duration(minutes: 5)))
        ? DateTime.now().add(const Duration(minutes: 5)).toString()
        : (DateTime.parse(time).add(const Duration(days: 90))).toString();
    notifyListeners();
  }

  double previousResult = 0;
  Future<void> setPreviousResult(double result) async {
    previousResult = result;
    notifyListeners();
  }

  Future<void> createNotification() async {
    final isValid = _checkValidation();
    if (!isValid) return;

    List<int> pendingList =
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

    final lastMeasurementDateTime = DateTime.parse(lastMeasurementDate);
    var lastMeasurementDateTimeTZ =
        TZHelper.instance.from(lastMeasurementDateTime.toString());

    final remindDateTime = DateTime.parse(remindDate)
        .add(Duration(hours: remindHour?.hour ?? 0))
        .add(Duration(minutes: remindHour?.minute ?? 0));
    var remindDateTimeTZ = TZHelper.instance.from(remindDateTime.toString());
    final currentHbaModel = Hba1CReminderModel(
      notificationId: numberList.first,
      scheduledDate: remindDateTimeTZ.millisecondsSinceEpoch,
      createdDate: TZHelper.instance.now().millisecondsSinceEpoch,
      entegrationId: getIt<ProfileStorageImpl>().getFirst().id ?? 0,
      lastTestDate: lastMeasurementDateTimeTZ.millisecondsSinceEpoch.toString(),
      lastTestValue: previousResult.toString(),
    );

    await getIt<ReminderNotificationsManager>().createHba1c(
      currentHbaModel,
      remindDateTimeTZ,
    );
    await saveScheduledHba1c(currentHbaModel);
    Atom.historyBack();
  }

  bool _checkValidation() {
    if ((lastMeasurementDate == '') ||
        (remindDate == '') ||
        (remindHour == null)) {
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
    String newHba1cJson = jsonEncode(hba1c.toJson());
    List<String> hba1cJsonList = [];

    final sharedList = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.hba1cList);
    if (sharedList != null) {
      hba1cJsonList = sharedList;
    }

    hba1cJsonList.add(newHba1cJson);
    await getIt<ISharedPreferencesManager>().setStringList(
      SharedPreferencesKeys.hba1cList,
      hba1cJsonList,
    );
  }
}
