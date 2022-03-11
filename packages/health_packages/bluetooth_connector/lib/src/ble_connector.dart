import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:logger/logger.dart';

class BleConnector {
  final FlutterReactiveBle _ble;

  BleConnector(this._ble);

  final List<ConnectionStateUpdate> _deviceConnectionStateUpdate = [];
  List<ConnectionStateUpdate> get deviceConnectionState =>
      _deviceConnectionStateUpdate;

  DiscoveredDevice? _device;
  DiscoveredDevice? get device => _device;

  final _deviceConnectionController = StreamController<ConnectionStateUpdate>();
  Stream<ConnectionStateUpdate> get state => _deviceConnectionController.stream;

  StreamSubscription<ConnectionStateUpdate>? _connection;

  Stream<ConnectionStateUpdate> listenConnectedDeviceStream(
    void Function(List<ConnectionStateUpdate>) eventCall,
  ) {
    final stream = _ble.connectedDeviceStream.asBroadcastStream();

    // Telefonla cihaz arasındaki bağlantı durumu dinleyen stream
    stream.listen(
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

          eventCall(_deviceConnectionStateUpdate);
        }
      },
    );

    return stream;
  }

  Future<void> connect(
    DiscoveredDevice device,
    void Function(DiscoveredDevice) emitState,
  ) async {
    _device = device;
    emitState(_device!);

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
      _device = null;
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

  DeviceType getDeviceType() {
    if (_device != null) {
      if (_device!.name == 'MIBFS' &&
          _device!.serviceData.length == 1 &&
          _device!.serviceData.values.first.length == 13) {
        return DeviceType.miScale;
      } else if (_device!.manufacturerData[0] == 112) {
        return DeviceType.accuChek;
      } else if (_device!.manufacturerData[0] == 103) {
        return DeviceType.contourPlusOne;
      }
    }

    throw Exception('Nondefined device');
  }
}
