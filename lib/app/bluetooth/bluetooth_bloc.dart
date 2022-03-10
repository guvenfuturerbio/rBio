// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mi_scale/mi_scale.dart';

import '../../core/core.dart';

part 'bluetooth_bloc.freezed.dart';
part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  final BluetoothConnector bluetoothConnector;

  BluetoothBloc(this.bluetoothConnector) : super(BluetoothState()) {
    on<_BluetoothScanStartedEvent>((event, emit) {
      bluetoothConnector.startScan(
        (list) {
          emit(state.copyWith(discoveredDevices: list));
        },
      );
    });

    on<_BluetoothScanStoppedEvent>((event, emit) {
      bluetoothConnector.stopScan(
        (list) {
          emit(state.copyWith(discoveredDevices: list));
        },
      );
    });

    on<_BluetoothGotPairedDevicesEvent>((event, emit) async {
      final list = await bluetoothConnector.getPairedDevices();
      emit(state.copyWith(pairedDevices: list));
    });

    on<_BluetoothDeviceConnectedEvent>((event, emit) {
      bluetoothConnector.listenConnectedDeviceStream(
        deviceConnectionUpdate,
        controlPointResponseUpdate,
        scaleUpdate,
      );
    });

    on<_BluetoothDeviceConnectionUpdatedEvent>((event, emit) {
      emit(state.copyWith(deviceConnectionState: event.args));
    });

    on<_BluetoothConnectedEvent>((event, emit) {
      emit(state.copyWith(device: event.device));
    });

    on<_BluetoothClearedControlPointResponseEvent>((event, emit) {
      bluetoothConnector.clearControlPointResponse(controlPointResponseUpdate);
    });
  }

  void deviceConnectionUpdate(List<ConnectionStateUpdate> args) {
    add(BluetoothEvent.deviceConnectionUpdate(args));
  }

  void controlPointResponseUpdate(result) {
    emit(state.copyWith(controlPointResponse: result));
  }

  void scaleUpdate(MiScaleDevice result) {
    emit(state.copyWith(scaleDevice: result));
  }
}
