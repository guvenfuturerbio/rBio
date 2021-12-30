import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../core.dart';

// #region Top Level Variabled and Functions
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

const AndroidNotificationChannel androidNotificationChannel =
    AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

class FirebaseMessagingManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String token;

  FirebaseMessagingManager._();

  static FirebaseMessagingManager _instance;

  static FirebaseMessagingManager get instance {
    _instance ??= FirebaseMessagingManager._()..init();
    return _instance;
  }

  static void mainInit() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> init() async {
    if (!kIsWeb) {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: (payload) {
          _clickDataHandler(jsonDecode(payload));
        },
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    // Android always AuthorizationStatus.authorized.
    var notificationSettings =
        await FirebaseMessaging.instance.getNotificationSettings();
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      notificationSettings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true,
      );
    }

    switch (notificationSettings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        {
          getToken();

          // User granted permission
          await FirebaseMessaging.instance
              .setForegroundNotificationPresentationOptions(
            alert: true, // Required to display a heads up notification
            badge: true,
            sound: true,
          );

          // Uygulama Ekranda Açıkken
          FirebaseMessaging.onMessage.listen((RemoteMessage message) {
            if (!kIsWeb) {
              if (message != null) {
                _showNotification(message);
              }
            }
          });

          // Uygulama Arkaplanda Açıkken
          FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
            if (message != null) {
              _clickDataHandler(message.data);
            }
          });

          // Uygulama Kapalı İken.
          await FirebaseMessaging.instance
              .getInitialMessage()
              .then((RemoteMessage message) {
            if (message != null) {
              _clickDataHandler(message.data);
            }
          });

          break;
        }

      case AuthorizationStatus.provisional:
        {
          // User granted provisional permission
          break;
        }

      default:
        {
          // User declined or has not accepted permission
          break;
        }
    }

    // setupInteractedMessage();
  }

  void _showNotification(RemoteMessage message) {
    final notificationType = getNotificationType(message.data);
    if (notificationType == null) return;

    switch (notificationType) {
      case NotificationType.chat:
        {
          if (!Atom.url.contains(PagePaths.CHAT)) {
            flutterLocalNotificationsShow(
              message.hashCode,
              message.notification.title,
              message.notification.body,
              jsonEncode(message.data),
            );
          }

          break;
        }

      case NotificationType.route:
        {
          break;
        }
    }
  }

  void flutterLocalNotificationsShow(
    int id,
    String title,
    String body,
    String payload,
  ) {
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        iOS: IOSNotificationDetails(),
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: androidNotificationChannel.description,
          icon: 'launch_background',
        ),
      ),
      payload: payload,
    );
  }

  NotificationType getNotificationType(Map<String, dynamic> data) {
    if (data == null) return null;
    final type = data['type'] as String;
    if (type == null) return null;
    return type.xNotificationTypeKeys;
  }

  Future<void> _clickDataHandler(Map<String, dynamic> data) async {
    final notificationType = getNotificationType(data);
    if (notificationType == null) return;

    switch (notificationType) {
      case NotificationType.chat:
        {
          Atom.to(PagePaths.CONSULTATION);
          break;
        }

      case NotificationType.route:
        {
          final parameters = data['parameters'];
          final route = data['route'];
          if (parameters != null) {
            Atom.to(route, queryParameters: parameters);
          } else {
            Atom.to(route);
          }

          break;
        }
    }
  }

  Future<void> getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    LoggerUtils.instance.i('FirebaseToken :: ' + token);
  }
}

enum NotificationType {
  chat,
  route,
}

extension NotificationTypeStringExt on String {
  NotificationType get xNotificationTypeKeys => NotificationType.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension NotificationTypeExt on NotificationType {
  String get xRawValue => GetEnumValue(this);
}
