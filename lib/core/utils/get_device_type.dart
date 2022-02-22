import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:onedosehealth/model/ble_models/device_type.dart';

DeviceType getDeviceType(DiscoveredDevice device) {
  if (device.name == 'MIBFS' &&
      device.serviceData.length == 1 &&
      device.serviceData.values.first.length == 13) {
    return DeviceType.miScale;
  } else if (device.manufacturerData[0] == 112) {
    return DeviceType.accuChek;
  } else if (device.manufacturerData[0] == 103) {
    return DeviceType.contourPlusOne;
  }

  throw Exception('Nondefined device');
}
