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

import '../../config/config.dart';
import '../../features/auth/shared/shared.dart';
import '../../features/chat/model/chat_person.dart';
import '../core.dart';

// #region Top Level Variabled and Functions
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await _checkChatNotification(message);
}

Future<void> _checkChatNotification(RemoteMessage message) async {
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

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel _channel;

abstract class FirebaseMessagingManager {
  late LocalNotificationManager localNotificationManager;
  late Repository repository;
  FirebaseMessagingManager({
    required this.localNotificationManager,
    required this.repository,
  });

  Future<void> init();
  Future<void> userInit();
  Future<void> userLogout();
  Future<void> saveTokenServer(String token);
  String? get getToken;
}

class FirebaseMessagingManagerImpl extends FirebaseMessagingManager {
  FirebaseMessagingManagerImpl({
    required LocalNotificationManager localNotificationManager,
    required Repository repository,
  }) : super(
          localNotificationManager: localNotificationManager,
          repository: repository,
        );

  final firebaseMessaging = FirebaseMessaging.instance;

  bool isUserInit = false;

  String? token;
  StreamSubscription<String>? _tokenStream;
  StreamSubscription<RemoteMessage>? _onMessageOpenedAppStream;
  StreamSubscription<RemoteMessage>? _onMessageStream;
  StreamSubscription<String>? _selectNotificationStream;

  @override
  String? get getToken => token;

  @override
  Future<void> init() async {
    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      _channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
        sound: RawResourceAndroidNotificationSound('chat_bildirim'),
        playSound: true,
      );

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  @override
  Future<void> userInit() async {
    // HomeScreen ilk açıldığından, kullanıcı logout olana kadar çalışacak.
    if (isUserInit) return;
    isUserInit = true;

    // Android always AuthorizationStatus.authorized.
    var notificationSettings =
        await firebaseMessaging.getNotificationSettings();
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      notificationSettings = await firebaseMessaging.requestPermission(
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
          _getToken();

          _selectNotificationStream = localNotificationManager
              .selectNotificationSubject
              ?.listen(_selectNotification);

          // Uygulama Kapalı İken.
          await FirebaseMessaging.instance
              .getInitialMessage()
              .then((RemoteMessage? message) {
            if (message != null) {
              clickDataHandler(message.data);
            }
          });

          // Uygulama Arkaplanda Açıkken
          _onMessageOpenedAppStream = FirebaseMessaging.onMessageOpenedApp
              .listen((RemoteMessage message) {
            clickDataHandler(message.data);
          });

          // Uygulama Ekranda Açıkken
          _onMessageStream =
              FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
            RemoteNotification? notification = message.notification;
            if (notification != null && !kIsWeb) {
              if (Platform.isAndroid) {
                showNotification(message);
              }

              await _checkChatNotification(message);
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
  }

  @override
  Future<void> userLogout() async {
    isUserInit = false;
    token = null;
    _tokenStream?.cancel();
    _tokenStream = null;
    _onMessageOpenedAppStream?.cancel();
    _onMessageOpenedAppStream = null;
    _onMessageStream?.cancel();
    _onMessageStream = null;
    _selectNotificationStream?.cancel();
    _selectNotificationStream = null;
  }

  void showNotification(RemoteMessage message) {
    final notificationType = getNotificationType(message.data);
    if (notificationType == null) return;

    switch (notificationType) {
      case NotificationType.chat:
        {
          {
            localNotificationManager.showWithId(
              message.hashCode,
              message.notification?.title ?? '',
              message.notification?.body ?? '',
              notificationDetails: NotificationDetails(
                iOS: const IOSNotificationDetails(
                  sound: 'chat_bildirim.aiff',
                ),
                android: AndroidNotificationDetails(
                  _channel.id,
                  _channel.name,
                  channelDescription: _channel.description,
                  sound: _channel.sound,
                ),
              ),
              payload: jsonEncode(message.data),
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

  Future<void> clickDataHandler(Map<String, dynamic> data) async {
    final notificationType = getNotificationType(data);
    if (notificationType == null) return;

    switch (notificationType) {
      case NotificationType.chat:
        {
          final chatPersonData = data['chatPerson'];
          if (chatPersonData != null) {
            try {
              final chatPersonModel =
                  ChatPerson.fromMap(json.decode(chatPersonData));
              if (Atom.url.contains(PagePaths.chat)) {
                Atom.historyBack();
                await Future.delayed(const Duration(milliseconds: 100));
              }
              Atom.to(
                PagePaths.chat,
                queryParameters: {
                  'otherPerson': chatPersonModel.toJson(),
                },
              );
            } catch (e, stackTrace) {
              LoggerUtils.instance
                  .e("FirebaseMessagingManager - clickDataHandler() - $e");
              getIt<IAppConfig>()
                  .platform
                  .sentryManager
                  .captureException(e, stackTrace: stackTrace);
            }
          }

          break;
        }

      case NotificationType.route:
        {
          final parameters = data['parameters'] ?? {};
          final route = data['route'];
          if (route != null) {
            Atom.to(
              route,
              queryParameters: parameters,
            );
          }

          break;
        }
    }
  }

  NotificationType? getNotificationType(Map<String, dynamic>? data) {
    if (data == null) return null;
    final type = data['type'] as String?;
    if (type == null) return null;
    return type.xNotificationTypeKeys;
  }

  void _selectNotification(String value) {
    try {
      if (value.isEmpty) return;
      final notificationPayload = jsonDecode(value);
      clickDataHandler(notificationPayload);
    } catch (e, stackTrace) {
      LoggerUtils.instance
          .e("FirebaseMessagingManager - _selectNotification() - $e");
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
    }
  }

  Future<void> _getToken() async {
    FirebaseMessaging.instance.getToken().then(_setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh.listen(_setToken);
  }

  void _setToken(String? token) {
    LoggerUtils.instance.w('FCM Token: $token');
    if (token != null) {
      saveTokenServer(token);
    }
  }

  @override
  Future<void> saveTokenServer(String token) async {
    AddFirebaseTokenRequest addFirebaseToken = AddFirebaseTokenRequest();
    addFirebaseToken.firebaseId = token;
    if (!kIsWeb) addFirebaseToken.phoneInfo = await _getDeviceInformation();
    await repository.addFirebaseTokenUi(addFirebaseToken);
  }

  Future<String> _getDeviceInformation() async {
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
  String get xRawValue => Utils.instance.getEnumValue(this);
}
