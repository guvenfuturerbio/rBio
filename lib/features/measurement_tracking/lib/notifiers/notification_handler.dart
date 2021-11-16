import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/firebase/add_firebase_body.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/notification/notification_body_model.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/notification_handler.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/notifiers/user_profiles_notifier.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/utils/base_provider_repository.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("myBackgroundMessageHandler " + message.toString());
  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print("PUSH NOTIFICATION ");
    NotificationHandler.showNotification(message);
  }

  // Or do other work.
}

enum NotificationType {
  PATIENT_RANGE_CHANGE,
  PAYMENT_RESPONSE,
}

extension NotificationTypeExtension on NotificationType {
  String get name {
    switch (this) {
      case NotificationType.PATIENT_RANGE_CHANGE:
        return "PATIENT_RANGE_CHANGE";
      case NotificationType.PAYMENT_RESPONSE:
        return "PAYMENT_RESPONSE";
      default:
        return "";
    }
  }

  int get id {
    switch (this) {
      case NotificationType.PATIENT_RANGE_CHANGE:
        return 1;
      case NotificationType.PAYMENT_RESPONSE:
        return 2;
      default:
        return -1;
    }
  }
}

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

class PushedNotificationHandler with ChangeNotifier {
  static Future<void> handleNotification(
      Map<dynamic, dynamic> message, bool dialog) async {
    print(message);
    if (message['type'] == null || !(message['type'] is int)) {
      NotificationHandler.showNotification(message);
    }
    if (message["type"] == "3") {
      NotificationHandler.showNotification(message);
    } else {
      int msgType = int.parse(message["type"]);

      if (msgType == 1) {
        final datum = message["datum"];
        print("Datum $datum");
        PushedNotificationHandler().handlePatientRangeChange(
            new PatientRangeChangeBody.fromJson(jsonDecode(datum)));
      } else {
        print("Unknown push notification");
      }
    }
  }

  Map<String, dynamic> message; // required for other class
  static final PushedNotificationHandler _instance =
      PushedNotificationHandler._internal();

  factory PushedNotificationHandler() {
    return _instance;
  }

  PushedNotificationHandler._internal() {}

  static bool didFetchTokenOnce = false;

  initializeGCM() async {
    await _firebaseMessaging.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);
    await setForegroundSettings();
    _firebaseMessaging.onTokenRefresh.listen((event) async {
      String currentToken = await _firebaseMessaging.getToken();
      print("Current token is $currentToken");
      setFirebaseToken(currentToken);
      didFetchTokenOnce = true;
    });

    /*_firebaseMessaging.onTokenRefresh.listen((event) {
      print("TOKEN is refreshed with $event");
      setFirebaseToken(event);
    });*/
    FirebaseMessaging.onMessage.listen((_message) {
      print("PUSH NOTIFICATION onMessage: ${_message.data}");
      this.message = _message.data; // required for other class
      notifyListeners(); // required for other class
      handleNotification(_message.data, false);
    });
    FirebaseMessaging.onBackgroundMessage(
      (message) {
        print(message.data);
        return myBackgroundMessageHandler(message.data);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.data);
      return handleNotification(message.data, false);
    });

    /*  _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        this.message = message; // required for other class
        notifyListeners(); // required for other class
        print("PUSH NOTIFICATION onMessage: $message");
        handleNotification(message, false);
      },
      onBackgroundMessage:
          Platform.isAndroid ? myBackgroundMessageHandler : null,
      onLaunch: (Map<String, dynamic> message) async {
        print("PUSH NOTIFICATION onLaunch: $message");
        handleNotification(message, false);
      },
      onResume: (Map<String, dynamic> message) async {
        print("PUSH NOTIFICATION onResume: $message");
        handleNotification(message, false);
      },
    ); */
  }

  Future<void> setForegroundSettings() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  setFirebaseToken(String token) async {
    print("firebase token " + token);
    AddFirebaseToken addFirebaseToken = new AddFirebaseToken();
    addFirebaseToken.firebaseId = token;
    addFirebaseToken.phoneInfo = await getDeviceInformation();
    BaseProviderRepository().addFirebaseToken(addFirebaseToken);
  }

  Future<String> getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
      return androidInfo.toJsonString();
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');
      return iosInfo.toJsonString();
    }
  }

  /// Handle cloud messages
  handlePatientRangeChange(
      PatientRangeChangeBody patientRangeChangeBody) async {
    await UserProfilesNotifier()
        .changeHypo(patientRangeChangeBody.alertMin.toInt());
    await UserProfilesNotifier()
        .changeHyper(patientRangeChangeBody.alertMax.toInt());
    await UserProfilesNotifier().changeRange(new RangeValues(
        patientRangeChangeBody.normalMin.toDouble(),
        patientRangeChangeBody.normalMax.toDouble()));
  }
}

extension on AndroidDeviceInfo {
  @override
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
  @override
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
