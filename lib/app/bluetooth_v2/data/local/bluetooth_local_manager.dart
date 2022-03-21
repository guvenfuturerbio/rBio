import 'dart:convert';

import '../../../../core/core.dart';
import '../../bluetooth_v2.dart';

class BluetoothLocalManager {
  final ISharedPreferencesManager sharedPreferencesManager;

  BluetoothLocalManager(this.sharedPreferencesManager);

  final _sharedKey = SharedPreferencesKeys.pairedDevicesV2;

  Future<bool> savePairedDevices(DeviceEntity device) async {
    if (!hasDeviceAlreadyPaired(device)) {
      final _pairedDevices = getPairedDevices();
      _pairedDevices.add(device);
      final _pairedDeviceOnLocal = _pairedDevices.map((device) => jsonEncode(device.toJson())).toList();
      final response = await sharedPreferencesManager.setStringList(
        _sharedKey,
        _pairedDeviceOnLocal,
      );
      return response;
    } else {
      return false;
    }
  }

  Future<void> deletePairedDevice(String id) async {
    final response = getPairedDevices();
    final selectedDeviceIndex = response.indexWhere((element) => element.id == id);
    if (selectedDeviceIndex != -1) {
      response.removeAt(selectedDeviceIndex);
      final _pairedDeviceOnLocal = response.map((device) => jsonEncode(device.toJson())).toList();
      await sharedPreferencesManager.setStringList(
        _sharedKey,
        _pairedDeviceOnLocal,
      );
    }
  }

  List<DeviceEntity> getPairedDevices() {
    final paired = sharedPreferencesManager.getStringList(_sharedKey);
    List<DeviceEntity> pairedDevices = [];
    if (paired != null) {
      pairedDevices = paired.map((e) => DeviceEntity.fromJson(jsonDecode(e))).toList();
    } else {
      return [];
    }

    return pairedDevices;
  }

  bool hasDeviceAlreadyPaired(DeviceEntity device) {
    final _pairedDevices = getPairedDevices();
    final pairedDeviceIndex = _pairedDevices.indexWhere((element) => element.id == device.id);
    return pairedDeviceIndex != -1;
  }
}
