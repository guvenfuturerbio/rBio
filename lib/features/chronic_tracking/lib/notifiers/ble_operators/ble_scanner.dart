import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:onedosehealth/model/ble_models/paired_device.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:system_shortcuts/system_shortcuts.dart';

import '../../../../../core/core.dart';
import '../shared_pref_notifiers.dart';
import 'ble_connector.dart';

class BleScannerOps extends ChangeNotifier {
  final _devices = <DiscoveredDevice>[];

  FlutterReactiveBle _ble;

  String deviceId;
  List<String> pairedDevices;

  StreamSubscription _subscription;

  BleScannerOps({FlutterReactiveBle ble}) {
    this._ble = ble;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      List<PairedDevice> pairedDevice =
          await getIt<SharedPrefNotifiers>().getPairedDevices();
      pairedDevices = pairedDevice?.map((e) => e.deviceId)?.toList() ?? [];
      startScan();
    });
  }

  List<Uuid> _supported = [
    Uuid.parse("1808"),
    Uuid([0x18, 0x1B])
  ];

  List<DiscoveredDevice> get discoveredDevices => this._devices;

  setDeviceId(String deviceId) {
    this.deviceId = deviceId;
  }

  addDeviceId(List<String> deviceIds) {
    pairedDevices = deviceIds;
  }

  startScan() {
    _ble.statusStream.listen((bleStatus) async {
      if (bleStatus == BleStatus.ready) {
        _devices?.clear();
        _subscription?.cancel();
        _subscription = _ble
            .scanForDevices(withServices: _supported)
            .listen((device) async {
          final knownDeviceIndex =
              _devices.indexWhere((d) => d.id == device.id);
          if (knownDeviceIndex >= 0) {
            _devices[knownDeviceIndex] = device;
          } else {
            _devices.add(device);

            /// AutoConnector Methode caller
            if (pairedDevices != null && pairedDevices.contains(device.id)) {
              getIt<BleConnectorOps>().connect(device);
            }
            /*  if (device.id == deviceId) {
              locator<BleConnectorOps>().connect(device);
            } */
            notifyListeners();
          }
        });
      } else if (bleStatus == BleStatus.unauthorized) {
        await Future.delayed(Duration(seconds: 1));
        await Permission.location.request();
      } else if (bleStatus == BleStatus.poweredOff) {
        await Future.delayed(Duration(seconds: 1));

        await SystemShortcuts.bluetooth();
      }
    });
  }

  stopScan() async {
    await _subscription?.cancel();
    _subscription = null;
    notifyListeners();
  }

  refreshDeviceList() {
    _devices?.clear();
    notifyListeners();
  }
}
