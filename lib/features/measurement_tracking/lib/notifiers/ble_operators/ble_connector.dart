import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:onedosehealth/locator.dart';
import 'package:onedosehealth/models/ble_models/DeviceTypes.dart';
import 'package:onedosehealth/notifiers/ble_operators/ble_reactor.dart';
import 'package:onedosehealth/notifiers/ble_operators/ble_scanner.dart';
import 'package:onedosehealth/widgets/utils.dart';
import 'package:provider/provider.dart';

class BleConnectorOps extends ChangeNotifier {
  FlutterReactiveBle _ble;

  bool isFirstConnect = true;

  List<ConnectionStateUpdate> _deviceConnectionStateUpdate = [];

  DiscoveredDevice _device;

  StreamSubscription<ConnectionStateUpdate> _connection;

  // ignore: close_sinks
  final _deviceConnectionController = StreamController<ConnectionStateUpdate>();

  BleConnectorOps({FlutterReactiveBle ble}) {
    this._ble = ble;
    listenConnectedDeviceStream();
  }

  List<ConnectionStateUpdate> get deviceConnectionState =>
      this._deviceConnectionStateUpdate;

  DiscoveredDevice get device => this._device;

  void listenConnectedDeviceStream() {
    _ble.connectedDeviceStream.listen((event) {
      print(event.connectionState.toString());
      if (event?.deviceId == device?.id) {
        var deviceIndex = _deviceConnectionStateUpdate
            .indexWhere((element) => element.deviceId == event.deviceId);
        if (deviceIndex != -1) {
          _deviceConnectionStateUpdate[deviceIndex] = event;
        } else {
          _deviceConnectionStateUpdate.add(event);
        }
        notifyListeners();
        if (event.connectionState == DeviceConnectionState.connected) {
          switch (getDeviceType(device)) {
            case DeviceType.ACCU_CHEK:
              locator<BleReactorOps>().write(device);
              break;
            case DeviceType.CONTOUR_PLUS_ONE:
              locator<BleReactorOps>().write(device);
              break;
            case DeviceType.MI_SCALE:
              locator<BleReactorOps>().subscribeScaleDevice(device);
              break;
            default:
              break;
          }
        } else if (event.connectionState ==
            DeviceConnectionState.disconnected) {
          locator<BleScannerOps>().refreshDeviceList();
        }
      }
    });
  }

  Future<void> connect(DiscoveredDevice device) async {
    print("connect");
    this._device = device;
    notifyListeners();
    if (_connection != null) {
      await _connection.cancel();
    }

    _connection = _ble.connectToDevice(id: device.id).listen(
        _deviceConnectionController.add,
        onError: (error) => print('Error: $error'));
  }

  Future<void> disconnect(String deviceId) async {
    if (_connection != null) {
      try {
        await _connection.cancel();
      } on Exception catch (e, _) {
        print("error disconnecting from a device : $e");
      } finally {
        _deviceConnectionController.add(ConnectionStateUpdate(
            deviceId: deviceId,
            connectionState: DeviceConnectionState.disconnected,
            failure: null));
      }
    }
  }

  removePairedDevice() async {
    if (_connection != null) {
      await _connection.cancel();
    }
  }

  ConnectionStateUpdate getStatus(String id) {
    var deviceIndex = _deviceConnectionStateUpdate
        .indexWhere((element) => element.deviceId == id);
    if (deviceIndex != -1) {
      return _deviceConnectionStateUpdate[deviceIndex];
    } else {
      return null;
    }
  }

  // ignore: must_call_super
  Future<void> dispose() async {
    await _deviceConnectionController.close();
  }
}
