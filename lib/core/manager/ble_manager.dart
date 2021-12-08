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
  Future<void> savePairedDevices(PairedDevice pairedDevice) async {
    if (!await hasDeviceAlreadyPaired(pairedDevice)) {
      var _pairedDevices = await getPairedDevices() ?? [];
      _pairedDevices.add(pairedDevice);
      List<String> _pairedDeviceOnLocal =
          _pairedDevices.map((device) => jsonEncode(device.toJson())).toList();
      var response = await sharedPrefs.setStringList(
          SharedPreferencesKeys.PAIRED_DEVICES, _pairedDeviceOnLocal);
      getIt<BleScannerOps>()
          .addDeviceId(_pairedDevices.map((e) => e.deviceId).toList());
      notifyListeners();
      return response;
    }
  }

  Future<bool> hasDeviceAlreadyPaired(PairedDevice device) async {
    var _pairedDevices = await getPairedDevices() ?? [];
    var pairedDeviceIndex = _pairedDevices
        .indexWhere((element) => element.deviceId == device.deviceId);
    return pairedDeviceIndex != -1;
  }

  Future<void> deletePairedDevice(String id) async {
    var response = await getPairedDevices() ?? [];
    var selectedDeviceIndex =
        response.indexWhere((element) => element.deviceId == id);
    print(selectedDeviceIndex);
    if (selectedDeviceIndex != -1) {
      response.removeAt(selectedDeviceIndex);
      getIt<BleScannerOps>().pairedDevices =
          response.map((e) => e.deviceId).toList();
      getIt<BleConnectorOps>().removePairedDevice();
      List<String> _pairedDeviceOnLocal =
          response.map((device) => jsonEncode(device.toJson())).toList();
      await sharedPrefs.setStringList(
          SharedPreferencesKeys.PAIRED_DEVICES, _pairedDeviceOnLocal);
    }
    notifyListeners();
  }

  /// multiple Paired device can be associated. So This method getting all [PairedDevice] as a [List<PairedDevice>]
  Future<List<PairedDevice>> getPairedDevices() async {
    if (sharedPrefs.getStringList(SharedPreferencesKeys.PAIRED_DEVICES) !=
        null) {
      List<String> paired =
          sharedPrefs?.getStringList(SharedPreferencesKeys.PAIRED_DEVICES);
      List<PairedDevice> pairedDevices =
          paired.map((e) => PairedDevice.fromJson(jsonDecode(e))).toList();
      return pairedDevices;
    } else {
      return [];
    }
  }
}
