import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

import '../../../../core/core.dart';
import '../../../../core/utils/tz_helper.dart';
import '../../mediminder.dart';

abstract class ReminderNotificationsManager {
  final LocalNotificationManager notificationManager;
  ReminderNotificationsManager(this.notificationManager);

  Future<void> checkOneTimeNotifications();
  Future<void> createMedinicine(
    int id,
    String title,
    String description,
    TZDateTime scheduledDate,
    MedicinePeriod period,
  );
  Future<void> createHba1c(
    Hba1CReminderModel hba1cModel,
    TZDateTime scheduledDate,
  );
}

class ReminderNotificationsManagerImpl extends ReminderNotificationsManager {
  final notificationDetails = _NotificationDetails();

  ReminderNotificationsManagerImpl(LocalNotificationManager notificationManager)
      : super(notificationManager);

  @override
  Future<void> checkOneTimeNotifications() async {
    await _buildCheckNotifications(SharedPreferencesKeys.medicineList);
    await _buildCheckNotifications(SharedPreferencesKeys.bloodGlucoseList);
  }

  Future<void> _buildCheckNotifications(SharedPreferencesKeys key) async {
    final sharedList = getIt<ISharedPreferencesManager>().getStringList(key);
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
      if (item.medicinePeriod != null) {
        if (item.medicinePeriod == MedicinePeriod.oneTime) {
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
      await getIt<ISharedPreferencesManager>().setStringList(key, savedList);
    }
  }

  @override
  Future<void> createMedinicine(
    int id,
    String title,
    String description,
    TZDateTime scheduledDate,
    MedicinePeriod period,
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

  DateTimeComponents? _getDateTimeComponents(MedicinePeriod period) {
    switch (period) {
      case MedicinePeriod.oneTime:
        return null;

      case MedicinePeriod.everyDay:
        return DateTimeComponents.time;

      case MedicinePeriod.specificDays:
        return DateTimeComponents.dayOfWeekAndTime;

      case MedicinePeriod.intermittentDays:
        return null;
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
  NotificationDetails getNotificationDetails(MedicinePeriod period) {
    switch (period) {
      case MedicinePeriod.oneTime:
        return _medicineOneTime;

      case MedicinePeriod.everyDay:
        return _medicineEveryDay;

      case MedicinePeriod.specificDays:
        return _medicineSpecificDays;

      case MedicinePeriod.intermittentDays:
        throw UnimplementedError(
            "ReminderNotificationsManager - INTERMITTENT_DAYS");
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
