import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../core/core.dart';
import '../core/theme/theme_cubit.dart';
import '../features/bluetooth/bluetooth.dart';
import '../features/chronic_tracking/blood_glucose/blood_glucose.dart';
import '../features/chronic_tracking/blood_pressure/blood_pressure.dart';
import '../features/chronic_tracking/home/viewmodel/scale_progress_vm.dart';
import '../features/dashboard/home/viewmodel/home_vm.dart';
import '../features/doctor/notifiers/bg_measurements_notifiers.dart';
import '../features/doctor/notifiers/patient_notifiers.dart';
import 'atom_app.dart';

class MyAppCommon extends StatefulWidget {
  final String initialRoute;
  final bool jailbroken;
  final AppThemeTypes initialTheme;

  const MyAppCommon({
    Key? key,
    required this.initialRoute,
    required this.initialTheme,
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
    return BlocProvider(
      create: (context) => ThemeCubit(
        initialTheme:
            getIt<IAppConfig>().utils.getThemeByType(widget.initialTheme),
        sharedPreferencesManager: getIt<ISharedPreferencesManager>(),
        appUtils: getIt<IAppConfig>().utils,
      ),
      child: Container(
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
                  AppInheritedWidget.of(context)
                      ?.changeOrientation(orientation);

                  return AtomApp(
                    initialRoute: widget.initialRoute,
                    jailbroken: widget.jailbroken,
                    themeNotifier: themeNotifier,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
