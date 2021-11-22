import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingHandler {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final BuildContext mContext;

  FirebaseMessagingHandler(this.mContext);

  void setListeners() {
    firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        //TODO: Message notification will be came here
        /* flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            )); */
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          //TODO: Message Argument Coming here
          /* 
      Navigator.pushNamed(mContext, '/message',
          arguments: MessageArguments(message, true)); */
        });
      }
    });
  }
}
  /* 
  void getToken() {
    firebaseMessaging.getToken().then((token) {
      print('DeviceToken = $token');
    });
  }

  void _iOSPermission() {
    firebaseMessaging.app.options
    firebaseMessaging.configure();
    firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
    });
  }

  void refreshToken() {
    firebaseMessaging.onTokenRefresh.listen((token) {
      print("refresh token : "+token);
    });
  }

  void showDialog(BuildContext context, Map<String, dynamic> message) {
    // data
    print("show dialog");
  }

  void showErrorDialog(BuildContext context, dynamic error) {
    print("show error : "+error);
  }

  void redirectToPage(BuildContext context, Map<String, dynamic> message) {
    // data
    print("redirect to page");
  } 
}*/