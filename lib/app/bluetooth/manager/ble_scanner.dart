part of 'ble_operators.dart';

class BleScanner {
  late final FlutterReactiveBle _ble;
  BleScanner(this._ble);

  final _myController = BehaviorSubject<List<DiscoveredDevice>>();
  Stream<List<DiscoveredDevice>> get myStream => _myController.stream;

  StreamSubscription? _scanDeviceSubscription;

  final _devices = <DiscoveredDevice>[];
  final List<Uuid> _supported = [
    // Blood glucosea ait verileri kontrol eden kod. (Diğer cihazlar için farklı kodlar var).
    Uuid.parse("1808"),
    // Kan şekeri ve tartılar karşımıza çıksın diye alttaki kodları kullanıyoruz. Bu kodlara sahip servislerin hepsini tarıyor ve gösteriyor.
    Uuid([0x18, 0x1B])
  ];

  List<String> _pairedDeviceIds = [];
  void setPairedDeviceIds(List<String> value) {
    _pairedDeviceIds = value;
    Atom.context
        .read<BluetoothBloc>()
        .add(BluetoothEvent.updatePairedIdList(_pairedDeviceIds));
  }

  Stream<BleStatus> listenBleStatus() async* {
    await for (var event in _ble.statusStream) {
      yield event;
    }
  }

  Future<void> statusHandler(BleStatus bleStatus) async {
    _scanDeviceSubscription?.cancel();
    if (bleStatus == BleStatus.ready) {
      _devices.clear();
      _scanDeviceSubscription = _ble.scanForDevices(withServices: _supported).listen(
        (device) async {
          final knownDeviceIndex =
              _devices.indexWhere((d) => d.id == device.id);
          if (knownDeviceIndex >= 0) {
            _devices[knownDeviceIndex] = device;
          } else {
            _devices.add(device);

            /// AutoConnector method caller
            if (_pairedDeviceIds.contains(device.id)) {
              Atom.context
                  .read<BluetoothBloc>()
                  .add(BluetoothEvent.connect(device));
            }

            _myController.sink.add(_devices);
          }
        },
        onError: (error) {
          LoggerUtils.instance.e("[BleScannerOps] - scanForDevices | $error");
        },
      );
    } else if (bleStatus == BleStatus.unauthorized) {
      await Future.delayed(const Duration(seconds: 1));
      await Permission.location.request();
    } else if (bleStatus == BleStatus.poweredOff) {
      await Future.delayed(const Duration(seconds: 1));
      // await SystemShortcuts.bluetooth();
    } else if (bleStatus == BleStatus.locationServicesDisabled) {
      await Future.delayed(const Duration(seconds: 1));
      await Permission.location.request();
    }
  }

  Future<void> stopScan() async {
    await _scanDeviceSubscription?.cancel();
    _scanDeviceSubscription = null;
  }

  void clearDiscoveredList() {
    _devices.clear();
  }
}
