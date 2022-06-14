import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../core/core.dart';
import '../features/chronic_tracking/blood_glucose/blood_glucose.dart';
import '../features/chronic_tracking/blood_pressure/blood_pressure.dart';
import '../features/chronic_tracking/home/viewmodel/scale_progress_vm.dart';
import '../features/chronic_tracking/scale/scale.dart';
import '../features/dashboard/home/viewmodel/home_vm.dart';
import '../features/doctor/notifiers/bg_measurements_notifiers.dart';
import '../features/doctor/notifiers/patient_notifiers.dart';
import 'bluetooth_v2/bluetooth_v2.dart';

abstract class MyApp {
  Widget build(BuildContext context);
}

class MobileMyApp extends StatelessWidget with MyApp {
  final String initialRoute;

  const MobileMyApp({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MiScaleOpsCubit, MiScaleOpsState>(
      listener: (context, state) => _miScaleListener(context, state),
      child: BlocListener<MiScaleStatusCubit, MiScaleStatus>(
        listener: (context, miScaleStatus) {
          if (miScaleStatus.status == DeviceStatus.connected) {
            if (miScaleStatus.device != null) {
              BlocProvider.of<MiScaleOpsCubit>(context).readValue(miScaleStatus.device!);
            }
          } else if (miScaleStatus.status == DeviceStatus.disconnected) {
            BlocProvider.of<MiScaleOpsCubit>(context).stopListen();
          }
        },
        child: MyAppCommon(initialRoute: initialRoute),
      ),
    );
  }

  void _miScaleListener(
    BuildContext context,
    MiScaleOpsState miScaleState,
  ) async {
    miScaleState.when(
      initial: () {
        //
      },
      showLoading: (scaleEntity) {
        if (!Atom.isDialogShow) {
          Atom.show(const ScaleMeasurementPopup());
        }
      },
      dismissLoading: () {
        Atom.dismiss();
      },
      showScalePopup: (scaleEntity) {
        Atom.show(
          ScaleMeasurementResultScreen(scaleEntity: scaleEntity),
          barrierDismissible: false,
        );
      },
    );
  }
}

class WebMyApp extends StatelessWidget with MyApp {
  final String initialRoute;

  const WebMyApp({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAppCommon(initialRoute: initialRoute);
  }
}

class MyAppCommon extends StatefulWidget {
  final String initialRoute;

  const MyAppCommon({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  State<MyAppCommon> createState() => _MyAppCommonState();
}

class _MyAppCommonState extends State<MyAppCommon> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Utils.instance.hideKeyboardWithoutContext();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MultiProvider(
        providers: [
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
          if (!Atom.isWeb) ...[
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
                  initialUrl: widget.initialRoute,
                  routes: VRouterRoutes.routes(getIt<IAppConfig>()),
                  onSystemPop: (data) async {
                    if (Atom.isDialogShow) {
                      try {
                        Atom.dismiss();
                        data.stopRedirection();
                      } catch (e, stackTrace) {
                        LoggerUtils.instance.i(e);
                        getIt<IAppConfig>()
                            .platform
                            .sentryManager
                            .captureException(e, stackTrace: stackTrace);
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
                  title: getIt<IAppConfig>().title,
                  debugShowCheckedModeBanner: false,
                  navigatorObservers: const [],
                  showPerformanceOverlay: false,

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
                    primaryColor: getIt<IAppConfig>().theme.mainColor,
                    scaffoldBackgroundColor: getIt<IAppConfig>().theme.scaffoldBackgroundColor,
                    fontFamily: getIt<IAppConfig>().theme.fontFamily,
                    textTheme: getIt<IAppConfig>().theme.textTheme,
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: getIt<IAppConfig>().theme.mainColor,
                      selectionColor: getIt<IAppConfig>().theme.mainColor,
                      selectionHandleColor: getIt<IAppConfig>().theme.mainColor,
                    ),
                    cupertinoOverrideTheme: CupertinoThemeData(
                      primaryColor: getIt<IAppConfig>().theme.mainColor,
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
                  supportedLocales: context.read<LocaleNotifier>().supportedLocales,
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
