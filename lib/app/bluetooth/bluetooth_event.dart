part of 'bluetooth_bloc.dart';

@freezed
class BluetoothEvent with _$BluetoothEvent {
  const factory BluetoothEvent.gotPairedDevices() = _BluetoothGotPairedDevicesEvent;
  const factory BluetoothEvent.deviceConnected() = _BluetoothDeviceConnectedEvent;
  const factory BluetoothEvent.deviceConnectionUpdate(List<ConnectionStateUpdate> args) = _BluetoothDeviceConnectionUpdatedEvent;
  const factory BluetoothEvent.scanStarted() = _BluetoothScanStartedEvent;
  const factory BluetoothEvent.scanStopped() = _BluetoothScanStoppedEvent;
  const factory BluetoothEvent.connected(DiscoveredDevice device) = _BluetoothConnectedEvent;
  const factory BluetoothEvent.clearedControlPointResponse() = _BluetoothClearedControlPointResponseEvent;
}
