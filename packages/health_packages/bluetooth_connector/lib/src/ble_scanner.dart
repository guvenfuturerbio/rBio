import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

class BleScanner {
  final FlutterReactiveBle _ble;

  BleScanner(this._ble);

  final _devices = <DiscoveredDevice>[];
  StreamSubscription? _subscription;

  final StreamController<BleScannerState> _stateStreamController =
      StreamController();

  Stream<BleScannerState> get state => _stateStreamController.stream;

  final List<Uuid> _supported = [
    //Blood glucosea ait verileri kontrol eden kod. (Diğer cihazlar için farklı kodlar var).
    Uuid.parse("1808"),
    //Kan şekeri ve tartılar karşımıza çıksın diye alttaki kodları kullanıyoruz. Bu kodlara sahip servislerin hepsini tarıyor ve gösteriyor.
    Uuid([0x18, 0x1B])
  ];

  List<DiscoveredDevice> get discoveredDevices => _devices;

  void startScan() {
    print('Start ble discovery');
    _devices.clear();
    _subscription?.cancel();
    _subscription = _ble.scanForDevices(withServices: _supported).listen(
      (device) {
        final knownDeviceIndex = _devices.indexWhere((d) => d.id == device.id);
        // Daha önce listede varsa güncelliyor.
        if (knownDeviceIndex >= 0) {
          _devices[knownDeviceIndex] = device;
        } else {
          _devices.add(device);
        }

        // TODO AutoConnect - Bağlı cihazlar listesi getirilecek
        // final isContain = _devices.any((item) => item.id == device.id);
        // if (isContain) {
        //   getIt<BleConnectorOps>().connect(device);
        // }

        _pushState();
      },
      onError: (Object e) => print('Device scan fails with error: $e'),
    );
    _pushState();
  }

  Future<void> stopScan() async {
    await _subscription?.cancel();
    _subscription = null;
    _pushState();
  }

  /// Cihazlarım sayfasını açınca çalıştır
  BleStatus? bleStatus;
  void startBluetoothScan() {
    _ble.statusStream.listen((value) async {
      bleStatus = value;
    });
  }

  /// Herhangi bir cihaza dokununca göster
  Future<bool> checkPermission() async {
    if (bleStatus == BleStatus.ready) {
      return true;
    } else if (bleStatus == BleStatus.unauthorized) {
      final permStatus = await Permission.location.request();
      return permStatus == PermissionStatus.granted;
    } else if (bleStatus == BleStatus.poweredOff) {
      // Show Bluetooth Dialog
      return false;
    } else if (bleStatus == BleStatus.locationServicesDisabled) {
      final permStatus = await Permission.location.request();
      return permStatus == PermissionStatus.granted;
    } else {
      return false;
    }
  }

  void _pushState() {
    _stateStreamController.add(
      BleScannerState(
        discoveredDevices: _devices,
        scanIsInProgress: _subscription != null,
      ),
    );
  }

  Future<void> dispose() async {
    await _stateStreamController.close();
  }

  void refreshDeviceList() {
    _devices.clear();
  }
}

@immutable
class BleScannerState {
  const BleScannerState({
    required this.discoveredDevices,
    required this.scanIsInProgress,
  });

  final List<DiscoveredDevice> discoveredDevices;
  final bool scanIsInProgress;
}
