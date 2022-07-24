import 'package:equatable/equatable.dart';

abstract class BluetoothFailures extends Equatable {
  @override
  List<Object> get props => [];
}

class BluetoothGenericFailure extends BluetoothFailures {}

class BluetoothFailure extends BluetoothFailures {}

class UnableToConnectDeviceFailure extends BluetoothFailures {}
