part of 'bluetooth_status_bloc.dart';

enum BluetoothStatus {
  unknown,
  unavailable,
  unauthorized,
  turningOn,
  on,
  turningOff,
  off
}

extension BluetoothStatusExtension on BluetoothState {
  BluetoothStatus get xGetStatus {
    switch (this) {
      case BluetoothState.unknown:
        return BluetoothStatus.unknown;

      case BluetoothState.unavailable:
        return BluetoothStatus.unavailable;

      case BluetoothState.unauthorized:
        return BluetoothStatus.unauthorized;

      case BluetoothState.turningOn:
        return BluetoothStatus.turningOn;

      case BluetoothState.on:
        return BluetoothStatus.on;

      case BluetoothState.turningOff:
        return BluetoothStatus.turningOff;

      case BluetoothState.off:
        return BluetoothStatus.off;
    }
  }
}
