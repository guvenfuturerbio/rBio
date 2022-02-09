part of 'ble_operators.dart';

class BleScannerOps extends ChangeNotifier {
  final _devices = <DiscoveredDevice>[];

  final FlutterReactiveBle _ble;

  String? _deviceId;
  List<String>? pairedDevices;

  StreamSubscription? _subscription;

  BleScannerOps(this._ble) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      try {
        final List<PairedDevice> pairedDevice =
            await getIt<BleDeviceManager>().getPairedDevices();
        pairedDevices = pairedDevice.map((e) => e.deviceId!).toList();
      } catch (e) {
        LoggerUtils.instance.e('Paired device coming null');
      }
    });
  }

  final List<Uuid> _supported = [
    Uuid.parse("1808"),
    Uuid([0x18, 0x1B])
  ];

  List<DiscoveredDevice> get discoveredDevices => _devices;

  set deviceId(String rhsDeviceId) => _deviceId = rhsDeviceId;
  String get deviceId => _deviceId ?? '';

  Future<void> startScan() async {
    _ble.statusStream.listen((bleStatus) async {
      if (bleStatus == BleStatus.ready) {
        _devices.clear();
        _subscription?.cancel();
        _subscription = _ble.scanForDevices(withServices: _supported).listen(
            (device) async {
          final knownDeviceIndex =
              _devices.indexWhere((d) => d.id == device.id);
          if (knownDeviceIndex >= 0) {
            _devices[knownDeviceIndex] = device;
          } else {
            _devices.add(device);

            /// AutoConnector Methode caller
            if (pairedDevices != null && pairedDevices!.contains(device.id)) {
              getIt<BleConnectorOps>().connect(device);
            }
            /*  if (device.id == deviceId) {
              locator<BleConnectorOps>().connect(device);
            } */
            notifyListeners();
          }
        }, onError: (e) => log(e.toString()));
      } else if (bleStatus == BleStatus.unauthorized) {
        await Future.delayed(const Duration(seconds: 1));
        await Permission.location.request();
      } else if (bleStatus == BleStatus.poweredOff) {
        await Future.delayed(const Duration(seconds: 1));

        // await SystemShortcuts.bluetooth();
      }
    });
  }

  Future<void> stopScan() async {
    await _subscription?.cancel();
    _subscription = null;
    notifyListeners();
  }

  void refreshDeviceList() {
    _devices.clear();
    notifyListeners();
  }
}
