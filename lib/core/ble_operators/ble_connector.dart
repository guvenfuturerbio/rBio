part of 'ble_operators.dart';

class BleConnectorOps extends ChangeNotifier {
  late final FlutterReactiveBle _ble;

  BleConnectorOps(this._ble) {
    listenConnectedDeviceStream();
  }

  bool isFirstConnect = true;

  final List<ConnectionStateUpdate> _deviceConnectionStateUpdate = [];

  DiscoveredDevice? _device;

  StreamSubscription<ConnectionStateUpdate>? _connection;

  Map<String, dynamic> omronDeviceState = {
    'deviceId': 'UnKnown',
    'state': 0,
  };
  OmronCancelListening? omronConnectionListener;

  // ignore: close_sinks
  final _deviceConnectionController = StreamController<ConnectionStateUpdate>();

  List<ConnectionStateUpdate> get deviceConnectionState =>
      _deviceConnectionStateUpdate;

  DiscoveredDevice? get device => _device;

  void listenConnectedDeviceStream() {
    //Telefonla cihaz arasındaki bağlantı durumu dinleyen stream
    _ble.connectedDeviceStream.listen((event) {
      LoggerUtils.instance.w(event);
      if (event.deviceId == device?.id) {
        final deviceIndex = _deviceConnectionStateUpdate
            .indexWhere((element) => element.deviceId == event.deviceId);
// index aşağıda -1 değilse daha önce bir bağlantı var demektir. Kontrol bunun için yapılıyor.
        if (deviceIndex != -1) {
          _deviceConnectionStateUpdate[deviceIndex] = event;
        } else {
          _deviceConnectionStateUpdate.add(event);
        }
        notifyListeners();
        //Reactor dosyasına gönderilen kısım. Cihazı tanıdıktan sonra cihazın verilerini yazıyoruz.
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
            case DeviceType.omronBloodPressureWrist:

              /// Omron cihazın bağlantı durumu dinleniyor.
              omronConnectionListener =
                  OmronConnector.instance.connectionStateChecker((val) {
                omronDeviceState = {
                  'deviceId': device!.name,
                  'state': val,
                };
                notifyListeners();
              });
              getIt<BleReactorOps>().connectOmronWristPressureDevice(device!);
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

  Future<void> connect(DiscoveredDevice device,
      {DeviceType? deviceType, int? userIndex}) async {
    if (deviceType != null) {
      OmronDeviceConnectionRequestModel omronDeviceConnectionRequestModel =
          OmronDeviceConnectionRequestModel(
              deviceName: device.name,
              uuid: device.id,
              userIndex: userIndex!,
              hashId: getIt<UserNotifier>().patient!.identityNumber!);

      /// Omron cihazın bağlantı durumu dinleniyor.
      var connListener = OmronConnector.instance.connectionStateChecker((val) {
        omronDeviceState = {
          'deviceId': device.id,
          'state': val,
        };

        notifyListeners();
      });

      await OmronConnector.instance
          .connectDevice(omronDeviceConnectionRequestModel);
      await OmronConnector.instance
          .continueToConnection(omronDeviceConnectionRequestModel);
      connListener();
    } else {
      _device = device;
      notifyListeners();
      //Herhangi bir connection varsa connection silme işlemi yapıyoruz.
      if (_connection != null) {
        await _connection!.cancel();
      }

      //Gerekli cihazı gönderip bağlantı kuruluyor.
      _connection = _ble.connectToDevice(id: device.id).listen(
            _deviceConnectionController.add,
          );
    }
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

  @override
  Future<void> dispose() async {
    await _deviceConnectionController.close();
    super.dispose();
  }
}
