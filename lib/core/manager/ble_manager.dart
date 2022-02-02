import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/model/ble_models/paired_device.dart';

class BleDeviceManager extends ChangeNotifier {
  final sharedPrefs = getIt<ISharedPreferencesManager>();

  /// First of all fetching all saved paired device on localStorage.
  /// Then checking sending value it's exist.
  /// If sending value is not exist new value saving the localStorage
  /// or else do nothing.
  Future<bool> savePairedDevices(PairedDevice pairedDevice) async {
    if (!await hasDeviceAlreadyPaired(pairedDevice)) {
      final _pairedDevices = await getPairedDevices();
      _pairedDevices.add(pairedDevice);
      final List<String> _pairedDeviceOnLocal =
          _pairedDevices.map((device) => jsonEncode(device.toJson())).toList();
      final response = await sharedPrefs.setStringList(
        SharedPreferencesKeys.PAIRED_DEVICES,
        _pairedDeviceOnLocal,
      );
      getIt<BleScannerOps>().addDeviceId(
          _pairedDevices.map((e) => e.deviceId).toList() as List<String>);
      notifyListeners();
      return response;
    } else {
      return false;
    }
  }

  Future<bool> hasDeviceAlreadyPaired(PairedDevice device) async {
    final _pairedDevices = await getPairedDevices();
    final pairedDeviceIndex = _pairedDevices
        .indexWhere((element) => element.deviceId == device.deviceId);
    return pairedDeviceIndex != -1;
  }

  Future<void> deletePairedDevice(String id) async {
    final response = await getPairedDevices();
    final selectedDeviceIndex =
        response.indexWhere((element) => element.deviceId == id);
    print(selectedDeviceIndex);
    if (selectedDeviceIndex != -1) {
      response.removeAt(selectedDeviceIndex);
      getIt<BleScannerOps>().pairedDevices =
          response.map((e) => e.deviceId).toList() as List<String>;
      getIt<BleConnectorOps>().removePairedDevice();
      final List<String> _pairedDeviceOnLocal =
          response.map((device) => jsonEncode(device.toJson())).toList();
      await sharedPrefs.setStringList(
        SharedPreferencesKeys.PAIRED_DEVICES,
        _pairedDeviceOnLocal,
      );
    }
    notifyListeners();
  }

  /// multiple Paired device can be associated. So This method getting all [PairedDevice] as a [List<PairedDevice>]
  Future<List<PairedDevice>> getPairedDevices() async {
    if (sharedPrefs.getStringList(SharedPreferencesKeys.PAIRED_DEVICES) !=
        null) {
      final List<String> paired =
          sharedPrefs.getStringList(SharedPreferencesKeys.PAIRED_DEVICES);
      List<PairedDevice> pairedDevices = paired
          .map((e) =>
              PairedDevice.fromJson(jsonDecode(e) as Map<String, dynamic>))
          .toList();
      return pairedDevices;
    } else {
      return [];
    }
  }
}
