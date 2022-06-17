class BluetoothConstants {
  BluetoothConstants._();

  static const miScaleNotifyDuration = Duration(seconds: 25);

  // ! MiScale
  // ? Device Information - 0000180a-0000-1000-8000-00805f9b34fb
  // * Hardware Revision String (2A27) (Read)
  // * Serial Number String (2A25) (Read)
  // * System Id (2A23) (Read)
  // * Software Revision String (2A28) (Read)
  // * PNP Id (2A50) (Read)
  // ? Body Composition - 0000181b-0000-1000-8000-00805f9b34fb
  // * Body Composition Feature (2A9B) (Read)
  // * Current Time (2A2B) (Write,Read)
  // * Body Composition Measurement (2A9C) (Indicate) (0x0)

  static const miScale = BluetoothUUIDModel(
    serviceUuid: "0000181b-0000-1000-8000-00805f9b34fb",
    characteristicUuid: "00002a9c-0000-1000-8000-00805f9b34fb",
  );

  static const pillarSmall = BluetoothUUIDModel(
    serviceUuid: "19b10000-e8f2-537e-4f6c-d104768a1214",
    characteristicUuid: "19b10001-e8f2-537e-4f6c-d104768a1214",
  );

  // ! Accu-Chek
  // ? Glucose - 00001808-0000-1000-8000-00805f9b34fb
  // * Glucose Feature (2A51) (Read) -> [32, 2] -> 0x2002
  // * Date Time (2A08) (Read)
  // * Record Access Control Point (2A52) (Write,Indicate)
  // * Glucose Measurement (2A18) (Notify)
  // ? Device Information - 0000180a-0000-1000-8000-00805f9b34fb
  // * Model Number String (2A24) (Read)
  // * PNP ID (2A50) (Read)
  // * Regulatory Certification Data List (2A2A) (Read)
  // * Serial Number String (2A25) (Read)
  // * Manufacturer Name String (2A29) (Read)
  // * Firmware Revision String (2A26) (Read)
  // * System Id (2A23) (Read)

  static const accuChekGlucoseService = "00001808-0000-1000-8000-00805f9b34fb";
  static const accuChekRecordAccessControlPoint = "00002a52-0000-1000-8000-00805f9b34fb";
  static const accuChekGlucoseMeasurement = "00002a18-0000-1000-8000-00805f9b34fb";
  static const accuChekGlucoseFeature = "00002a51-0000-1000-8000-00805f9b34fb";
  static const accuChekDateTime = "00002a08-0000-1000-8000-00805f9b34fb";

  static const accuChekDeviceInformationService = "0000180a-0000-1000-8000-00805f9b34fb";
  static const accuChekModelNumberString = "00002a24-0000-1000-8000-00805f9b34fb";
  static const accuChekPNPId = "00002a50-0000-1000-8000-00805f9b34fb";
  static const accuChekRegulatoryCertificationDataList = "00002a2a-0000-1000-8000-00805f9b34fb";
  static const accuChekSerialNumberString = "00002a25-0000-1000-8000-00805f9b34fb";
  static const accuChekManufacturerNameString = "00002a29-0000-1000-8000-00805f9b34fb";
  static const accuChekFirmwareRevisionString = "00002a26-0000-1000-8000-00805f9b34fb";
  static const accuChekSystemId = "00002a23-0000-1000-8000-00805f9b34fb";
}

class BluetoothUUIDModel {
  final String serviceUuid;
  final String characteristicUuid;

  const BluetoothUUIDModel({
    required this.serviceUuid,
    required this.characteristicUuid,
  });
}
