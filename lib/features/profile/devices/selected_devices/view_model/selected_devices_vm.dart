part of '../../devices.dart';

class SelectedDeviceVm extends ChangeNotifier {
  final DeviceType deviceType;

  SelectedDeviceVm(this.deviceType) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) async {
        var devices = await getIt<BleDeviceManager>().getPairedDevices();
        if (!(deviceType.name ?? '').toUpperCase().contains('OMRON')) {
          if (devices.isEmpty) {
            getIt<BleScannerOps>().startScan();
          }

          if (!_disposed) {
            getIt<BleReactorOps>().addListener(
              () {
                if (getIt<BleReactorOps>().controlPointResponse.isNotEmpty) {
                  if (!Atom.isDialogShow) {
                    showLoadingDialog();
                  }

                  final deviceId = getIt<BleConnectorOps>().device?.id;
                  if (deviceId != null) {
                    getIt<BleConnectorOps>().disconnect(deviceId);
                  }
                }
              },
            );
          }
        } else {
          StartOmronManagerModel startOmronManagerModel =
              StartOmronManagerModel(
                  device: deviceType.getIndex,
                  categoryType: deviceType.category,
                  hashId: (getIt<UserNotifier>().patient!.identityNumber) ??
                      getIt<UserNotifier>().patient!.email!);

          OmronConnector.instance.scanSpesificPeripheral(startOmronManagerModel,
              (value) {
            LoggerUtils.instance.i(value);
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
    try {
      switch (deviceType) {
        case DeviceType.accuChek:
          return device.manufacturerData[0] == 112;

        case DeviceType.contourPlusOne:
          return device.manufacturerData[0] == 103;

        case DeviceType.omronBloodPressureArm:
          if (device.id.substring(0, 8) == '28:FF:B2' &&
              device.name.substring(0, 17) == 'BLEsmart_00000264') {
            return true;
          } else {
            return false;
          }

        case DeviceType.omronBloodPressureWrist:
          if (device.id.substring(0, 8) == '28:FF:B2' &&
              device.name.substring(0, 17) == 'BLEsmart_00000244') {
            return true;
          } else {
            return false;
          }

        case DeviceType.omronScale:
          return false;

        case DeviceType.miScale:
          return device.name == 'MIBFS' &&
              device.serviceData.length == 1 &&
              device.serviceData.values.first.length == 13;

        default:
          throw Exception('Undefined Device Type');
      }
    } catch (e) {
      LoggerUtils.instance.e(e.toString());
      rethrow;
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
                    color: R.color.dark_blue,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: R.color.main_color, width: 10),
                borderRadius: R.sizes.borderRadiusCircular,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              LocaleProvider.current.pair_successful,
              style: TextStyle(color: R.color.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            GuvenAlert.buildWhiteAction(
              text: LocaleProvider.current.ok,
              onPressed: () {
                getIt<BleReactorOps>().clearControlPointResponse();
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
    BleConnectorOps _bleConnectorOps,
    BleScannerOps _bleScannerOps,
    DiscoveredDevice device,
  ) async {
    LoggerUtils.instance.w('clicked');

    /// Checking has device in the ConnectionState
    bool isDeviceHasConnectionState = _bleConnectorOps.deviceConnectionState
        .any((element) => element.deviceId == device.id);

    ConnectionStateUpdate? deviceConnectionState = isDeviceHasConnectionState
        ? _bleConnectorOps.deviceConnectionState
            .firstWhere((element) => element.deviceId == device.id)
        : null;

    late bool hasComingDeviceIsConnectingOrConnected;

    if (deviceConnectionState != null) {
      deviceConnectionState.connectionState !=
              DeviceConnectionState.connecting &&
          deviceConnectionState.connectionState !=
              DeviceConnectionState.connected;
      hasComingDeviceIsConnectingOrConnected = true;
    } else {
      hasComingDeviceIsConnectingOrConnected = false;
    }

    switch (deviceType) {
      case DeviceType.accuChek:
        connectIsActive && hasComingDeviceIsConnectingOrConnected
            ? _bleConnectorOps.connect(device)
            : null;
        connectClicked();
        break;

      case DeviceType.contourPlusOne:
        connectIsActive && hasComingDeviceIsConnectingOrConnected
            ? _bleConnectorOps.connect(device)
            : null;
        connectClicked();
        break;

      case DeviceType.omronBloodPressureArm:
        break;
      case DeviceType.omronBloodPressureWrist:
        connectIsActive && !hasComingDeviceIsConnectingOrConnected
            ? _bleConnectorOps.connect(device)
            : null;
        connectClicked();
        break;
      case DeviceType.omronScale:
        break;
      case DeviceType.miScale:
        connectIsActive && hasComingDeviceIsConnectingOrConnected
            ? _bleConnectorOps.connect(device)
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
