part of 'bluetooth_bloc.dart';

class BluetoothState {
  List<String>? pairedDevices;
  List<DiscoveredDevice>? discoveredDevices;
  List<ConnectionStateUpdate>? deviceConnectionState;
  DiscoveredDevice? device;
  List<int>? controlPointResponse;
  MiScaleDevice? scaleDevice;
  ScaleEntity? scaleEntity;

  BluetoothState({
    this.pairedDevices,
    this.discoveredDevices,
    this.deviceConnectionState,
    this.device,
    this.controlPointResponse,
    this.scaleDevice,
    this.scaleEntity,
  });

  BluetoothState copyWith({
    List<String>? pairedDevices,
    List<DiscoveredDevice>? discoveredDevices,
    List<ConnectionStateUpdate>? deviceConnectionState,
    DiscoveredDevice? device,
    List<int>? controlPointResponse,
    MiScaleDevice? scaleDevice,
    ScaleEntity? scaleEntity,
  }) {
    return BluetoothState(
      pairedDevices: pairedDevices ?? this.pairedDevices,
      discoveredDevices: discoveredDevices ?? this.discoveredDevices,
      deviceConnectionState:
          deviceConnectionState ?? this.deviceConnectionState,
      device: device ?? this.device,
      controlPointResponse: controlPointResponse ?? this.controlPointResponse,
      scaleDevice: scaleDevice ?? this.scaleDevice,
      scaleEntity: scaleEntity ?? this.scaleEntity,
    );
  }

  BluetoothState setDeviceNull() {
    return BluetoothState(
      pairedDevices: pairedDevices,
      discoveredDevices: discoveredDevices,
      deviceConnectionState: deviceConnectionState,
      device: null,
      controlPointResponse: controlPointResponse,
      scaleDevice: scaleDevice,
      scaleEntity: scaleEntity,
    );
  }

  @override
  String toString() {
    return 'BluetoothState(pairedDevices: $pairedDevices, discoveredDevices: $discoveredDevices, deviceConnectionState: $deviceConnectionState, device: $device, controlPointResponse: $controlPointResponse, scaleDevice: $scaleDevice, scaleEntity: $scaleEntity)';
  }
}
