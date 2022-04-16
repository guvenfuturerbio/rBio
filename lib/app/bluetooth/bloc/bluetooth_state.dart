part of 'bluetooth_bloc.dart';

class BluetoothV1State {
  BleStatus bleStatus;
  List<DiscoveredDevice> discoveredDevices;
  List<String> pairedDeviceIds;
  DiscoveredDevice? device;
  List<ConnectionStateUpdate> deviceConnectionState;

  BluetoothV1State({
    this.bleStatus = BleStatus.unknown,
    this.discoveredDevices = const [],
    this.pairedDeviceIds = const [],
    this.device,
    this.deviceConnectionState = const [],
  });

  @override
  String toString() {
    return 'BluetoothV1State(bleStatus: $bleStatus, discoveredDevices: $discoveredDevices, pairedDeviceIds: $pairedDeviceIds, device: $device, deviceConnectionState: $deviceConnectionState)';
  }
}

extension BluetoothV1StateExtension on BluetoothV1State {
  BluetoothV1State updateBleStatus(BleStatus value) => BluetoothV1State(
        bleStatus: value,
        discoveredDevices: discoveredDevices,
        pairedDeviceIds: pairedDeviceIds,
        device: device,
        deviceConnectionState: deviceConnectionState,
      );

  BluetoothV1State updateDevice(DiscoveredDevice? value) => BluetoothV1State(
        bleStatus: bleStatus,
        discoveredDevices: discoveredDevices,
        pairedDeviceIds: pairedDeviceIds,
        device: value,
        deviceConnectionState: deviceConnectionState,
      );

  BluetoothV1State updatePairedDeviceIds(List<String> value) => BluetoothV1State(
        bleStatus: bleStatus,
        discoveredDevices: discoveredDevices,
        pairedDeviceIds: value,
        device: device,
        deviceConnectionState: deviceConnectionState,
      );

  BluetoothV1State updateDiscoveredDevices(List<DiscoveredDevice> value) =>
      BluetoothV1State(
        bleStatus: bleStatus,
        discoveredDevices: value,
        pairedDeviceIds: pairedDeviceIds,
        device: device,
        deviceConnectionState: deviceConnectionState,
      );

  BluetoothV1State updateDeviceConnections(List<ConnectionStateUpdate> value) =>
      BluetoothV1State(
        bleStatus: bleStatus,
        discoveredDevices: discoveredDevices,
        pairedDeviceIds: pairedDeviceIds,
        device: device,
        deviceConnectionState: value,
      );
}
