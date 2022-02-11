abstract class FirebaseMessagingManager {
  // ! main() fonksiyonunda çalıştır.
  // 1- flutterLocalNotificationsPlugin
  // 2- createNotificationChannel - android
  // 3- setForegroundNotificationPresentationOptions
  // 4- FirebaseMessaging.onBackgroundMessage - Set top-level function
  Future<void> init();

  // ! HomeScreen sayfasının initState i içerisinde çalıştır.
  // 1- FirebaseMessaging.instance.getInitialMessage() - future - Uygulama Kapalı İken.
  // 2- FirebaseMessaging.onMessageOpenedApp - stream - Uygulama Arkaplanda Açıkken
  // 3- FirebaseMessaging.onMessage - stream - Uygulama Ekranda Açıkken
  //
  // 5- FirebaseMessaging.instance.getToken, FirebaseMessaging.instance.onTokenRefresh
  // 6- FirebaseMessaging.instance.getNotificationSettings()
  // 7- FirebaseMessaging.instance.requestPermission()
  Future<void> userInit();

  // ! Kullanıcı çıkış yaptığında çalıştır.
  // Stream'leri durdur, token kaydetmeyi bırak.
  Future<void> userLogout();
}

// Top Level :: Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)
// Top Level :: Future<void> checkChatNotification(RemoteMessage message)

// Future<void> getToken()
// void showNotification(RemoteMessage message)
// void flutterLocalNotificationsShow(int id, String title, String body, String payload)
// NotificationType? getNotificationType(Map<String, dynamic>? data)
// Future<void> clickDataHandler(Map<String, dynamic> data)
