import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/notification/notification_body_model.dart';
import 'user_profiles_notifier.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print(TAG + ' Handling a background message ${message.data}');
  print(message);
  PushedNotificationHandlerNew().showNotification(message.data);
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

final String TAG = "NOTIFICATION HANDLER NEW";

class PushedNotificationHandlerNew with ChangeNotifier {
  Map<String, dynamic> message; // required for other class

  static final PushedNotificationHandlerNew _instance =
      PushedNotificationHandlerNew._internal();

  factory PushedNotificationHandlerNew() {
    return _instance;
  }

  PushedNotificationHandlerNew._internal() {}

  initializeGCM() async {
    await _firebaseMessaging.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);

    await setForegroundSettings();
    /*  String currentToken = await _firebaseMessaging.getToken();
    UserProfilesNotifier userProfilesNotifier = locator<UserProfilesNotifier>();
    UserNotifiers userNotifiers = locator<UserNotifiers>();
    print("Current token is $currentToken");
    if (DoctorChecker().doctor) {
      print("Doktor tokenı günelleniyor");
      await FirebaseFirestore.instance
          .doc("tokens/" + userNotifiers.userId)
          .set({"token": currentToken});
    } else {
      print("Hasta tokenı günelleniyor");
      await FirebaseFirestore.instance
          .doc("tokens/" + PatientIdHolder().patient_id)
          .set({"token": currentToken});
    }*/
    initializeLocalNotificationSettings();

    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((_message) {
      print(TAG + " onMessage: ${_message.data}");
      this.message = _message.data; // required for other class
      notifyListeners(); // required for other class
      handleNotification(_message.data, false);
    });

    FirebaseMessaging.onBackgroundMessage(
      (message) {
        print(TAG + " " + message.data.toString());
        return _firebaseMessagingBackgroundHandler(message);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('hiii');
      print(message.data);
      return handleNotification(message.data, false);
    });
  }

  void showNotification(Map<String, dynamic> message) {
    print(" dedkekde "+message.toString());
    var messageForData = message;
    if (messageForData['type'] == "3") {
      //showChatNotification(message);
    } else if (messageForData['type'] == "1") {
      final datum = messageForData["datum"];

      /// MG9
      handlePatientRangeChangeFromNotification(
          PatientRangeChangeBody.fromJson(jsonDecode(datum)));
    }
  }

  /// MG9
  handlePatientRangeChangeFromNotification(
      PatientRangeChangeBody patientRangeChangeBody) async {
    await UserProfilesNotifier()
        .changeHypo(patientRangeChangeBody.alertMin.toInt());
    await UserProfilesNotifier()
        .changeHyper(patientRangeChangeBody.alertMax.toInt());
    await UserProfilesNotifier().changeRange(new RangeValues(
        patientRangeChangeBody.normalMin.toDouble(),
        patientRangeChangeBody.normalMax.toDouble()));
  }

  Future<void> handleNotification(
      Map<dynamic, dynamic> message, bool dialog) async {
    print(TAG + " handle Notification " + message.toString());
    print(message);
    showNotification(message);
  }

  Future<void> setForegroundSettings() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  initializeLocalNotificationSettings() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    print(TAG + " onDidReceiveLocalNotification " + payload.toString());
  }

  Future onSelectNotification(String payload) async {
    print(TAG + " onSelectNotification " + payload.toString());
  }

  showChatNotification(Map<String, dynamic> message) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('11', 'New Message', 'New message recieved',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const IOSNotificationDetails iosPlatformChannelSpecificts =
        IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecificts);
    flutterLocalNotificationsPlugin.show(
        0, message["title"], message["message"], platformChannelSpecifics,
        payload: json.encode(message));
  }
}
