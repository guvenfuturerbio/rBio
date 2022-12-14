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
    // Blood Glucose Services
    Uuid.parse("1808"),

    // Scale Services
    Uuid.parse("181B"),

    // BloodPressure Services
    Uuid.parse("1810"),
  ];

  List<DiscoveredDevice> get discoveredDevices => _devices;

  set deviceId(String rhsDeviceId) => _deviceId = rhsDeviceId;
  String get deviceId => _deviceId ?? '';

  Future<void> startScan() async {
    /// Setting api key for omron sdk
    OmronConnector.instance;
    //Cihaz açık mı kontrolü yapılıyor.
    _ble.statusStream.listen((bleStatus) async {
      LoggerUtils.instance.wtf('DENEME');
      LoggerUtils.instance.w(bleStatus);

      if (bleStatus == BleStatus.ready) {
        _devices.clear();
        _subscription?.cancel();
        //Alttaki satır arama yapıyor ve stream olduğu için sürekli olarak dinliyor.
        _subscription = _ble.scanForDevices(withServices: _supported).listen(
            (device) async {
              LoggerUtils.instance.w(device);
              final knownDeviceIndex =
                  _devices.indexWhere((d) => d.id == device.id);
              LoggerUtils.instance.e(knownDeviceIndex);
              if (knownDeviceIndex >= 0) {
                _devices[knownDeviceIndex] = device;
              } else {
                _devices.add(device);

                /// AutoConnector method caller
                if (pairedDevices != null &&
                    pairedDevices!.contains(device.id)) {
                  getIt<BleConnectorOps>().connect(device);
                }

                notifyListeners();
              }
            },
            cancelOnError: true,
            onError: (e) {
              LoggerUtils.instance.e(e);
            });
      } else if (bleStatus == BleStatus.unauthorized) {
        await Future.delayed(const Duration(seconds: 1));
        await Permission.location.request();
      } else if (bleStatus == BleStatus.poweredOff) {
        await Future.delayed(const Duration(seconds: 1));

        // await SystemShortcuts.bluetooth();
      } else if (bleStatus == BleStatus.locationServicesDisabled) {
        await Future.delayed(const Duration(seconds: 1));
        await Permission.location.request();
        LoggerUtils.instance.i("DOĞAN");
      }
    });
  }

  Future<void> stopScan() async {
    await _subscription?.cancel();
    _subscription = null;
    notifyListeners();
  }

  void refreshDeviceList() {
    LoggerUtils.instance.w("RefreshList");
    _devices.clear();
    notifyListeners();
  }
}
