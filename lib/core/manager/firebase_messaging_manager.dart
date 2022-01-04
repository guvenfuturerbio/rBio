import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../features/chat/model/chat_person.dart';
import '../../model/model.dart';
import '../core.dart';

// #region Top Level Variabled and Functions
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("bbbbb");
  FirebaseMessagingManager.showNotification(message);
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel androidNotificationChannel =
    AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
  sound: RawResourceAndroidNotificationSound('chat_bildirim'),
  playSound: true,
);

class FirebaseMessagingManager {
  String token;

  FirebaseMessagingManager._();

  static FirebaseMessagingManager _instance;

  static FirebaseMessagingManager get instance {
    _instance ??= FirebaseMessagingManager._()..init();
    return _instance;
  }

  static handleLogout() {
    _instance = null;
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
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: (payload) {
          clickDataHandler(jsonDecode(payload));
        },
      );
    }
    final initialPayload =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (initialPayload?.payload != null) {
      clickDataHandler(json.decode(initialPayload.payload));
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
                ChatPerson otherPerson =
                    ChatPerson.fromMap(json.decode(message.data['chatPerson']));

                if (!(Atom.url.contains(PagePaths.CHAT) &&
                    Atom.url.contains(otherPerson.id)))
                  showNotification(message);
              }
            }
          });

          // Uygulama Arkaplanda Açıkken
          FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
            if (message != null) {
              clickDataHandler(message.data);
            }
          });

          // Uygulama Kapalı İken.
          await FirebaseMessaging.instance
              .getInitialMessage()
              .then((RemoteMessage message) {
            if (message != null) {
              clickDataHandler(message.data);
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

  static void showNotification(RemoteMessage message) {
    final notificationType = getNotificationType(message.data);
    if (notificationType == null) return;

    switch (notificationType) {
      case NotificationType.chat:
        {
          {
            flutterLocalNotificationsShow(
              message.hashCode,
              message.data['title'],
              message.data['body'],
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

  static void flutterLocalNotificationsShow(
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

  static NotificationType getNotificationType(Map<String, dynamic> data) {
    if (data == null) return null;
    final type = data['type'] as String;
    if (type == null) return null;
    return type.xNotificationTypeKeys;
  }

  Future<void> clickDataHandler(Map<String, dynamic> data) async {
    final notificationType = getNotificationType(data);
    if (notificationType == null) return;

    switch (notificationType) {
      case NotificationType.chat:
        {
          ChatPerson otherPerson =
              ChatPerson.fromMap(json.decode(data['chatPerson']));
          if (Atom.url.contains(PagePaths.CHAT)) {
            Atom.historyBack();
            await Future.delayed(Duration(milliseconds: 100));
          }
          Atom.to(PagePaths.CHAT,
              queryParameters: {'otherPerson': (otherPerson.toJson())});
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

    setTokenToServer(token);
    LoggerUtils.instance.i('FirebaseToken :: ' + token);
  }

  Future<void> setTokenToServer(String token) async {
    AddFirebaseTokenRequest addFirebaseToken = AddFirebaseTokenRequest();
    addFirebaseToken.firebaseId = token;
    if (!kIsWeb) addFirebaseToken.phoneInfo = await getDeviceInformation();
    await getIt<Repository>().addFirebaseTokenUi(addFirebaseToken);
  }

  Future<String> getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.toJsonString();
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.toJsonString();
    }

    return "";
  }
}

extension on AndroidDeviceInfo {
  String toJsonString() {
    Map<String, dynamic> jsonMap = new Map();
    jsonMap.addAll({
      "android_id": androidId,
      "is_physical_device": isPhysicalDevice,
      "product": product,
      "model": model,
      "id": id,
      "host": host,
      "hardware": hardware,
      "fingerprint": fingerprint,
      "display": display,
      "device": device,
      "brand": brand,
      "bootloader": bootloader,
      "board": board,
      "base_os": version.baseOS,
      "release": version.release,
      "sdk_int": version.sdkInt
    });

    return jsonEncode(jsonMap);
  }
}

extension on IosDeviceInfo {
  String toJsonString() {
    Map<String, dynamic> jsonMap = new Map();
    jsonMap.addAll({
      "name": name,
      "systemName": systemName,
      "systemVersion": systemVersion,
      "model": model,
      "localizedModel": localizedModel,
      "identifierForVendor": identifierForVendor,
      "isPhysicalDevice": isPhysicalDevice,
      "sysname": utsname.sysname,
      "nodename": utsname.nodename,
      "release": utsname.release,
      "version": utsname.version,
      "machine": utsname.machine
    });

    return jsonEncode(jsonMap);
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
