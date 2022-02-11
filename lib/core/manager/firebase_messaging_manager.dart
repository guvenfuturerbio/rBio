import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/chat/model/chat_person.dart';
import '../../model/model.dart';
import '../core.dart';

// #region Top Level Variabled and Functions
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await checkChatNotification(message);
}

Future<void> checkChatNotification(RemoteMessage message) async {
  final messageData = message.data;
  final type = messageData['type'];
  if (type == NotificationType.chat.xRawValue) {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(
      SharedPreferencesKeys.chatNotification.xRawValue,
      true,
    );
  }
}

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
  String? token;

  FirebaseMessagingManager._();

  static FirebaseMessagingManager? _instance;

  static FirebaseMessagingManager get instance {
    _instance ??= FirebaseMessagingManager._()..init();
    return _instance!;
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
      const IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: (payload) {
          clickDataHandler(
              jsonDecode(payload as String) as Map<String, dynamic>);
        },
      );
    }

    final initialPayload =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (initialPayload?.payload != null) {
      clickDataHandler(json.decode(initialPayload?.payload as String)
          as Map<String, dynamic>);
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
          FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
            if (!kIsWeb) {
              if (Atom.isAndroid) {
                final ChatPerson otherPerson = ChatPerson.fromMap(
                    json.decode(message.data['chatPerson'] as String)
                        as Map<String, dynamic>);

                if (!(Atom.url.contains(PagePaths.chat) &&
                    Atom.url.contains(otherPerson.id as String))) {
                  showNotification(message);
                }
              }

              await checkChatNotification(message);
              await getIt<NotificationBadgeNotifier>().changeValue(true);
            }
          });

          // Uygulama Arkaplanda Açıkken
          FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
            clickDataHandler(message.data);
          });

          // Uygulama Kapalı İken.
          await FirebaseMessaging.instance
              .getInitialMessage()
              .then((RemoteMessage? message) {
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
    if (Atom.isAndroid) {
      final notificationType = getNotificationType(message.data);
      if (notificationType == null) return;

      switch (notificationType) {
        case NotificationType.chat:
          {
            {
              flutterLocalNotificationsShow(
                message.hashCode,
                message.notification?.title ?? '',
                message.notification?.body ?? '',
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
        iOS: const IOSNotificationDetails(sound: 'chat_bildirim.aiff'),
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: androidNotificationChannel.description,
          sound: androidNotificationChannel.sound,
          icon: 'launch_background',
        ),
      ),
      payload: payload,
    );
  }

  static NotificationType? getNotificationType(Map<String, dynamic>? data) {
    if (data == null) return null;
    final type = data['type'] as String?;
    if (type == null) return null;
    return type.xNotificationTypeKeys;
  }

  Future<void> clickDataHandler(Map<String, dynamic> data) async {
    final notificationType = getNotificationType(data);
    if (notificationType == null) return;

    switch (notificationType) {
      case NotificationType.chat:
        {
          final ChatPerson otherPerson = ChatPerson.fromMap(json
              .decode(data['chatPerson'] as String) as Map<String, dynamic>);
          if (Atom.url.contains(PagePaths.chat)) {
            Atom.historyBack();
            await Future.delayed(const Duration(milliseconds: 100));
          }
          Atom.to(
            PagePaths.chat,
            queryParameters: {'otherPerson': otherPerson.toJson()},
          );
          break;
        }

      case NotificationType.route:
        {
          final parameters = data['parameters'];
          final route = data['route'];
          if (parameters != null) {
            Atom.to(route as String,
                queryParameters: parameters as Map<String, String>);
          } else {
            Atom.to(route as String);
          }

          break;
        }
    }
  }

  Future<void> getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setTokenToServer(token as String);
    LoggerUtils.instance.i('FirebaseToken : $token');
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
    Map<String, dynamic> jsonMap = {};
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
    Map<String, dynamic> jsonMap = {};
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
  NotificationType? get xNotificationTypeKeys => NotificationType.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension NotificationTypeExt on NotificationType {
  String get xRawValue => getEnumValue(this);
}
