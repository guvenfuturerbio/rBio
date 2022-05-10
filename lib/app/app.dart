import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../core/core.dart';
import '../features/chronic_tracking/progress_sections/blood_glucose/viewmodel/bg_progress_vm.dart';
import '../features/chronic_tracking/progress_sections/blood_pressure/viewmodel/bp_progres_vm.dart';
import '../features/chronic_tracking/progress_sections/scale/scale.dart';
import '../features/chronic_tracking/progress_sections/scale/scale_detail/scale_detail.dart';
import '../features/dashboard/home/viewmodel/home_vm.dart';
import '../features/doctor/notifiers/bg_measurements_notifiers.dart';
import '../features/doctor/notifiers/patient_notifiers.dart';
import 'bluetooth_v2/bluetooth_v2.dart';

class MyApp extends StatefulWidget {
  final String initialRoute;

  const MyApp({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

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
    return !kIsWeb
        ? BlocListener<MiScaleOpsCubit, MiScaleOpsState>(
            listener: (context, state) => _miScaleListener(context, state),
            child: BlocListener<MiScaleStatusCubit, MiScaleStatus>(
              listener: (context, miScaleStatus) {
                if (miScaleStatus.status == DeviceStatus.connected) {
                  if (miScaleStatus.device != null) {
                    BlocProvider.of<MiScaleOpsCubit>(context)
                        .readValue(miScaleStatus.device!);
                  }
                } else if (miScaleStatus.status == DeviceStatus.disconnected) {
                  BlocProvider.of<MiScaleOpsCubit>(context).stopListen();
                }
              },
              child: _buildMultiProvider(context),
            ),
          )
        : _buildMultiProvider(context);
  }

  Widget _buildMultiProvider(BuildContext context) {
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
                    scaffoldBackgroundColor:
                        getIt<IAppConfig>().theme.scaffoldBackgroundColor,
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
