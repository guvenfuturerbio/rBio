import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'doctor/notifiers/user_notifiers.dart';
import 'doctor/pages/chat/chat_controller.dart';
import 'doctor/pages/chat/chat_window.dart';
import 'locator.dart';
import 'main.dart';
import 'models/notification/notification_body_model.dart';
import 'notifiers/notification_handler.dart';
import 'notifiers/user_profiles_notifier.dart';
import 'pages/chat/chat_controller.dart';
import 'pages/chat/chat_person.dart';
import 'pages/chat/chat_window.dart';
import 'pages/chat/currentwindowtracker.dart';
import 'pages/chat/patient_id_holder.dart';
import 'pages/signup&login/email_login_page/doctor_checker.dart';

/*
Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  NotificationHandler.showNotification(message);

/*
  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }*/
  return Future<void>.value();
}
*/
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print('Handling a background message ${message.messageId}');
  NotificationHandler.showNotification(message.data);
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

class NotificationHandler extends ChangeNotifier {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Map<String, dynamic> message; // required for other class
  static final NotificationHandler _singleton = NotificationHandler._init();
  String token;
  factory NotificationHandler() {
    return _singleton;
  }

  BuildContext myContext;
  NotificationHandler._internal();
  initializeFCMNotification(BuildContext context) async {
    print("initializing fcm notification");

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    myContext = context;
    UserProfilesNotifier userProfilesNotifier = locator<UserProfilesNotifier>();
    UserNotifiers userNotifiers = locator<UserNotifiers>();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    String currentToken = await _fcm.getToken();
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
    }

    /* _fcm.subscribeToTopic("all");
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage tetiklendi: $message");
        this.message = message;
        notifyListeners();
        showNotification(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch tetiklendi: $message");
        //      showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        //showNotification(message);
        print("onResume tetiklendi: $message");
        //  showNotification(message);
      },
    );*/
  }

  Future onSelectNotification(String payload) async {
    print(payload.toString());
    if (payload != null) {
      Map<String, dynamic> bildirim = await json.decode(payload);
      print("bildirime tıklandı");
      print(bildirim);
      if (DoctorChecker().doctor == true) {
        print("bildirim id " + bildirim["id"] ?? "---");
        print("Kullanıcı doktor, chat sayfasına gidiliyor");
        Navigator.of(myContext, rootNavigator: true).push(MaterialPageRoute(
            builder: (
          context,
        ) =>
                ChangeNotifierProvider<DoctorChatController>(
                  create: (context) => DoctorChatController(),
                  child: DoctorChatWindow(bildirim["id"], bildirim["title"]),
                )));
      } else {
        if (CurrentWindowTracker().currentwindow != bildirim['id']) {
          print("Kullanıcı hasta, chat sayfasına gidiliyor");
          MyApp.navigatorKey.currentState.push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<ChatController>(
                    create: (context) => ChatController(),
                    child: ChatWindow(ChatPerson(
                        name: bildirim["title"],
                        id: bildirim["id"],
                        url:
                            "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png")),
                  )));
        }
      }
    }
  }

  static void showNotification(Map<String, dynamic> message) async {
    var messageForData = message;
    if (messageForData['type'] == "3") {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
              '11', 'New Message', 'New message recieved',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker');
      const IOSNotificationDetails iosPlatformChannelSpecificts =
          IOSNotificationDetails();
      const NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iosPlatformChannelSpecificts);
      await flutterLocalNotificationsPlugin.show(0, messageForData["title"],
          messageForData["message"], platformChannelSpecifics,
          payload: json.encode(messageForData));
    } else if (messageForData['type'] == "1") {
      final datum = messageForData["datum"];
      PushedNotificationHandler().handlePatientRangeChange(
          new PatientRangeChangeBody.fromJson(jsonDecode(datum)));
    }
  }

  /*
  Future onSelectNotification(String payload) async {
    print(payload.toString());
    if (payload != null) {
      Map<String, dynamic> bildirim = await json.decode(payload);
      print("bildirime tıklandı");
      print(bildirim);
      if (DoctorChecker().doctor == true) {
        print("bildirim id " + bildirim["id"] ?? "---");
        print("Kullanıcı doktor, chat sayfasına gidiliyor");
        Navigator.of(myContext, rootNavigator: true).push(MaterialPageRoute(
            builder: (
          context,
        ) =>
                ChangeNotifierProvider<DoctorChatController>(
                  create: (context) => DoctorChatController(),
                  child: DoctorChatWindow(bildirim["id"], bildirim["title"]),
                )));
      } else {
        if (CurrentWindowTracker().currentwindow != bildirim['id']) {
          print("Kullanıcı hasta, chat sayfasına gidiliyor");
          MyApp.navigatorKey.currentState.push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<ChatController>(
                    create: (context) => ChatController(),
                    child: ChatWindow(ChatPerson(
                        name: bildirim["title"],
                        id: bildirim["id"],
                        url:
                            "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png")),
                  )));
        }
      }
    }
  }
*/

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    showNotification(json.decode(payload));
  }

  //-------------------------- Aşağı kısım güven cepten çekilerek entegre edildi -------------------------//

  NotificationHandler._init() {
    setForegroundSettings();
    FirebaseMessaging.instance.subscribeToTopic("all");
    getToken();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("Remote data Messageee " + message.data.toString());
      Map<String, dynamic> bildirim = message.data;
      this.message = bildirim;
      notifyListeners();
      RemoteNotification notification = message.notification;
      if (!kIsWeb) {
        if (notification != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                iOS: IOSNotificationDetails(),
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                ),
              ));
        }
      }
    });

    FirebaseMessaging.onBackgroundMessage((message) {
      print(message.data.toString());
      NotificationHandler.showNotification(message.data);

      return Future<void>.value();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Map<String, dynamic> bildirim = message.data;
      this.message = bildirim;
      print("bildirime tıklandı");
      print(bildirim);
      if (DoctorChecker().doctor == true) {
        print("bildirim id " + bildirim["id"] ?? "---");
        print("Kullanıcı doktor, chat sayfasına gidiliyor");
        Navigator.of(myContext, rootNavigator: true).push(MaterialPageRoute(
            builder: (
          context,
        ) =>
                ChangeNotifierProvider<DoctorChatController>(
                  create: (context) => DoctorChatController(),
                  child: DoctorChatWindow(bildirim["id"], bildirim["title"]),
                )));
      } else {
        if (CurrentWindowTracker().currentwindow != bildirim['id']) {
          print("Kullanıcı hasta, chat sayfasına gidiliyor");
          MyApp.navigatorKey.currentState.push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<ChatController>(
                    create: (context) => ChatController(),
                    child: ChatWindow(ChatPerson(
                        name: bildirim["title"],
                        id: bildirim["id"],
                        url:
                            "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png")),
                  )));
        }
      }
    });
  }

  Future<void> getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    print('firebasetoken: ' + token);
  }

  Future<void> setForegroundSettings() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> setLocalNotificationChannel() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
