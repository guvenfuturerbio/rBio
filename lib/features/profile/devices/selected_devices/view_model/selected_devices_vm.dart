part of '../../devices.dart';

class SelectedDeviceVm extends ChangeNotifier {
  final DeviceType deviceType;

  SelectedDeviceVm({this.deviceType}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var devices = await getIt<BleDeviceManager>().getPairedDevices();
      if (devices.isEmpty) {
        getIt<BleScannerOps>().startScan();
      }
      if (!_disposed) {
        getIt<BleReactorOps>().addListener(() {
          if (getIt<BleReactorOps>().controlPointResponse.isNotEmpty) {
            if (!Atom.isDialogShow) {
              showLoadingDialog();
            }
            getIt<BleConnectorOps>()
                .disconnect(getIt<BleConnectorOps>().device.id);
          }
        });
      }
    });
  }

  bool _disposed = false;
  bool _connectIsActive = true;
  bool get connectIsActive => this._connectIsActive;

  Map<String, String> getPairOrder() {
    switch (deviceType) {
      case DeviceType.ACCU_CHEK:
        Map<String, String> map = <String, String>{
          '1': LocaleProvider.current.device_connection_step_1,
          '2': LocaleProvider.current.device_connection_step_2_Roche,
          '3': LocaleProvider.current.device_connection_step_3_Roche,
        };

        return map;

      case DeviceType.CONTOUR_PLUS_ONE:
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

      case DeviceType.MI_SCALE:
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
      case DeviceType.ACCU_CHEK:
        return device.manufacturerData[0] == 112;
        break;
      case DeviceType.CONTOUR_PLUS_ONE:
        return device.manufacturerData[0] == 103;
        break;
      case DeviceType.OMRON_BLOOD_PRESSURE_ARM:
        return false;
        break;
      case DeviceType.OMRON_BLOOD_PRESSURE_WRIST:
        return false;
        break;
      case DeviceType.OMRON_SCALE:
        return false;
        break;
      case DeviceType.MI_SCALE:
        return device.name == 'MIBFS' &&
            device.serviceData.length == 1 &&
            device.serviceData.values.first.length == 13;
        break;
      default:
        throw Exception('Undefined Device Type');
    }
  }

  showLoadingDialog() {
    Atom.show(GuvenAlert(
      backgroundColor: getIt<ITheme>().cardBackgroundColor,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: ShakeAnimatedWidget(
              enabled: true,
              duration: Duration(milliseconds: 1500),
              shakeAngle: Rotation.deg(z: 10),
              curve: Curves.linear,
              child: Container(
                padding: EdgeInsets.all(16),
                width: Atom.context.WIDTH * .04,
                height: Atom.context.WIDTH * .04,
                child: SvgPicture.asset(
                  R.image.logo,
                  color: R.color.dark_blue,
                ),
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: R.color.main_color, width: 10),
                borderRadius: BorderRadius.all(Radius.circular(200))),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            LocaleProvider.current.pair_successful,
            style: TextStyle(color: R.color.black, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          GuvenAlert.buildWhiteAction(
              text: LocaleProvider.current.ok,
              onPressed: () {
                getIt<BleReactorOps>().clearControlPointResponse();

                Atom.dismiss();

                Atom.historyBack();
                Atom.historyBack();
                Atom.to(PagePaths.DEVICES, isReplacement: true);
              })
        ],
      ),
    ));
  }

  void connectDevice(BleConnectorOps _bleConnectorOps,
      BleScannerOps _bleScannerOps, device) async {
    switch (deviceType) {
      case DeviceType.ACCU_CHEK:
        connectIsActive &&
                (_bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connecting &&
                    _bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connected)
            ? _bleConnectorOps.connect(
                // ignore: unnecessary_statements
                device)
            : null;
        connectClicked();
        break;
      case DeviceType.CONTOUR_PLUS_ONE:
        connectIsActive &&
                (_bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connecting &&
                    _bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connected)
            ? _bleConnectorOps.connect(
                // ignore: unnecessary_statements
                device)
            : null;
        connectClicked();
        break;
      case DeviceType.OMRON_BLOOD_PRESSURE_ARM:
        // TODO: Handle this case.
        break;
      case DeviceType.OMRON_BLOOD_PRESSURE_WRIST:
        // TODO: Handle this case.
        break;
      case DeviceType.OMRON_SCALE:
        // TODO: Handle this case.
        break;
      case DeviceType.MI_SCALE:
        connectIsActive &&
                (_bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connecting &&
                    _bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connected)
            ? _bleConnectorOps.connect(
                // ignore: unnecessary_statements
                device)
            : null;
        connectClicked();
        break;
      default:
        null;
    }
  }

  connectClicked() async {
    this._connectIsActive = false;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    this._connectIsActive = true;
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
