// ignore_for_file: unused_element

import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

import '../../../core/core.dart';
import '../../../core/utils/helper/tz_helper.dart';
import '../mediminder.dart';

abstract class ReminderNotificationsManager {
  late final LocalNotificationManager notificationManager;
  late final ISharedPreferencesManager sharedPreferencesManager;
  ReminderNotificationsManager(
      this.notificationManager, this.sharedPreferencesManager);

  Future<void> checkOneTimeNotifications();
  Future<void> createNotification(
    Remindable remindable,
    int id,
    String title,
    TZDateTime scheduledDate,
    ReminderPeriod period,
  );
  Future<void> createMedinicine(
    int id,
    String title,
    TZDateTime scheduledDate,
    ReminderPeriod period,
  );
  Future<void> createBloodGlucose(
    int id,
    TZDateTime scheduledDate,
    ReminderPeriod period,
  );
  Future<void> createHba1c(
    int id,
    TZDateTime scheduledDate,
  );
  Future<void> createPostponeNotification(
    TZDateTime scheduledDate,
    ReminderNotificationModel model,
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
  Future<void> createNotification(
    Remindable remindable,
    int id,
    String title,
    TZDateTime scheduledDate,
    ReminderPeriod period,
  ) async {
    //
  }

  @override
  Future<void> createMedinicine(
    int id,
    String title,
    TZDateTime scheduledDate,
    ReminderPeriod period,
  ) async {
    await notificationManager.zonedSchedule(
      id,
      title,
      LocaleProvider.current.time_take_medicine,
      scheduledDate,
      notificationDetails.getNotificationDetails(period),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: _getDateTimeComponents(period),
      payload: LocalNotificationModel(
        type: LocalNotificationType.reminder,
        data: ReminderNotificationModel(
          notificationId: id,
          remindable: Remindable.medication,
          title: title,
          description: LocaleProvider.current.time_take_medicine,
        ).toJsonString(),
      ).toJsonString(),
    );
  }

  @override
  Future<void> createBloodGlucose(
    int id,
    TZDateTime scheduledDate,
    ReminderPeriod period,
  ) async {
    await notificationManager.zonedSchedule(
      id,
      LocaleProvider.current.blood_glucose_measurement,
      LocaleProvider.current.bg_measurement_time,
      scheduledDate,
      notificationDetails.getNotificationDetails(period),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: _getDateTimeComponents(period),
      payload: LocalNotificationModel(
        type: LocalNotificationType.reminder,
        data: ReminderNotificationModel(
          notificationId: id,
          remindable: Remindable.bloodGlucose,
          title: LocaleProvider.current.blood_glucose_measurement,
          description: LocaleProvider.current.bg_measurement_time,
        ).toJsonString(),
      ).toJsonString(),
    );
  }

  @override
  Future<void> createHba1c(
    int id,
    TZDateTime scheduledDate,
  ) {
    return notificationManager.zonedSchedule(
      id,
      LocaleProvider.current.hbA1c_measurement_title,
      LocaleProvider.current.time_hba1c,
      scheduledDate,
      notificationDetails.hba1c,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: LocalNotificationModel(
        type: LocalNotificationType.reminder,
        data: ReminderNotificationModel(
          notificationId: id,
          remindable: Remindable.hbA1c,
          title: LocaleProvider.current.hbA1c_measurement_title,
          description: LocaleProvider.current.time_hba1c,
        ).toJsonString(),
      ).toJsonString(),
    );
  }

  @override
  Future<void> createPostponeNotification(
    TZDateTime scheduledDate,
    ReminderNotificationModel model,
  ) async {
    LoggerUtils.instance.i("BURADA");
    LoggerUtils.instance.i(scheduledDate);
    return notificationManager.zonedSchedule(
      model.notificationId,
      model.title ?? '',
      model.description ?? '',
      scheduledDate,
      _getPosponeDetails(model),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: LocalNotificationModel(
        type: LocalNotificationType.reminder,
        data: model.toJsonString(),
      ).toJsonString(),
    );
  }

  NotificationDetails _getPosponeDetails(
    ReminderNotificationModel model,
  ) {
    switch (model.remindable) {
      case Remindable.bloodGlucose:
        return notificationDetails
            .getNotificationDetails(ReminderPeriod.oneTime);

      case Remindable.medication:
        return notificationDetails
            .getNotificationDetails(ReminderPeriod.oneTime);

      case Remindable.hbA1c:
        return notificationDetails.hba1c;

      case Remindable.strip:
      default:
        throw Exception("Unsupported");
    }
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
