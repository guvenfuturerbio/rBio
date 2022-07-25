import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../core/core.dart';
import '../features/bluetooth/bluetooth.dart';
import '../features/bluetooth_v2/bluetooth_v2.dart';
import '../features/chronic_tracking/blood_glucose/blood_glucose.dart';
import '../features/chronic_tracking/blood_pressure/blood_pressure.dart';
import '../features/chronic_tracking/home/viewmodel/scale_progress_vm.dart';
import '../features/chronic_tracking/scale/scale.dart';
import '../features/dashboard/home/viewmodel/home_vm.dart';
import '../features/doctor/notifiers/bg_measurements_notifiers.dart';
import '../features/doctor/notifiers/patient_notifiers.dart';

abstract class MyApp {
  bool jailbroken = false;
  void setJailbroken(bool value) {
    jailbroken = value;
  }

  Widget build(BuildContext context);
}

class MobileMyApp extends StatelessWidget with MyApp {
  final String initialRoute;

  MobileMyApp({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BluetoothStatusCubit, BluetoothStatus>(
      listener: (BuildContext context, BluetoothStatus bluetoothState) {
        final miScaleDevices = context.read<MiScaleStatusCubit>().state.device;
        if (miScaleDevices != null) {
          if (bluetoothState == BluetoothStatus.on) {
            context.read<DeviceSelectedCubit>().connect(miScaleDevices);
          } else if (bluetoothState == BluetoothStatus.off) {
            context.read<DeviceSelectedCubit>().disconnect(miScaleDevices);
          }
        }
      },
      child: BlocListener<MiScaleOpsCubit, MiScaleOpsState>(
        listener: (BuildContext context, MiScaleOpsState state) =>
            _miScaleListener(context, state),
        child: BlocListener<MiScaleStatusCubit, MiScaleStatus>(
          listener: (BuildContext context, MiScaleStatus miScaleStatus) {
            if (miScaleStatus.status == DeviceStatus.connected) {
              if (miScaleStatus.device != null) {
                BlocProvider.of<MiScaleOpsCubit>(context)
                    .readValue(miScaleStatus.device!);
              }
            } else if (miScaleStatus.status == DeviceStatus.disconnected) {
              BlocProvider.of<MiScaleOpsCubit>(context).stopListen();
            }
          },
          child: MyAppCommon(
            initialRoute: initialRoute,
            jailbroken: super.jailbroken,
          ),
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
      showLoading: (ScaleEntity scaleEntity) {
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

  WebMyApp({
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
  final bool jailbroken;

  const MyAppCommon({
    Key? key,
    required this.initialRoute,
    this.jailbroken = false,
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
            create: (context) => HomeVm(
              mContext: context,
              appConfig: getIt(),
              repository: getIt(),
              userFacade: getIt(),
              userNotifier: getIt(),
              sharedPreferencesManager: getIt(),
            ),
          ),
          ChangeNotifierProvider<ThemeNotifier>(
            create: (context) => ThemeNotifier(
              getIt<ISharedPreferencesManager>(),
            ),
          ),
          ChangeNotifierProvider<UserNotifier>(
            create: (context) => getIt<UserNotifier>(),
          ),
          ChangeNotifierProvider<ScaleProgressVm>(
            create: (ctx) => ScaleProgressVm(),
          ),
          ChangeNotifierProvider<BgProgressVm>.value(
            value: BgProgressVm(context),
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
                  initialUrl: widget.jailbroken == true
                      ? PagePaths.jailbroken
                      : widget.initialRoute,
                  routes: VRouterRoutes.routes(getIt<IAppConfig>()),
                  onPop: (vRedirector) async {},
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
                    fontFamily: getIt<IAppConfig>().theme.fontFamily,
                    textTheme: getIt<IAppConfig>().theme.textTheme,
                    primaryColor: getIt<IAppConfig>().theme.primaryColor,
                    scaffoldBackgroundColor:
                        getIt<IAppConfig>().theme.scaffoldBackgroundColor,

                    // * ColorScheme
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: getIt<IAppConfig>().theme.primaryColor,
                    ).copyWith(
                      secondary: getIt<IAppConfig>().theme.secondaryColor,
                      primary: getIt<IAppConfig>().theme.textColor,
                      inversePrimary:
                          getIt<IAppConfig>().theme.inverseTextColor,
                      onPrimary: getIt<IAppConfig>().theme.onPrimaryTextColor,
                      secondaryContainer:
                          getIt<IAppConfig>().theme.secondaryContainerColor,
                    ),

                    // * CardTheme
                    cardTheme: const CardTheme().copyWith(
                      elevation: 0.0,
                      color: getIt<IAppConfig>().theme.cardBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: R.sizes.borderRadiusCircular,
                      ),
                    ),

                    // * AppBarTheme
                    appBarTheme: AppBarTheme(
                      backgroundColor: getIt<IAppConfig>().theme.appbarColor,
                      titleTextStyle: getIt<IAppConfig>()
                          .theme
                          .textTheme
                          .headline1
                          ?.copyWith(
                            color: getIt<IAppConfig>().theme.appbarTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                      iconTheme: IconThemeData(
                        color: getIt<IAppConfig>().theme.appbarIconColor,
                      ),
                    ),

                    // * BottomNavigationBarTheme
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor:
                          getIt<IAppConfig>().theme.bottomMenuColor,
                    ),

                    // * IconTheme
                    iconTheme: IconThemeData(
                      color: getIt<IAppConfig>().theme.iconColor,
                    ),

                    // * FloatingActionButtonTheme
                    floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor:
                          getIt<IAppConfig>().theme.fabBackgroundColor,
                    ),

                    // * TextSelectionTheme
                    textSelectionTheme:
                        getIt<IAppConfig>().theme.textSelectionTheme,

                    // * CupertinoTheme
                    cupertinoOverrideTheme:
                        getIt<IAppConfig>().theme.cupertinoTheme,

                    // * DialogTheme
                    dialogTheme: const DialogTheme(
                      //
                    ),
                  )..addCustomTheme(
                      MyCustomTheme(
                        iron: getIt<IAppConfig>().theme.iron,
                        grey: getIt<IAppConfig>().theme.grey,
                        white: getIt<IAppConfig>().theme.white,
                        black: getIt<IAppConfig>().theme.black,
                        punch: getIt<IAppConfig>().theme.punch,
                        roman: getIt<IAppConfig>().theme.roman,
                        malibu: getIt<IAppConfig>().theme.malibu,
                        deYork: getIt<IAppConfig>().theme.deYork,
                        skeptic: getIt<IAppConfig>().theme.skeptic,
                        boulder: getIt<IAppConfig>().theme.boulder,
                        mercury: getIt<IAppConfig>().theme.mercury,
                        codGray: getIt<IAppConfig>().theme.codGray,
                        gallery: getIt<IAppConfig>().theme.gallery,
                        concrete: getIt<IAppConfig>().theme.concrete,
                        supernova: getIt<IAppConfig>().theme.supernova,
                        tonysPink: getIt<IAppConfig>().theme.tonysPink,
                        dustyGray: getIt<IAppConfig>().theme.dustyGray,
                        greenHaze: getIt<IAppConfig>().theme.greenHaze,
                        casablanca: getIt<IAppConfig>().theme.casablanca,
                        frenchPass: getIt<IAppConfig>().theme.frenchPass,
                        kournikova: getIt<IAppConfig>().theme.kournikova,
                        ultramarine: getIt<IAppConfig>().theme.ultramarine,
                        frenchLilac: getIt<IAppConfig>().theme.frenchLilac,
                        textDisabledColor:
                            getIt<IAppConfig>().theme.textDisabledColor,
                        energyYellow: getIt<IAppConfig>().theme.energyYellow,
                        cornflowerBlue:
                            getIt<IAppConfig>().theme.cornflowerBlue,
                        fuzzyWuzzyBrown:
                            getIt<IAppConfig>().theme.fuzzyWuzzyBrown,
                      ),
                    ),

                  //
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
