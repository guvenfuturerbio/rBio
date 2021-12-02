import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../../model/ble_models/paired_device.dart';

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
}
