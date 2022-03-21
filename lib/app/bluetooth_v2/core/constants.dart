class BluetoothConstants {
  BluetoothConstants._();

  static const miScaleNotifyDuration = Duration(seconds: 25);
  static final miScaleUUIDs = <String, dynamic>{
    "Weight": {
      "serviceUUID": "0000181b-0000-1000-8000-00805f9b34fb",
      "characteristicUUID": "00002a9c-0000-1000-8000-00805f9b34fb",
    },
  };
}
