part of 'bluetooth_bloc.dart';

@freezed
class BluetoothEvent with _$BluetoothEvent {
  const factory BluetoothEvent.init() = _BluetoothInitEvent;

  const factory BluetoothEvent.listenBleStatus() = _BluetoothListenBleStatusEvent;
  const factory BluetoothEvent.bleStatusHandler(BleStatus bleStatus) = _BluetoothBleStatusHandlerEvent;

  const factory BluetoothEvent.connect(DiscoveredDevice device) = _BluetoothConnectEvent;
  const factory BluetoothEvent.disconnect() = _BluetoothDisconnectEvent;

  const factory BluetoothEvent.updatePairedIdList(List<String> list) = _BluetoothUpdatePairedIdListEvent;
  const factory BluetoothEvent.updateDiscoveredList(List<DiscoveredDevice> list) = _BluetoothUpdateDiscoveredListEvent;
  const factory BluetoothEvent.updateDeviceConnectionList(List<ConnectionStateUpdate> list) = _BluetoothUpdateDeviceConnectionListEvent;
}
