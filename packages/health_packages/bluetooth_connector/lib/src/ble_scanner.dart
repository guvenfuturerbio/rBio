import 'dart:async';
import 'dart:developer';

import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'ble_manager.dart';

class BleScannerOps {
  final _devices = <DiscoveredDevice>[];

  final FlutterReactiveBle _ble;

  final BleConnectorOps bleConnector;

  String? _deviceId;

  StreamSubscription? _subscription;

  BleScannerOps(this._ble, this.bleConnector);

  final List<Uuid> _supported = [
    //Blood glucosea ait verileri kontrol eden kod. (Diğer cihazlar için farklı kodlar var).
    Uuid.parse("1808"),
    //Kan şekeri ve tartılar karşımıza çıksın diye alttaki kodları kullanıyoruz. Bu kodlara sahip servislerin hepsini tarıyor ve gösteriyor.
    Uuid([0x18, 0x1B])
  ];

  List<DiscoveredDevice> get discoveredDevices => _devices;

  set deviceId(String rhsDeviceId) => _deviceId = rhsDeviceId;
  String get deviceId => _deviceId ?? '';

  Future<void> startScan(List<String>? pairedDevices) async {
    //Cihazın bluetooth'u açık mı kontrolü yapılıyor.
    _ble.statusStream.listen((bleStatus) async {
      Logger().w(bleStatus);

      if (bleStatus == BleStatus.ready) {
        _devices.clear();
        _subscription?.cancel();
        //Alttaki satır arama yapıyor ve stream olduğu için sürekli olarak dinliyor.
        _ble.scanForDevices(withServices: _supported).listen((device) async {
          final knownDeviceIndex =
              _devices.indexWhere((d) => d.id == device.id);
          if (knownDeviceIndex >= 0) {
            _devices[knownDeviceIndex] = device;
          } else {
            _devices.add(device);

            /// AutoConnector method caller
            if (pairedDevices != null && pairedDevices.contains(device.id)) {
              bleConnector.connect(device);
            }
            /*  if (device.id == deviceId) {
              locator<BleConnectorOps>().connect(device);
            } */

            //notifyListeners();
          }
        }, onError: (e) {
          log(e.toString());
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
        Logger().i("locationServicesDisabled");
      }
    });
  }

  Future<void> stopScan() async {
    await _subscription?.cancel();
    _subscription = null;
    //notifyListeners();
  }

  void refreshDeviceList() {
    _devices.clear();
    //notifyListeners();
  }
}
