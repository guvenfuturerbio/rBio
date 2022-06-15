class BluetoothConstants {
  BluetoothConstants._();

  static const miScaleNotifyDuration = Duration(seconds: 25);
  static const miScale = BluetoothUUIDModel(
    serviceUuid: "0000181b-0000-1000-8000-00805f9b34fb",
    characteristicUuid: "00002a9c-0000-1000-8000-00805f9b34fb",
  );

  static const pillarSmall = BluetoothUUIDModel(
    serviceUuid: "19b10000-e8f2-537e-4f6c-d104768a1214",
    characteristicUuid: "19b10001-e8f2-537e-4f6c-d104768a1214",
  );

  static const accuChekPair = BluetoothUUIDModel(
    serviceUuid: "00001808-0000-1000-8000-00805f9b34fb",
    characteristicUuid: "00002a52-0000-1000-8000-00805f9b34fb",
  );

  static const accuChekReadGlucoseData = BluetoothUUIDModel(
    serviceUuid: "00001808-0000-1000-8000-00805f9b34fb",
    characteristicUuid: "00002a18-0000-1000-8000-00805f9b34fb",
  );
}

class BluetoothUUIDModel {
  final String serviceUuid;
  final String characteristicUuid;

  const BluetoothUUIDModel({
    required this.serviceUuid,
    required this.characteristicUuid,
  });
}
