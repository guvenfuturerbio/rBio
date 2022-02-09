part of 'ble_operators.dart';

class BleConnectorOps extends ChangeNotifier {
  FlutterReactiveBle _ble;

  bool isFirstConnect = true;

  final List<ConnectionStateUpdate> _deviceConnectionStateUpdate = [];

  DiscoveredDevice? _device;

  StreamSubscription<ConnectionStateUpdate>? _connection;

  // ignore: close_sinks
  final _deviceConnectionController = StreamController<ConnectionStateUpdate>();

  BleConnectorOps(this._ble) {
    listenConnectedDeviceStream();
  }

  List<ConnectionStateUpdate> get deviceConnectionState =>
      _deviceConnectionStateUpdate;

  DiscoveredDevice? get device => _device;

  void listenConnectedDeviceStream() {
    _ble.connectedDeviceStream.listen((event) {
      if (event.deviceId == device?.id) {
        final deviceIndex = _deviceConnectionStateUpdate
            .indexWhere((element) => element.deviceId == event.deviceId);
        if (deviceIndex != -1) {
          _deviceConnectionStateUpdate[deviceIndex] = event;
        } else {
          _deviceConnectionStateUpdate.add(event);
        }
        notifyListeners();
        if (event.connectionState == DeviceConnectionState.connected) {
          switch (getDeviceType(device!)) {
            case DeviceType.accuChek:
              getIt<BleReactorOps>().write(device!);
              break;
            case DeviceType.contourPlusOne:
              getIt<BleReactorOps>().write(device!);
              break;
            case DeviceType.miScale:
              getIt<BleReactorOps>().subscribeScaleDevice(device!);
              break;
            default:
              break;
          }
        } else if (event.connectionState ==
            DeviceConnectionState.disconnected) {
          getIt<BleScannerOps>().refreshDeviceList();
        }
      }
    });
  }

  Future<void> connect(DiscoveredDevice device) async {
    _device = device;
    notifyListeners();
    if (_connection != null) {
      await _connection!.cancel();
    }

    _connection = _ble.connectToDevice(id: device.id).listen(
          _deviceConnectionController.add,
        );
  }

  Future<void> disconnect(String deviceId) async {
    if (_connection != null) {
      try {
        await _connection!.cancel();
      } finally {
        _deviceConnectionController.add(ConnectionStateUpdate(
            deviceId: deviceId,
            connectionState: DeviceConnectionState.disconnected,
            failure: null));
      }
    }
  }

  Future<void> removePairedDevice() async {
    if (_connection != null) {
      await _connection!.cancel();
    }
  }

  ConnectionStateUpdate? getStatus(String id) {
    final deviceIndex = _deviceConnectionStateUpdate
        .indexWhere((element) => element.deviceId == id);
    if (deviceIndex != -1) {
      return _deviceConnectionStateUpdate[deviceIndex];
    } else {
      return null;
    }
  }

  @override
  Future<void> dispose() async {
    await _deviceConnectionController.close();
    super.dispose();
  }
}
