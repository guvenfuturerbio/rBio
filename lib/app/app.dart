import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../core/core.dart';
import '../features/chronic_tracking/progress_sections/blood_glucose/viewmodel/bg_progress_vm.dart';
import '../features/chronic_tracking/progress_sections/blood_pressure/viewmodel/bp_progres_vm.dart';
import '../features/chronic_tracking/progress_sections/scale/viewmodel/scale_progress_vm.dart';
import '../features/doctor/notifiers/bg_measurements_notifiers.dart';
import '../features/doctor/notifiers/patient_notifiers.dart';
import '../features/home/viewmodel/home_vm.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
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
            create: (context) => HomeVm(context),
          ),
          ChangeNotifierProvider<ThemeNotifier>(
            create: (context) => ThemeNotifier(),
          ),
          ChangeNotifierProvider<UserNotifier>(
            create: (context) => getIt<UserNotifier>(),
          ),
          ChangeNotifierProvider<ScaleProgressVm>(
            create: (ctx) => ScaleProgressVm(),
          ),
          ChangeNotifierProvider<BgProgressVm>.value(
            value: BgProgressVm(context: context),
          ),
          ChangeNotifierProvider<BpProgressVm>.value(
            value: BpProgressVm(),
          ),

          //
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
            Widget? child,
          ) {
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                AppInheritedWidget.of(context)?.changeOrientation(orientation);

                return AtomMaterialApp(
                  initialUrl: PagePaths.login,
                  routes: VRouterRoutes.routes,
                  onSystemPop: (data) async {
                    if (Atom.isDialogShow) {
                      try {
                        Atom.dismiss();
                        data.stopRedirection();
                      } catch (e) {
                        LoggerUtils.instance.i(e);
                      }
                    } else {
                      final currentUrl = data.fromUrl ?? "";
                      if (currentUrl.contains('/home')) {
                        SystemNavigator.pop();
                      } else if (data.historyCanBack()) {
                        data.historyBack();
                      }
                    }
                  },

                  //
                  title: 'One Dose Health',
                  debugShowCheckedModeBanner: false,
                  navigatorObservers: const [],

                  //
                  builder: (BuildContext context, Widget? child) {
                    return Directionality(
                      textDirection: TextDirection.ltr,
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: themeNotifier.textScale.getValue(),
                        ),
                        child: child!,
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
                  onPop: (vRedirector) async {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}
