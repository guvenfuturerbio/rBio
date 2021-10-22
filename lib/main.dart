import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SecretUtils.instance.setup(Environment.PROD);
  await Firebase.initializeApp();
  await setupLocator();
  _setupLogging();
  _initFirebaseMessaging();
  RegisterViews.instance.init();
  await SentryFlutter.init(
    (SentryFlutterOptions options) {
      options.dsn = SecretUtils.instance.get(SecretKeys.SENTRY_DSN);
      options.enablePrintBreadcrumbs = true;
      options.attachStacktrace = true;
      options.release = "com.guvenfuture.online@3.2.6+73";
      options.environment = Environment.PROD.toString();
      options.diagnosticLevel = SentryLevel.debug; //The most verbose mode
      options.sendDefaultPii = true;
    },
    appRunner: () => runApp(MyApp()),
  );
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
    (rec) {
      LoggerUtils.instance.w('${rec.level.name}: ${rec.time}: ${rec.message}');
    },
  );
}

void _initFirebaseMessaging() {
  FirebaseMessagingManager();
}

// TOP-LEVEL or STATIC function to handle background message
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAnalytics>.value(value: analytics),
        Provider<FirebaseAnalyticsObserver>.value(value: observer),
      ],
      child: AtomMaterialApp(
        initialUrl: PagePaths.LOGIN,
        routes: VRouterRoutes.routes,

        //
        title: 'Güven Online',
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
          routeObserver
        ],

        //
        builder: (BuildContext context, Widget child) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor:
                    MediaQuery.of(context).size.width <= 400 ? 0.8 : 1.0,
              ),
              child: child,
            ),
          );
        },

        //
        theme: ThemeData(
          //backgroundColor: Color(0xFFe2e2e2),
          primaryColor: R.color.blue,
          accentColor: Colors.white,
          //scaffoldBackgroundColor: Color(0xFFe2e2e2),
          fontFamily: 'Poppins',
        ),
        localizationsDelegates: const [
          LocaleProvider.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
        supportedLocales: LocaleProvider.delegate.supportedLocales,
      ),
    );
  }
}
