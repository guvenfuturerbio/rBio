part of '../../devices.dart';

class SelectedDeviceVm extends ChangeNotifier {
  final DeviceType deviceType;

  SelectedDeviceVm(this.deviceType) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) async {
        var devices = await getIt<BluetoothConnector>().getPairedDevices();
        if (devices.isEmpty) {
          Atom.context
              .read<BluetoothBloc>()
              .add(const BluetoothEvent.scanStarted());
        }

        if (!_disposed) {
          final bluetoothBloc = Atom.context.read<BluetoothBloc>();
          bluetoothBloc.stream.listen((event) {
            if ((bluetoothBloc.state.controlPointResponse ?? []).isNotEmpty) {
              if (!Atom.isDialogShow) {
                showLoadingDialog();
              }

              final deviceId = bluetoothBloc.state.device?.id;
              if (deviceId != null) {
                Atom.context
                    .read<BluetoothBloc>()
                    .add(BluetoothEvent.disconnect(deviceId));
              }
            }
          });
        }
      },
    );
  }

  bool _disposed = false;
  bool connectIsActive = true;

  Map<String, String> getPairOrder() {
    switch (deviceType) {
      case DeviceType.accuChek:
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
      case DeviceType.accuChek:
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

  void showLoadingDialog() {
    Atom.show(
      GuvenAlert(
        backgroundColor: getIt<ITheme>().cardBackgroundColor,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //
            Container(
              child: ShakeAnimatedWidget(
                enabled: true,
                duration: const Duration(milliseconds: 1500),
                shakeAngle: Rotation.deg(z: 10),
                curve: Curves.linear,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: Atom.context.width * .04,
                  height: Atom.context.width * .04,
                  child: SvgPicture.asset(
                    R.image.logo,
                    color: getIt<ITheme>().mainColor,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: getIt<ITheme>().mainColor, width: 10),
                borderRadius: R.sizes.borderRadiusCircular,
              ),
            ),

            //
            const SizedBox(
              height: 16,
            ),

            //
            Text(
              LocaleProvider.current.pair_successful,
              style: TextStyle(color: R.color.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),

            //
            const SizedBox(
              height: 16,
            ),

            //
            GuvenAlert.buildWhiteAction(
              text: LocaleProvider.current.ok,
              onPressed: () {
                Atom.context
                    .read<BluetoothBloc>()
                    .add(const BluetoothEvent.clearedControlPointResponse());
                Atom.dismiss();
                Atom.historyBack();
                Atom.historyBack();
                Atom.to(PagePaths.devices, isReplacement: true);
              },
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void connectDevice(
    BluetoothState bluetoothState,
    DiscoveredDevice device,
  ) async {
    switch (deviceType) {
      case DeviceType.accuChek:
        connectIsActive &&
                (bluetoothState.deviceConnectionState !=
                        DeviceConnectionState.connecting &&
                    bluetoothState.deviceConnectionState !=
                        DeviceConnectionState.connected)
            ? Atom.context
                .read<BluetoothBloc>()
                .add(BluetoothEvent.connected(device))
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
                .add(BluetoothEvent.connected(device))
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
                .add(BluetoothEvent.connected(device))
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
