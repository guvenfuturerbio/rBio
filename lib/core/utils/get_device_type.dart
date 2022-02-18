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
  } else if (device.id.substring(0, 8) == '28:FF:B2' &&
      device.name.substring(0, 17) == 'BLEsmart_00000264') {
    return DeviceType.omronBloodPressureArm;
  } else if (device.id.substring(0, 8) == '28:FF:B2' &&
      device.name.substring(0, 17) == 'BLEsmart_00000244') {
    return DeviceType.omronBloodPressureWrist;
  }

  throw Exception('Nondefined device');
}
