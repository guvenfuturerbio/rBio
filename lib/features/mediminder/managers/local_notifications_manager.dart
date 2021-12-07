import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

import '../../../core/core.dart';
import '../mediminder.dart';

// ignore_for_file: deprecated_member_use

abstract class LocalNotificationsManager {
  Future<void> cancel(int id, {String tag});
  Future<void> showNotification(
    String title,
    String description, {
    String payload,
  });
  Future<void> createMedicineSpecificDays(
    int id,
    String title,
    String body,
    Day day,
    Time notificationTime,
  );
  Future<void> createMedicineEveryDay(
    int id,
    String title,
    String body,
    Time notificationTime,
  );
  Future<void> createHba1c(
    Hba1CForScheduleModel hba1cModel,
    TZDateTime scheduledDate,
  );
}

class LocalNotificationsManagerImpl extends LocalNotificationsManager {
  final plugin = FlutterLocalNotificationsPlugin();
  final notificationDetails = _NotificationDetails();

  @override
  Future<void> cancel(int id, {String tag}) => plugin.cancel(id, tag: tag);

  @override
  Future<void> showNotification(
    String title,
    String description, {
    String payload,
  }) async {
    final id = Random().nextInt(1000) * 10;
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      id.toString(),
      title,
      channelDescription: description,
      importance: Importance.max,
      priority: Priority.high,
    );

    final iosPlatformChannelSpecificts = IOSNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecificts,
    );

    await plugin.show(
      id,
      title,
      description,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  @override
  Future<void> createMedicineSpecificDays(
    int id,
    String title,
    String body,
    Day day,
    Time notificationTime,
  ) =>
      plugin.showWeeklyAtDayAndTime(
        id,
        title,
        body,
        day,
        notificationTime,
        notificationDetails.medicineSpecificDays,
      );

  @override
  Future<void> createMedicineEveryDay(
    int id,
    String title,
    String body,
    Time notificationTime,
  ) =>
      plugin.showDailyAtTime(
        id,
        title,
        body,
        notificationTime,
        notificationDetails.medicineEveryDay,
      );

  @override
  Future<void> createHba1c(
    Hba1CForScheduleModel hba1cModel,
    TZDateTime scheduledDate,
  ) =>
      plugin.zonedSchedule(
        hba1cModel.id,
        "Hba1c Ölçümü",
        "Hba1c ölçümü zamanınız geldi",
        scheduledDate,
        notificationDetails.hba1c,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
}

class _NotificationDetails {
  NotificationDetails medicineEveryDay = NotificationDetails(
    android: AndroidNotificationDetails(
      'Rbio_EveryDay',
      'Rbio_EveryDay',
      channelDescription: 'EveryDay',
      importance: Importance.max,
      ledColor: getIt<ITheme>().mainColor,
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
    ),
    iOS: IOSNotificationDetails(),
  );

  NotificationDetails medicineSpecificDays = NotificationDetails(
    android: AndroidNotificationDetails(
      'Rbio_SpecificDays',
      'Rbio_SpecificDays',
      channelDescription: 'SpecificDays',
      importance: Importance.max,
      ledColor: getIt<ITheme>().mainColor,
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
    ),
    iOS: IOSNotificationDetails(),
  );

  NotificationDetails hba1c = NotificationDetails(
    android: AndroidNotificationDetails(
      'Rbio_Hba1c',
      'Hba1c Rbio_Hba1c',
      channelDescription: 'Hba1c Measurement Needed',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    ),
    iOS: IOSNotificationDetails(),
  );
}
