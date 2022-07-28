import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/config.dart';
import '../core/core.dart';
import '../features/bluetooth/bluetooth.dart';
import '../features/bluetooth_v2/bluetooth_v2.dart';
import '../features/chronic_tracking/scale/scale.dart';
import 'my_app.dart';
import 'my_app_common.dart';

class MobileApp extends StatelessWidget {
  final MyApp myApp;
  final bool jailbroken;

  const MobileApp({
    Key? key,
    required this.myApp,
    required this.jailbroken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myApp.setJailbroken(jailbroken);
    return BlocProvider<BluetoothBloc>(
      lazy: false,
      create: (context) => BluetoothBloc(
        getIt<BleScanner>(),
        getIt<BleConnector>(),
        getIt<BleDeviceManager>(),
      )..add(const BluetoothEvent.init()),
      child: BlocProvider<MiScaleStatusCubit>(
        lazy: false,
        create: (context) => MiScaleStatusCubit(getIt()),
        child: Builder(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<BluetoothStatusCubit>(
                  lazy: false,
                  create: (context) =>
                      BluetoothStatusCubit(getIt())..listenStateOfBluetooth(),
                ),

                //
                BlocProvider<DeviceSearchCubit>(
                  create: (context) => DeviceSearchCubit(getIt(), getIt()),
                ),

                //
                BlocProvider<DeviceSelectedCubit>(
                  create: (context) => DeviceSelectedCubit(
                    context.read<MiScaleStatusCubit>(),
                    getIt(),
                    getIt(),
                    getIt(),
                    getIt(),
                    getIt(),
                  ),
                ),

                //
                BlocProvider<MiScaleOpsCubit>(
                  create: (context) => MiScaleOpsCubit(getIt(), getIt()),
                ),
              ],
              child: myApp.build(context),
            );
          },
        ),
      ),
    );
  }
}

class MobileMyApp extends StatelessWidget with MyApp {
  final String initialRoute;
  final AppThemeTypes initialTheme;

  MobileMyApp({
    Key? key,
    required this.initialRoute,
    required this.initialTheme,
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
            initialTheme: initialTheme,
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
          Atom.show(const ScaleMeasurementDialog());
        }
      },
      dismissLoading: () {
        Atom.dismiss();
      },
      showScalePopup: (scaleEntity) {
        Atom.show(
          ScaleMeasurementResultDialog(scaleEntity: scaleEntity),
          barrierDismissible: false,
        );
      },
    );
  }
}
