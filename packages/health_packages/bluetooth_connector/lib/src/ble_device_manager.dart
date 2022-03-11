import 'dart:convert';

import 'package:shared_preferences_manager/shared_preferences_manager.dart';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleDeviceManager {
  final ISharedPreferencesManager sharedPrefs;

  BleDeviceManager(this.sharedPrefs);

  /// First of all fetching all saved paired device on localStorage.
  /// Then checking sending value it's exist.
  /// If sending value is not exist new value saving the localStorage
  /// or else do nothing.
  Future<List<PairedDevice>> savePairedDevices(
      PairedDevice pairedDevice) async {
    if (!await hasDeviceAlreadyPaired(pairedDevice)) {
      final _pairedDevices = await getPairedDevices();
      _pairedDevices.add(pairedDevice);
      final List<String> _pairedDeviceOnLocal =
          _pairedDevices.map((device) => jsonEncode(device.toJson())).toList();
      await sharedPrefs.setStringList(
        SharedPreferencesKeys.pairedDevices,
        _pairedDeviceOnLocal,
      );
      return _pairedDevices;
    } else {
      return [];
    }
  }

  Future<bool> hasDeviceAlreadyPaired(PairedDevice device) async {
    final _pairedDevices = await getPairedDevices();
    final pairedDeviceIndex = _pairedDevices
        .indexWhere((element) => element.deviceId == device.deviceId);
    return pairedDeviceIndex != -1;
  }

  Future<List<PairedDevice>> deletePairedDevice(String id) async {
    final response = await getPairedDevices();
    final selectedDeviceIndex = response.indexWhere((element) => element.deviceId == id);
    if (selectedDeviceIndex != -1) {
      response.removeAt(selectedDeviceIndex);
      final List<String> _pairedDeviceOnLocal = response.map((device) => jsonEncode(device.toJson())).toList();
      await sharedPrefs.setStringList(
        SharedPreferencesKeys.pairedDevices,
        _pairedDeviceOnLocal,
      );
      return response;
    } else {
      return [];
    }
  }

  /// multiple Paired device can be associated. So This method getting all [PairedDevice] as a [List<PairedDevice>]
  Future<List<PairedDevice>> getPairedDevices() async {
    final List<String>? paired =
        sharedPrefs.getStringList(SharedPreferencesKeys.pairedDevices);
    List<PairedDevice> pairedDevices = [];
    if (paired != null) {
      pairedDevices = paired
          .map(
            (e) => PairedDevice.fromJson(jsonDecode(e) as Map<String, dynamic>),
          )
          .toList();
    } else {
      return [];
    }
    return pairedDevices;
  }
}
