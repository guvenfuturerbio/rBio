part of 'bluetooth_bloc.dart';

class BluetoothState {
  BleStatus bleStatus;
  List<DiscoveredDevice> discoveredDevices;
  List<String> pairedDeviceIds;
  DiscoveredDevice? device;
  List<ConnectionStateUpdate> deviceConnectionState;

  BluetoothState({
    this.bleStatus = BleStatus.unknown,
    this.discoveredDevices = const [],
    this.pairedDeviceIds = const [],
    this.device,
    this.deviceConnectionState = const [],
  });

  @override
  String toString() {
    return 'BluetoothState(bleStatus: $bleStatus, discoveredDevices: $discoveredDevices, pairedDeviceIds: $pairedDeviceIds, device: $device, deviceConnectionState: $deviceConnectionState)';
  }
}

extension BluetoothStateExtension on BluetoothState {
  BluetoothState updateBleStatus(BleStatus value) => BluetoothState(
        bleStatus: value,
        discoveredDevices: discoveredDevices,
        pairedDeviceIds: pairedDeviceIds,
        device: device,
        deviceConnectionState: deviceConnectionState,
      );

  BluetoothState updateDevice(DiscoveredDevice? value) => BluetoothState(
        bleStatus: bleStatus,
        discoveredDevices: discoveredDevices,
        pairedDeviceIds: pairedDeviceIds,
        device: value,
        deviceConnectionState: deviceConnectionState,
      );

  BluetoothState updatePairedDeviceIds(List<String> value) => BluetoothState(
        bleStatus: bleStatus,
        discoveredDevices: discoveredDevices,
        pairedDeviceIds: value,
        device: device,
        deviceConnectionState: deviceConnectionState,
      );

  BluetoothState updateDiscoveredDevices(List<DiscoveredDevice> value) =>
      BluetoothState(
        bleStatus: bleStatus,
        discoveredDevices: value,
        pairedDeviceIds: pairedDeviceIds,
        device: device,
        deviceConnectionState: deviceConnectionState,
      );

  BluetoothState updateDeviceConnections(List<ConnectionStateUpdate> value) =>
      BluetoothState(
        bleStatus: bleStatus,
        discoveredDevices: discoveredDevices,
        pairedDeviceIds: pairedDeviceIds,
        device: device,
        deviceConnectionState: value,
      );
}
