import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:onedosehealth/model/ble_models/DeviceTypes.dart';

DeviceType getDeviceType(DiscoveredDevice device) {
  if (device.name == 'MIBFS' &&
      device.serviceData.length == 1 &&
      device.serviceData.values.first.length == 13) {
    return DeviceType.MI_SCALE;
  } else if (device.manufacturerData[0] == 112) {
    return DeviceType.ACCU_CHEK;
  } else if (device.manufacturerData[0] == 103) {
    return DeviceType.CONTOUR_PLUS_ONE;
  }

  throw Exception('Nondefined device');
}
