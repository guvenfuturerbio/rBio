import '../bluetooth_connector.dart';

class BluetoothConnector {
  late BleConnector _connector;
  late BleDeviceManager _deviceManager;
  late BleScanner _scannerOps;

  BluetoothConnector(
    this._connector,
    this._deviceManager,
    this._scannerOps,
  );
}
