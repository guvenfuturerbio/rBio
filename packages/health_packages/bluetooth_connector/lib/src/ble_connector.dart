import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:logger/logger.dart';

class BleConnector {
  final FlutterReactiveBle _ble;

  BleConnector(this._ble);

  final List<ConnectionStateUpdate> _deviceConnectionStateUpdate = [];
  DiscoveredDevice? _device;

  List<ConnectionStateUpdate> get deviceConnectionState =>
      _deviceConnectionStateUpdate;

  Stream<ConnectionStateUpdate> get state => _deviceConnectionController.stream;

  final _deviceConnectionController = StreamController<ConnectionStateUpdate>();

  StreamSubscription<ConnectionStateUpdate>? _connection;

  void listenConnectedDeviceStream() {
    // Telefonla cihaz arasındaki bağlantı durumu dinleyen stream
    _ble.connectedDeviceStream.listen(
      (event) {
        if (event.deviceId == _device?.id) {
          final deviceIndex = _deviceConnectionStateUpdate.indexWhere(
            (element) => element.deviceId == event.deviceId,
          );

          // index aşağıda -1 değilse daha önce bir bağlantı var demektir. Kontrol bunun için yapılıyor.
          if (deviceIndex != -1) {
            _deviceConnectionStateUpdate[deviceIndex] = event;
          } else {
            _deviceConnectionStateUpdate.add(event);
          }
          //notifyListeners();

          // TODO
          //Reactor dosyasına gönderilen kısım. Cihazı tanıdıktan sonra cihazın verilerini yazıyoruz.
          if (event.connectionState == DeviceConnectionState.connected) {
            switch (getDeviceType(_device!)) {
              case DeviceType.accuChek:
                //getIt<BleReactorOps>().write(device!);
                break;
              case DeviceType.contourPlusOne:
                //getIt<BleReactorOps>().write(device!);
                break;
              case DeviceType.miScale:
                //getIt<BleReactorOps>().subscribeScaleDevice(device!);
                break;
              default:
                break;
            }
          } else if (event.connectionState ==
              DeviceConnectionState.disconnected) {
            // TODO
            // bleScanner.refreshDeviceList();
          }
        }
      },
    );
  }

  Future<void> connect(DiscoveredDevice device) async {
    _device = device;
    //notifyListeners();

    //Herhangi bir connection varsa connection silme işlemi yapıyoruz.
    await _connection?.cancel();

    //Gerekli cihazı gönderip bağlantı kuruyor.
    _connection = _ble.connectToDevice(id: device.id).listen(
          _deviceConnectionController.add,
          onError: (Object e) => Logger()
              .e('Connecting to device ${_device?.id} resulted in error $e'),
        );
  }

  Future<void> disconnect(String deviceId) async {
    try {
      Logger().i('disconnecting to device: $deviceId');
      await _connection?.cancel();
    } on Exception catch (e, _) {
      Logger().e("Error disconnecting from a device: $e");
    } finally {
      // Since [_connection] subscription is terminated, the "disconnected" state cannot be received and propagated
      _deviceConnectionController.add(
        ConnectionStateUpdate(
          deviceId: deviceId,
          connectionState: DeviceConnectionState.disconnected,
          failure: null,
        ),
      );
    }
  }

  Future<void> removePairedDevice() async {
    if (_connection != null) {
      await _connection!.cancel();
    }
  }

  Future<void> dispose() => _deviceConnectionController.close();

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
}
