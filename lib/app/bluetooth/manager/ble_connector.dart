part of 'ble_operators.dart';

class BleConnector {
  late final FlutterReactiveBle _ble;
  BleConnector(this._ble);

  List<ConnectionStateUpdate> get deviceConnectionState =>
      _deviceConnectionStateUpdate;
  final List<ConnectionStateUpdate> _deviceConnectionStateUpdate = [];

  DiscoveredDevice? get device => _device;
  DiscoveredDevice? _device;

  StreamSubscription<ConnectionStateUpdate>? _connection;

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
        Atom.context.read<BluetoothBloc>().add(
              BluetoothEvent.updateDeviceConnectionList(
                  _deviceConnectionStateUpdate),
            );

        // Reactor dosyasına gönderilen kısım. Cihazı tanıdıktan sonra cihazın verilerini yazıyoruz.
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
          Atom.context
              .read<BluetoothBloc>()
              .add(const BluetoothEvent.updateDiscoveredList([]));
        }
      }
    });
  }

  DeviceType getDeviceType(DiscoveredDevice device) {
    if (device.name == 'MIBFS' &&
        device.serviceData.length == 1 &&
        device.serviceData.values.first.length == 13) {
      return DeviceType.miScale;
    } else if (device.manufacturerData[0] == 112) {
      return DeviceType.accuChek;
    } else if (device.manufacturerData[0] == 103) {
      return DeviceType.contourPlusOne;
    }

    throw Exception('Nondefined device');
  }

  Future<void> connect(DiscoveredDevice device) async {
    _device = device;

    // Herhangi bir connection varsa connection silme işlemi yapıyoruz.
    await _connection?.cancel();

    //Gerekli cihazı gönderip bağlantı kuruluyor.
    _connection = _ble.connectToDevice(id: device.id).listen((event) {});
  }

  Future<void> disconnect() async {
    _device = null;
    await _connection?.cancel();
  }

  Future<void> removePairedDevice() async {
    if (_connection != null) {
      await _connection!.cancel();
    }
  }

  // Bağlanmak için cihazı seçtiğimizde kartın rengi için cihaz status durumunu liste edip okuduğumuz kısım.
  ConnectionStateUpdate? getStatus(String id) {
    final deviceIndex = _deviceConnectionStateUpdate
        .indexWhere((element) => element.deviceId == id);
    if (deviceIndex != -1) {
      return _deviceConnectionStateUpdate[deviceIndex];
    } else {
      return null;
    }
  }
}
