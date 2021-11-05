import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';
import 'features/home/viewmodel/home_vm.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SecretUtils.instance.setup(Environment.PROD);
  await Firebase.initializeApp();
  await setupLocator();
  _setupLogging();
  _initFirebaseMessaging();
  RegisterViews.instance.init();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
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
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MultiProvider(
        providers: [
          Provider<FirebaseAnalytics>.value(
            value: MyApp.analytics,
          ),
          Provider<FirebaseAnalyticsObserver>.value(
            value: MyApp.observer,
          ),
          ChangeNotifierProvider<HomeVm>(
            create: (context) => HomeVm(),
          ),
          ChangeNotifierProvider<ThemeNotifier>(
            create: (context) => ThemeNotifier(),
          ),
          ChangeNotifierProvider<UserNotifier>(
            create: (context) => UserNotifier()..loginExampleUser(),
          ),
        ],
        child: Consumer2<ThemeNotifier, UserNotifier>(
          builder: (
            BuildContext context,
            ThemeNotifier themeNotifier,
            UserNotifier userNotifier,
            Widget child,
          ) {
            if (userNotifier.username == null)
              return SizedBox.expand(
                child: Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                ),
              );

            return AtomMaterialApp(
              initialUrl: PagePaths.MAIN,
              routes: VRouterRoutes.routes,
              onSystemPop: (data) async {
                final currentUrl = data.fromUrl;
                if (currentUrl.contains('/home') && currentUrl.length > 6) {
                  data.to(PagePaths.MAIN, isReplacement: true);
                } else if (currentUrl.contains('/home')) {
                  SystemNavigator.pop();
                } else if (data.historyCanBack()) {
                  data.historyBack();
                }
              },

              //
              title: 'Güven Online',
              debugShowCheckedModeBanner: false,
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: MyApp.analytics),
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
                primaryColor: themeNotifier.theme.mainColor,
                scaffoldBackgroundColor:
                    themeNotifier.theme.scaffoldBackgroundColor,
                fontFamily: themeNotifier.theme.fontFamily,
                textTheme: themeNotifier.theme.textTheme,
              ),

              //
              localizationsDelegates: const [
                LocaleProvider.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate
              ],
              supportedLocales: LocaleProvider.delegate.supportedLocales,
            );
          },
        ),
      ),
    );
  }
}
