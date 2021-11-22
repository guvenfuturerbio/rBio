import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:logging/logging.dart';

import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../progress_sections/glucose_progress/view/bg_progress_page.dart';
import '../progress_sections/scale_progress/view/scale_progress_page.dart';
import 'helper/resources.dart';
import 'pages/ble_new/ble_devices/ble_device_connections.dart';
import 'pages/ble_new/ble_paired_devices/ble_paired_devices_page.dart';
import 'pages/signup&login/email_login_page/email_login_page.dart';
import 'pages/signup&login/login_page/login_page.dart';
import 'pages/signup&login/signup_page/signup_page.dart';

/* 
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.data}");
  PushedNotificationHandlerNew().showNotification(message.data);
} */
/* 
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler);
  await PushedNotificationHandlerNew().initializeGCM();

  BuildConfigurations.setEnvironment(Environment.PROD);
  //await Firebase.initializeApp();
  //PushedNotificationHandler().initializeGCM();
  _setupLogging();
  final userProfilesNotifier = UserProfilesNotifier();
  final bgProgressPage = BgProgressPageViewModel();
  final scaleProgressPage = ScaleProgressPageViewModel();
  final glucoseRepository = GlucoseRepository();
  final scaleRepository = ScaleRepository();

  final language =
      AppLanguage(langCode: await SharedPrefNotifiers().getPreferedLang());
  SharedPrefInit().load();
  final _ble = FlutterReactiveBle();

  setupLocator(ble: _ble);
  await SentryFlutter.init((options) {
    options.dsn =
        'https://81495fcd4bbb4891b62c820aa850573d@o983734.ingest.sentry.io/5962718';
    options.enablePrintBreadcrumbs = false;
    options.attachStacktrace = false;
    options.diagnosticLevel = SentryLevel.info;
    options.release = "com.guvenfuture.onedosehealth@00.5.0+1";
    options.environment = Environment.PROD.toString();
    //options.diagnosticLevel = SentryLevel.debug; //The most verbose mode
    options.sendDefaultPii = true;
  },
      appRunner: () => runApp(MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (context) => BgProgressPageViewModel()),
              ChangeNotifierProvider(
                  create: (context) => ScaleProgressPageViewModel()),
              ChangeNotifierProvider(
                create: (context) => locator<LoginViewModel>(),
              ),
              ChangeNotifierProvider(
                create: (context) => locator<UserNotifier>(),
              ),
              ChangeNotifierProvider(
                create: (context) => locator<ProfileRepository>(),
              ),
              ChangeNotifierProvider(
                create: (context) => locator<UserProfilesNotifier>(),
              ),
              ChangeNotifierProvider(
                create: (context) => BgMeasurementsNotifier(),
              ),
              ChangeNotifierProvider<UserProfilesNotifier>.value(
                  value: userProfilesNotifier),
              ChangeNotifierProvider<BgProgressPageViewModel>.value(
                  value: bgProgressPage),
              ChangeNotifierProvider<ScaleProgressPageViewModel>.value(
                  value: scaleProgressPage),
              ChangeNotifierProvider<GlucoseRepository>.value(
                  value: glucoseRepository),
              ChangeNotifierProvider<ScaleRepository>.value(
                  value: scaleRepository),
              ChangeNotifierProvider(
                create: (context) => locator<BleScannerOps>(),
              ),
              ChangeNotifierProvider(
                create: (context) => locator<BleReactorOps>(),
              ),
              ChangeNotifierProvider(
                create: (context) => locator<BleConnectorOps>(),
              ),
              ChangeNotifierProvider(
                create: (context) => locator<SharedPrefNotifiers>(),
              ),
              ChangeNotifierProvider<AppLanguage>.value(value: language),
            ],
            child: MyApp(),
          )));
}
 */
void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class ChronicApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "main navigator");

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      supportedLocales: LocaleProvider.delegate.supportedLocales,
      localizationsDelegates: const [
        LocaleProvider.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      locale: Locale(intl.Intl.getCurrentLocale()),
      builder: (context, child) {
        bool _isRtl = intl.Bidi.isRtlLanguage(intl.Intl.getCurrentLocale());
        return Directionality(
          textDirection: _isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: true,
                  textScaleFactor: MediaQuery.of(context).textScaleFactor < 1
                      ? 1
                      : MediaQuery.of(context).textScaleFactor),
              child: child),
        );
      },
      title: 'OneDose Health',
      theme: ThemeData(
        backgroundColor: Colors.white,
        fontFamily: 'SourceSansPro',
        canvasColor: R.color.backgroundColor,
      ),
      routes: {
        Routes.BG_PROGRESS_PAGE: (context) => BgProgressPage(),
        Routes.SCALE_PROGRESS_PAGE: (context) => ScaleProgressPage(),
        Routes.LOGIN_PAGE: (context) => LoginPage(),
        Routes.EMAIL_LOGIN_PAGE: (context) => EmailLoginPage(),
        Routes.SIGN_UP_PAGE: (context) => SignUpPage(),
        Routes.DEVICE_CONNECTIONS_PAGE: (context) => DeviceConnections(),
        Routes.PAIRED_DEVICES: (context) => PairedDevicesPage()
      },
      navigatorObservers: [routeObserver],
    );
  }
}
