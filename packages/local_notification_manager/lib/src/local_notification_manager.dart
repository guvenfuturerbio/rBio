import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

String? selectedNotificationPayload;

// void _notificationTapBackground(NotificationActionDetails details) {
//   debugPrint(
//       'notification(${details.id}) action tapped: ${details.actionId} with payload: ${details.payload}');
//   if (details.input?.isNotEmpty ?? false) {
//     debugPrint('notification action tapped with input: ${details.input}');
//   }
// }

abstract class LocalNotificationManager {
  final void Function(dynamic message) logger;
  LocalNotificationManager(this.logger);

  bool get didNotificationLaunchApp;
  BehaviorSubject<String>? selectNotificationSubject;
  BehaviorSubject<ReceivedNotification>? didReceiveLocalNotificationSubject;

  Future<NotificationAppLaunchDetails?> init();
  void requestPermissions();
  Future<void> cancelNotification(int id, {String? tag});
  Future<void> cancelAllNotifications();
  Future<List<PendingNotificationRequest>> pendingNotificationRequests();

  /// Bildirim hemen gösterilir.
  Future<void> show(
    String title,
    String body, {
    String? payload,
    NotificationDetails? notificationDetails,
  });

  /// Bildirim hemen gösterilir.
  Future<void> showWithId(
    int id,
    String title,
    String body, {
    String? payload,
    NotificationDetails? notificationDetails,
  });

  /// Örnek1 : Bildirimi yerel saat dilimine (local time zone) göre 5 saniye içinde görünecek şekilde planlayın
  ///
  /// Bildirim görüntülendikten sonra pending durumunda gözükmez.
  ///
  /// scheduledDate: Now = 2022-01-29 09:24:21.032457+0300 || Parameter = 2022-01-29 09:24:26.032457+0300
  ///
  /// uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
  ///
  /// ---------------------------------------------------------------------------
  ///
  /// Örnek2 : Yerel saat diliminizde günlük 10:00:00 bildirimini planlayın
  ///
  /// scheduledDate: Now = 2022-01-29 09:26:43.073975+0300 || Parameter = 2022-01-29 10:00:00.000+0300
  ///
  /// uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
  ///
  /// matchDateTimeComponents: DateTimeComponents.time
  ///
  /// ---------------------------------------------------------------------------
  ///
  /// Örnek3 : Yerel saat diliminizde haftalık 10:00:00 bildirimini planlayın
  ///
  /// scheduledDate: Now = 2022-01-29 09:26:43.073975+0300 || Parameter = 2022-01-29 10:00:00.000+0300
  ///
  /// uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
  ///
  /// matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
  ///
  /// ---------------------------------------------------------------------------
  ///
  /// Örnek4 : Aylık Pazartesi 10:00:00 bildirimini yerel saat diliminize göre planlayın
  ///
  /// scheduledDate: Now = 2022-01-29 09:27:59.092806+0300 || Parameter = 2022-01-31 10:00:00.000+0300
  ///
  /// uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
  ///
  /// matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime
  ///
  /// ---------------------------------------------------------------------------
  ///
  /// Örnek5 : Yerel saat diliminizde her yıl Pazartesi 10:00:00 bildirimini planlayın
  ///
  /// scheduledDate: Now = 2022-01-29 09:27:59.092806+0300 || Parameter = 2022-01-31 10:00:00.000+0300
  ///
  /// uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
  ///
  /// matchDateTimeComponents: DateTimeComponents.dateAndTime
  ///
  /// ---------------------------------------------------------------------------
  Future<void> zonedSchedule(
    int id,
    String title,
    String body,
    tz.TZDateTime scheduledDate,
    NotificationDetails notificationDetails, {
    required UILocalNotificationDateInterpretation
        uiLocalNotificationDateInterpretation,
    required bool androidAllowWhileIdle,
    String? payload,
    DateTimeComponents? matchDateTimeComponents,
  });

  /// Örnek1 : Bildirimi oluşturduğumuz andan itibaren her 1 dk'da bildirim planlayın (Bildirim görüntülense bile pending durumunda gözükür)
  ///
  /// repeatInterval: RepeatInterval.everyMinute
  ///
  /// ---------------------------------------------------------------------------
  Future<void> periodicallyShow(
    int id,
    String title,
    String body,
    RepeatInterval repeatInterval,
    NotificationDetails notificationDetails, {
    String? payload,
    bool androidAllowWhileIdle = false,
  });
}

class LocalNotificationManagerImpl extends LocalNotificationManager {
  LocalNotificationManagerImpl(void Function(dynamic message) logger)
      : super(logger);

  NotificationAppLaunchDetails? _notificationAppLaunchDetails;

  @override
  bool get didNotificationLaunchApp =>
      _notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  @override
  final BehaviorSubject<String>? selectNotificationSubject =
      BehaviorSubject<String>();

  @override
  final BehaviorSubject<ReceivedNotification>?
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  // #region init
  @override
  Future<NotificationAppLaunchDetails?> init() async {
    await _configureLocalTimeZone();
    await _configureLaunchDetails();
    await _configurePlugin();
    if (!kIsWeb) await _printPendingNotifications();
    return _notificationAppLaunchDetails;
  }

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String timeZoneName =
        await FlutterNativeTimezone.getLocalTimezone(); // Europe/Istanbul
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> _configureLaunchDetails() async {
    _notificationAppLaunchDetails = !kIsWeb && Platform.isLinux
        ? null
        : await flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();

    if (_notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = _notificationAppLaunchDetails?.payload;
    }
  }

  Future<void> _configurePlugin() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject!.add(
          ReceivedNotification(
            id: id,
            title: title ?? '',
            body: body ?? '',
            payload: payload ?? '',
          ),
        );
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // Uygulama ekranda yada arkaplanda açıkken bildirime dokunulursa çalışıyor.
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('Notification Payload: $payload');
          selectNotificationSubject!.add(payload);
        }
      },
      // backgroundHandler: _notificationTapBackground,
    );
  }
  // #endregion

  // #region _printPendingNotifications
  Future<void> _printPendingNotifications() async {
    logger(
        '[LocalNotificationManager] ----------- Pending Notifications -----------');
    final pendingNotifications = await pendingNotificationRequests();
    var pendingList = <Map<String, dynamic>>[];
    for (var item in pendingNotifications) {
      final itemMap = {
        'id': item.id,
        'title': item.title,
        'body': item.body,
        'payload': item.payload,
      };
      pendingList.add(itemMap);
    }
    logger(pendingList);
    logger('[LocalNotificationManager] -----------');
  }
  // #endregion

  // #region requestPermissions
  @override
  void requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
  // #endregion

  // #region cancelNotification
  @override
  Future<void> cancelNotification(int id, {String? tag}) async {
    await flutterLocalNotificationsPlugin.cancel(id, tag: tag);
  }
  // #endregion

  // #region cancelAllNotifications
  @override
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
  // #endregion

  // #region pendingNotificationRequests
  @override
  Future<List<PendingNotificationRequest>> pendingNotificationRequests() =>
      flutterLocalNotificationsPlugin.pendingNotificationRequests();
  // #endregion

  // #region show
  @override
  Future<void> show(
    String title,
    String body, {
    String? payload,
    NotificationDetails? notificationDetails,
  }) async {
    var notificationIds = <int>[];
    final pendingNotifications = await pendingNotificationRequests();
    for (var item in pendingNotifications) {
      notificationIds.add(item.id);
    }

    var id = 0;
    while (id == 0) {
      id = Random().nextInt(1000) * 10;
      if (notificationIds.contains(id)) {
        id = 0;
      }
    }

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "android_channel",
      title,
      channelDescription: body,
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosPlatformChannelSpecificts = IOSNotificationDetails();

    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecificts,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
  // #endregion

  @override
  Future<void> showWithId(
    int id,
    String title,
    String body, {
    String? payload,
    NotificationDetails? notificationDetails,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // #region zonedSchedule
  @override
  Future<void> zonedSchedule(
    int id,
    String title,
    String body,
    tz.TZDateTime scheduledDate,
    NotificationDetails notificationDetails, {
    required UILocalNotificationDateInterpretation
        uiLocalNotificationDateInterpretation,
    required bool androidAllowWhileIdle,
    String? payload,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          uiLocalNotificationDateInterpretation,
      androidAllowWhileIdle: androidAllowWhileIdle,
      payload: payload,
      matchDateTimeComponents: matchDateTimeComponents,
    );
  }
  // #endregion

  // #region periodicallyShow
  @override
  Future<void> periodicallyShow(
    int id,
    String title,
    String body,
    RepeatInterval repeatInterval,
    NotificationDetails notificationDetails, {
    String? payload,
    bool androidAllowWhileIdle = false,
  }) async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      notificationDetails,
      payload: payload,
      androidAllowWhileIdle: androidAllowWhileIdle,
    );
  }
  // #endregion
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}
