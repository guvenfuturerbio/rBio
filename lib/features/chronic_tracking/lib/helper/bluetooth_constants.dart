// ignore_for_file: non_constant_identifier_names

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BluetoothConstants {
  BluetoothConstants._instance();
  factory BluetoothConstants.instance() {
    return BluetoothConstants._instance();
  }

  // https://www.bluetooth.com/specifications/gatt/services
  Uuid SERVICE_BODY_COMPOSITION = Uuid.parse('0x181b');
  Uuid SERVICE_DEVICE_INFORMATION = Uuid.parse('0x180a');
  Uuid SERVICE_GENERIC_ACCESS = Uuid.parse('0x1800');
  Uuid SERVICE_GENERIC_ATTRIBUTE = Uuid.parse('0x1801');
  Uuid SERVICE_WEIGHT_SCALE = Uuid.parse('0x181d');
  Uuid SERVICE_CURRENT_TIME = Uuid.parse('0x1805');
  Uuid SERVICE_USER_DATA = Uuid.parse('0x181C');
  Uuid SERVICE_BATTERY_LEVEL = Uuid.parse('0x180F');

  // https://www.bluetooth.com/specifications/gatt/characteristics
  Uuid CHARACTERISTIC_APPEARANCE = Uuid.parse('0x2a01');
  Uuid CHARACTERISTIC_BODY_COMPOSITION_MEASUREMENT = Uuid.parse('0x2a9c');
  Uuid CHARACTERISTIC_CURRENT_TIME = Uuid.parse('0x2a2b');
  Uuid CHARACTERISTIC_DEVICE_NAME = Uuid.parse('0x2a00');
  Uuid CHARACTERISTIC_FIRMWARE_REVISION_STRING = Uuid.parse('0x2a26');
  Uuid CHARACTERISTIC_HARDWARE_REVISION_STRING = Uuid.parse('0x2a27');
  Uuid CHARACTERISTIC_IEEE_11073_20601_REGULATORY_CERTIFICATION_DATA_LIST =
      Uuid.parse('0x2a2a');
  Uuid CHARACTERISTIC_MANUFACTURER_NAME_STRING = Uuid.parse('0x2a29');
  Uuid CHARACTERISTIC_MODEL_NUMBER_STRING = Uuid.parse('0x2a24');
  Uuid CHARACTERISTIC_PERIPHERAL_PREFERRED_CONNECTION_PARAMETERS =
      Uuid.parse('0x2a04');
  Uuid CHARACTERISTIC_PERIPHERAL_PRIVACY_FLAG = Uuid.parse('0x2a02');
  Uuid CHARACTERISTIC_PNP_ID = Uuid.parse('0x2a50');
  Uuid CHARACTERISTIC_RECONNECTION_ADDRESS = Uuid.parse('0x2a03');
  Uuid CHARACTERISTIC_SERIAL_NUMBER_STRING = Uuid.parse('0x2a25');
  Uuid CHARACTERISTIC_SERVICE_CHANGED = Uuid.parse('0x2a05');
  Uuid CHARACTERISTIC_SOFTWARE_REVISION_STRING = Uuid.parse('0x2a28');
  Uuid CHARACTERISTIC_SYSTEM_ID = Uuid.parse('0x2a23');
  Uuid CHARACTERISTIC_WEIGHT_MEASUREMENT = Uuid.parse('0x2a9d');
  Uuid CHARACTERISTIC_BATTERY_LEVEL = Uuid.parse('0x2A19');
  Uuid CHARACTERISTIC_CHANGE_INCREMENT = Uuid.parse('0x2a99');
  Uuid CHARACTERISTIC_USER_CONTROL_POINT = Uuid.parse('0x2A9F');
  Uuid CHARACTERISTIC_USER_AGE = Uuid.parse('0x2A80');
  Uuid CHARACTERISTIC_USER_GENDER = Uuid.parse('0x2A8C');
  Uuid CHARACTERISTIC_USER_HEIGHT = Uuid.parse('0x2A8E');

  // https://www.bluetooth.com/specifications/gatt/descriptors
  Uuid DESCRIPTOR_CLIENT_CHARACTERISTIC_CONFIGURATION = Uuid.parse('0x2902');
  Uuid DESCRIPTOR_CHARACTERISTIC_USER_DESCRIPTION = Uuid.parse('0x2901');
}
