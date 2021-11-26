import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../../model/ble_models/paired_device.dart';
import 'ble_operators/ble_connector.dart';
import 'ble_operators/ble_scanner.dart';

class SharedPrefNotifiers extends ChangeNotifier {
  static final SharedPrefNotifiers _sharedPrefNotifiers =
      SharedPrefNotifiers._internal();

  factory SharedPrefNotifiers() {
    return _sharedPrefNotifiers;
  }

  SharedPrefNotifiers._internal();

  static const LAST_PAIRED_DEVICE = "LAST_PAIRED_DEVICE";
  static const PAIRED_DEVICES = 'PAIRED_DEVICES';
  static const PREFERED_LANG = 'PREFERED_LANG';

  savePairedDevice(PairedDevice pairedDevice) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String paired = jsonEncode(pairedDevice);
    var response =
        await sharedPreferences.setString(LAST_PAIRED_DEVICE, paired);
    getIt<BleScannerOps>().setDeviceId(pairedDevice.deviceId);
    print("savePaired device response " + response.toString());
    notifyListeners();
    return response;
  }

  Future<PairedDevice> getPairedDevice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(LAST_PAIRED_DEVICE) != null) {
      Map paired = jsonDecode(sharedPreferences?.getString(LAST_PAIRED_DEVICE));
      PairedDevice pairedDevice = PairedDevice.fromJson(paired);
      return pairedDevice;
    } else {
      return null;
    }
  }

  /// Localization prefered language setter methode
  setPreferedLang(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PREFERED_LANG, value);
  }

  Future getPreferedLang() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      return sharedPreferences.getString(PREFERED_LANG);
    } catch (_) {
      return null;
    }
  }

  /// multiple Paired device can be associated. So This method getting all [PairedDevice] as a [List<PairedDevice>]
  Future<List<PairedDevice>> getPairedDevices() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList(PAIRED_DEVICES) != null) {
      List<String> paired = sharedPreferences?.getStringList(PAIRED_DEVICES);
      List<PairedDevice> pairedDevices =
          paired.map((e) => PairedDevice.fromJson(jsonDecode(e))).toList();
      return pairedDevices;
    } else {
      return null;
    }
  }

  /// First of all fetching all saved paired device on localStorage.
  /// Then checking sending value it's exist.
  /// If sending value is not exist new value saving the localStorage
  /// or else do nothing.
  savePairedDevices(PairedDevice pairedDevice) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (!await hasDeviceAlreadyPaired(pairedDevice)) {
      var _pairedDevices = await getPairedDevices() ?? [];
      _pairedDevices.add(pairedDevice);
      List<String> _pairedDeviceOnLocal =
          _pairedDevices.map((device) => jsonEncode(device.toJson())).toList();

      var response = await sharedPreferences.setStringList(
          PAIRED_DEVICES, _pairedDeviceOnLocal);

      getIt<BleScannerOps>()
          .addDeviceId(_pairedDevices.map((e) => e.deviceId).toList());
      print("savePaired device response " + response.toString());
      notifyListeners();
      return response;
    }
  }

  deletePairedDevice(String id) async {
    var response = await getPairedDevices() ?? [];
    var selectedDeviceIndex =
        response.indexWhere((element) => element.deviceId == id);
    print(selectedDeviceIndex);
    if (selectedDeviceIndex != -1) {
      response.removeAt(selectedDeviceIndex);
      getIt<BleScannerOps>().pairedDevices =
          response.map((e) => e.deviceId).toList();
      getIt<BleConnectorOps>().removePairedDevice();

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      List<String> _pairedDeviceOnLocal =
          response.map((device) => jsonEncode(device.toJson())).toList();

      await sharedPreferences.setStringList(
          PAIRED_DEVICES, _pairedDeviceOnLocal);
    }

    notifyListeners();
  }

  Future<bool> hasDeviceAlreadyPaired(PairedDevice device) async {
    var _pairedDevices = await getPairedDevices() ?? [];
    var pairedDeviceIndex = _pairedDevices
        .indexWhere((element) => element.deviceId == device.deviceId);
    return pairedDeviceIndex != -1;
  }
}
