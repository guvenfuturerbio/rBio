import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'package:logging/logging.dart';
import 'package:onedosehealth/core/domain/glucose_model.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/notifiers/scale_measurement_notifier.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';
import 'features/chronic_tracking/lib/database/repository/profile_repository.dart';
import 'features/chronic_tracking/lib/notifiers/bg_measurements_notifiers.dart';
import 'features/chronic_tracking/lib/notifiers/user_profiles_notifier.dart';
import 'features/chronic_tracking/progress_sections/glucose_progress/view_model/bg_progress_page_view_model.dart';
import 'features/chronic_tracking/progress_sections/scale_progress/view_model/scale_progress_page_view_model.dart';
import 'features/chronic_tracking/lib/notifiers/user_notifier.dart' as ct;
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

  runApp(
    RbioConfig(
      child: MyApp(),
    ),
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
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bgProgressPage = BgProgressPageViewModel();
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
          ChangeNotifierProvider<ct.UserNotifier>(
            create: (context) => getIt<ct.UserNotifier>(),
          ),
          ChangeNotifierProvider<UserProfilesNotifier>(
            create: (context) => UserProfilesNotifier(),
          ),
          ChangeNotifierProvider<ScaleProgressPageViewModel>(
            create: (ctx) => ScaleProgressPageViewModel(),
          ),
          ChangeNotifierProvider<BgMeasurementsNotifier>.value(
            value: BgMeasurementsNotifier(),
          ),
          ChangeNotifierProvider<ScaleMeasurementNotifier>.value(
            value: ScaleMeasurementNotifier(),
          ),
          ChangeNotifierProvider<BgProgressPageViewModel>.value(
              value: BgProgressPageViewModel()),
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

            return OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) {
              RbioConfig.of(context).changeOrientation(orientation);

              return AtomMaterialApp(
                initialUrl: PagePaths.LOGIN,
                routes: VRouterRoutes.routes,
                onSystemPop: (data) async {
                  final currentUrl = data.fromUrl;
                  if (currentUrl.contains('/home')) {
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
                            MediaQuery.of(context).size.width <= 400
                                ? 0.8
                                : 1.0,
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
                locale: Locale(intl.Intl.getCurrentLocale()),
                localizationsDelegates: const [
                  LocaleProvider.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate
                ],
                supportedLocales: LocaleProvider.delegate.supportedLocales,
              );
            });
          },
        ),
      ),
    );
  }
}
