// ignore_for_file: unused_element

import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

import '../../../core/core.dart';
import '../../../core/utils/tz_helper.dart';
import '../mediminder.dart';

abstract class ReminderNotificationsManager {
  late final LocalNotificationManager notificationManager;
  late final ISharedPreferencesManager sharedPreferencesManager;
  ReminderNotificationsManager(
      this.notificationManager, this.sharedPreferencesManager);

  Future<void> checkOneTimeNotifications();
  Future<void> createMedinicineOrBloodGlucose(
    int id,
    String title,
    String description,
    TZDateTime scheduledDate,
    ReminderPeriod period,
  );
  Future<void> createHba1c(
    Hba1CReminderModel hba1cModel,
    TZDateTime scheduledDate,
  );
}

class ReminderNotificationsManagerImpl extends ReminderNotificationsManager {
  final notificationDetails = _NotificationDetails();

  ReminderNotificationsManagerImpl(
    LocalNotificationManager notificationManager,
    ISharedPreferencesManager sharedPreferencesManager,
  ) : super(notificationManager, sharedPreferencesManager);

  @override
  Future<void> checkOneTimeNotifications() async {
    // await _buildCheckNotifications(SharedPreferencesKeys.medicineList);
    // await _buildCheckNotifications(SharedPreferencesKeys.bloodGlucoseList);
  }

  Future<void> _buildCheckNotifications(SharedPreferencesKeys key) async {
    final sharedList = sharedPreferencesManager.getStringList(key);
    var medicineList = <BloodGlucoseReminderModel>[];
    if (sharedList != null) {
      for (String jsonMedicine in sharedList) {
        Map<String, dynamic> map = jsonDecode(jsonMedicine);
        medicineList.add(BloodGlucoseReminderModel.fromJson(map));
      }
    }

    //
    final now = TZHelper.instance.now();
    var deletedList = <BloodGlucoseReminderModel>[];
    for (var item in medicineList) {
      if (item.reminderPeriod != null) {
        if (item.reminderPeriod == ReminderPeriod.oneTime) {
          final scheduledDate =
              TZHelper.instance.fromMillisecondsSinceEpoch(item.scheduledDate);
          if (!now.isBefore(scheduledDate)) {
            deletedList.add(item);
          }
        }
      }
    }

    if (deletedList.isNotEmpty) {
      var differenceList = medicineList
          .where((item1) => !deletedList
              .any((item2) => item1.notificationId == item2.notificationId))
          .toList();
      final savedList =
          differenceList.map((e) => jsonEncode(e.toJson())).toList();
      await sharedPreferencesManager.setStringList(key, savedList);
    }
  }

  @override
  Future<void> createMedinicineOrBloodGlucose(
    int id,
    String title,
    String description,
    TZDateTime scheduledDate,
    ReminderPeriod period,
  ) async {
    await notificationManager.zonedSchedule(
      id,
      title,
      description,
      scheduledDate,
      notificationDetails.getNotificationDetails(period),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: _getDateTimeComponents(period),
    );
  }

  DateTimeComponents? _getDateTimeComponents(ReminderPeriod period) {
    switch (period) {
      case ReminderPeriod.oneTime:
        return null;

      case ReminderPeriod.everyDay:
        return DateTimeComponents.time;

      case ReminderPeriod.specificDays:
        return DateTimeComponents.dayOfWeekAndTime;
    }
  }

  @override
  Future<void> createHba1c(
    Hba1CReminderModel hba1cModel,
    TZDateTime scheduledDate,
  ) {
    return notificationManager.zonedSchedule(
      hba1cModel.notificationId,
      "Hba1c Ölçümü",
      "Hba1c ölçümü zamanınız geldi",
      scheduledDate,
      notificationDetails.hba1c,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

class _NotificationDetails {
  NotificationDetails getNotificationDetails(ReminderPeriod period) {
    switch (period) {
      case ReminderPeriod.oneTime:
        return _medicineOneTime;

      case ReminderPeriod.everyDay:
        return _medicineEveryDay;

      case ReminderPeriod.specificDays:
        return _medicineSpecificDays;
    }
  }

  final NotificationDetails _medicineOneTime = const NotificationDetails(
    android: AndroidNotificationDetails(
      'Rbio_OneTime',
      'Rbio_OneTime',
      channelDescription: 'OneTime',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
    ),
    iOS: IOSNotificationDetails(),
  );

  final NotificationDetails _medicineEveryDay = const NotificationDetails(
    android: AndroidNotificationDetails(
      'Rbio_EveryDay',
      'Rbio_EveryDay',
      channelDescription: 'EveryDay',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
    ),
    iOS: IOSNotificationDetails(),
  );

  final NotificationDetails _medicineSpecificDays = const NotificationDetails(
    android: AndroidNotificationDetails(
      'Rbio_SpecificDays',
      'Rbio_SpecificDays',
      channelDescription: 'SpecificDays',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
    ),
    iOS: IOSNotificationDetails(),
  );

  final NotificationDetails hba1c = const NotificationDetails(
    android: AndroidNotificationDetails(
      'Rbio_Hba1c',
      'Hba1c Rbio_Hba1c',
      channelDescription: 'Hba1c Measurement Needed',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
    ),
    iOS: IOSNotificationDetails(),
  );
}
