import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/notifiers/user_profiles_notifier.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'core/core.dart';
import 'core/notifiers/notification_badge_notifier.dart';
import 'features/chronic_tracking/progress_sections/glucose_progress/view_model/bg_progress_page_view_model.dart';
import 'features/chronic_tracking/progress_sections/pressure_progress/view/pressure_progres_page.dart';
import 'features/chronic_tracking/progress_sections/scale_progress/view_model/scale_progress_page_view_model.dart';
import 'features/doctor/notifiers/bg_measurements_notifiers.dart';
import 'features/doctor/notifiers/patient_notifiers.dart';
import 'features/home/viewmodel/home_vm.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appConfig = DefaultConfig();
  await SecretUtils.instance.setup(Environment.prod);
  await Firebase.initializeApp();
  FirebaseMessagingManager.mainInit();
  await setupLocator(appConfig);
  timeago.setLocaleMessages('tr', timeago.TrMessages());
  RegisterViews.instance.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
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

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final widgetsBinding = WidgetsBinding.instance;
    if (widgetsBinding != null) {
      widgetsBinding.addPostFrameCallback((_) {
        Utils.instance.hideKeyboardWithoutContext();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<NotificationBadgeNotifier>(
            create: (context) => getIt<NotificationBadgeNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (context) => PatientNotifiers(),
          ),
          ChangeNotifierProvider<LocaleNotifier>.value(
            value: getIt<LocaleNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (context) => BgMeasurementsNotifierDoc(),
          ),
          ChangeNotifierProvider<HomeVm>(
            create: (context) => HomeVm(),
          ),
          ChangeNotifierProvider<ThemeNotifier>(
            create: (context) => ThemeNotifier(),
          ),
          ChangeNotifierProvider<UserNotifier>(
              create: (context) => getIt<UserNotifier>()),
          ChangeNotifierProvider<UserProfilesNotifier>(
            create: (context) => UserProfilesNotifier(),
          ),
          ChangeNotifierProvider<ScaleProgressPageViewModel>(
            create: (ctx) => ScaleProgressPageViewModel(),
          ),
          ChangeNotifierProvider<BgProgressPageViewModel>.value(
              value: BgProgressPageViewModel()),
          ChangeNotifierProvider<BpProgressPageVm>.value(
              value: BpProgressPageVm()),
          if (!Atom.isWeb) ...[
            ChangeNotifierProvider<BleScannerOps>.value(
              value: getIt<BleScannerOps>(),
            ),
            ChangeNotifierProvider<BleConnectorOps>.value(
              value: getIt<BleConnectorOps>(),
            ),
            ChangeNotifierProvider<BleReactorOps>.value(
              value: getIt<BleReactorOps>(),
            ),
          ],
        ],

        //
        child: Consumer<ThemeNotifier>(
          builder: (
            BuildContext context,
            ThemeNotifier themeNotifier,
            Widget child,
          ) {
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                RbioConfig.of(context).changeOrientation(orientation);

                return AtomMaterialApp(
                  initialUrl: PagePaths.LOGIN,
                  routes: VRouterRoutes.routes,
                  onSystemPop: (data) async {
                    if (Atom.isDialogShow ?? false) {
                      try {
                        Atom.dismiss();
                        data.stopRedirection();
                      } catch (e) {}
                    } else {
                      final currentUrl = data.fromUrl;
                      if (currentUrl.contains('/home')) {
                        SystemNavigator.pop();
                      } else if (data.historyCanBack()) {
                        data.historyBack();
                      }
                    }
                  },

                  //
                  title: 'Güven Online',
                  debugShowCheckedModeBanner: false,
                  navigatorObservers: [],

                  //
                  builder: (BuildContext context, Widget child) {
                    return Directionality(
                      textDirection: TextDirection.ltr,
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: themeNotifier.textScale.getValue(),
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
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: getIt<ITheme>().mainColor,
                      selectionColor: getIt<ITheme>().mainColor,
                      selectionHandleColor: getIt<ITheme>().mainColor,
                    ),
                    cupertinoOverrideTheme: CupertinoThemeData(
                      primaryColor: getIt<ITheme>().mainColor,
                    ),
                  ),
                  locale: context.watch<LocaleNotifier>().current,
                  localizationsDelegates: const [
                    LocaleProvider.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate
                  ],
                  supportedLocales:
                      context.read<LocaleNotifier>().supportedLocales,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
