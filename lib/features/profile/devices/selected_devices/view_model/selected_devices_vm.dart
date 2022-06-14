part of '../../devices.dart';

class SelectedDeviceVm extends ChangeNotifier {
  final DeviceType deviceType;

  SelectedDeviceVm(this.deviceType) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        var devices = getIt<BleDeviceManager>().getPairedDevices();
        if (devices.isEmpty) {
          Atom.context
              .read<BluetoothBloc>()
              .add(const BluetoothEvent.listenBleStatus());
        }

        if (!_disposed) {
          getIt<BleReactorOps>().addListener(
            () {
              if (getIt<BleReactorOps>().controlPointResponse.isNotEmpty) {
                if (!Atom.isDialogShow) {
                  showLoadingDialog();
                }

                final deviceId =
                    Atom.context.read<BluetoothBloc>().state.device?.id;
                if (deviceId != null) {
                  Atom.context
                      .read<BluetoothBloc>()
                      .add(const BluetoothEvent.disconnect());
                }
              }
            },
          );
        }
      },
    );
  }

  bool _disposed = false;
  bool connectIsActive = true;

  Map<String, String> getPairOrder() {
    switch (deviceType) {
      case DeviceType.accuCheck:
        Map<String, String> map = <String, String>{
          '1': LocaleProvider.current.device_connection_step_1,
          '2': LocaleProvider.current.device_connection_step_2_Roche,
          '3': LocaleProvider.current.device_connection_step_3_Roche,
        };

        return map;

      case DeviceType.contourPlusOne:
        Map<String, String> map = <String, String>{
          '1': LocaleProvider.current.device_connection_step_1,
          '2': LocaleProvider.current.device_connection_step_2_Contour,
          '3': LocaleProvider.current.device_connection_step_3_Contour,
        };
        if (Atom.isIOS) {
          map.addAll(
              {'4': LocaleProvider.current.device_connection_step_4_Roche});
        }
        return map;

      case DeviceType.miScale:
        return <String, String>{
          '1': LocaleProvider.current.device_scale_connection_step_1_mi_scale,
          '2': LocaleProvider.current.device_scale_connection_step_2_mi_scale,
          '3': LocaleProvider.current.device_scale_connection_step_3_mi_scale,
        };
      default:
        return <String, String>{};
    }
  }

  bool isFocusedDevice(DiscoveredDevice device) {
    switch (deviceType) {
      case DeviceType.accuCheck:
        return device.manufacturerData[0] == 112;

      case DeviceType.contourPlusOne:
        return device.manufacturerData[0] == 103;

      case DeviceType.omronBloodPressureArm:
        return false;

      case DeviceType.omronBloodPressureWrist:
        return false;

      case DeviceType.omronScale:
        return false;

      case DeviceType.miScale:
        return device.name == 'MIBFS' &&
            device.serviceData.length == 1 &&
            device.serviceData.values.first.length == 13;

      default:
        throw Exception('Undefined Device Type');
    }
  }

  Future<void> showLoadingDialog() async {
    Utils.instance.showSuccessSnackbar(
      Atom.context,
      LocaleProvider.current.pair_successful,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () {
        Atom.to(
          PagePaths.main,
          isReplacement: true,
        );
      },
    );
  }

  void connectDevice(
    BluetoothV1State bluetoothState,
    DiscoveredDevice device,
  ) async {
    switch (deviceType) {
      case DeviceType.accuCheck:
        connectIsActive &&
                (bluetoothState.deviceConnectionState !=
                        DeviceConnectionState.connecting &&
                    bluetoothState.deviceConnectionState !=
                        DeviceConnectionState.connected)
            ? Atom.context
                .read<BluetoothBloc>()
                .add(BluetoothEvent.connect(device))
            : null;
        connectClicked();
        break;

      case DeviceType.contourPlusOne:
        connectIsActive &&
                (bluetoothState.deviceConnectionState !=
                        DeviceConnectionState.connecting &&
                    bluetoothState.deviceConnectionState !=
                        DeviceConnectionState.connected)
            ? Atom.context
                .read<BluetoothBloc>()
                .add(BluetoothEvent.connect(device))
            : null;
        connectClicked();
        break;

      case DeviceType.omronBloodPressureArm:
        break;

      case DeviceType.omronBloodPressureWrist:
        break;

      case DeviceType.omronScale:
        break;

      case DeviceType.miScale:
        connectIsActive &&
                (bluetoothState.deviceConnectionState !=
                        DeviceConnectionState.connecting &&
                    bluetoothState.deviceConnectionState !=
                        DeviceConnectionState.connected)
            ? Atom.context
                .read<BluetoothBloc>()
                .add(BluetoothEvent.connect(device))
            : null;
        connectClicked();
        break;
      default:
        null;
    }
  }

  connectClicked() async {
    connectIsActive = false;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    connectIsActive = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
