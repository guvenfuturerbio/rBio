// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onedosehealth/core/core.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.

class FirebaseMessagingManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String token;

  static final FirebaseMessagingManager _instance =
      FirebaseMessagingManager._init();
  factory FirebaseMessagingManager() {
    return _instance;
  }
  void getPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );
  }

  FirebaseMessagingManager._init() {
    setForegroundSettings();
    getToken();
    getPermission();
    if (!kIsWeb) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      setLocalNotificationChannel();
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LoggerUtils.instance.i(message);
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
                  channelDescription: channel.description,
                  icon: 'launch_background',
                ),
              ));
        }
      }
    });
    setupInteractedMessage();
  }
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    LoggerUtils.instance.w(initialMessage);

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null && initialMessage.data['type'] == 'chat') {
      Atom.to(
        PagePaths.CONSULTATION,
      );
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      LoggerUtils.instance.e(message);

      if (message.data['type'] == 'route') if (message.data['parameters'] !=
          null)
        Atom.to(message.data['route'],
            queryParameters: message.data['parameters']);
      else
        Atom.to(message.data['route']);
      else {
        if (message != null && initialMessage.data['type'] == 'chat') {
          Atom.to(
            PagePaths.CONSULTATION,
          );
        }
      }
    });
  }

  Future<void> getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    LoggerUtils.instance.i('FirebaseToken :: ' + token);
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
