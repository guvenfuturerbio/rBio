import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/core.dart';

part 'bluetooth_bloc.freezed.dart';
part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

EventTransformer<Event> debounceSequential<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
}

const _debounce = Duration(milliseconds: 350);

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothV1State> {
  final BleScanner scanner;
  final BleConnector connector;
  final BleDeviceManager deviceManager;

  StreamSubscription<List<DiscoveredDevice>>? discoveredDevicesSubscription;

  BluetoothBloc(
    this.scanner,
    this.connector,
    this.deviceManager,
  ) : super(BluetoothV1State()) {
    // ! ------------ ------------ Init ------------ ------------

    on<_BluetoothInitEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2), () async {
        final pairedDevice = deviceManager.getPairedDevices();
        scanner
            .setPairedDeviceIds(pairedDevice.map((e) => e.deviceId!).toList());
        connector.listenConnectedDeviceStream();
      });
    });

    // ! ------------ ------------ Listen Bluetooth Status ------------ ------------

    on<_BluetoothListenBleStatusEvent>(
      (event, emit) async {
        scanner.listenBleStatus().listen((status) async {
          add(BluetoothEvent.bleStatusHandler(status));
        });
      },
      transformer: debounceSequential(_debounce),
    );

    on<_BluetoothBleStatusHandlerEvent>(
      (event, emit) async {
        emit(state.updateBleStatus(event.bleStatus));
        await scanner.statusHandler(event.bleStatus);
        discoveredDevicesSubscription?.cancel();
        discoveredDevicesSubscription = null;
        discoveredDevicesSubscription = scanner.myStream.listen((list) {
          if (event.bleStatus == BleStatus.ready) {
            add(BluetoothEvent.updateDiscoveredList(list));
          } else {
            add(const BluetoothEvent.updateDiscoveredList([]));
          }
        });
      },
      transformer: debounceSequential(const Duration(seconds: 1)),
    );

    // ! ------------ ------------ Connect - Disconnect ------------ ------------

    on<_BluetoothConnectEvent>((event, emit) async {
      emit(state.updateDevice(event.device));
      await connector.connect(event.device);
      await scanner.statusHandler(BleStatus.poweredOff);
      await Future.delayed(const Duration(milliseconds: 1500));
      await scanner.statusHandler(BleStatus.ready);
    });

    on<_BluetoothDisconnectEvent>((event, emit) async {
      emit(state.updateDevice(null));
      await connector.disconnect();
    });

    // ! ------------ ------------ Update Variables ------------ ------------

    on<_BluetoothUpdatePairedIdListEvent>(
      (event, emit) async {
        emit(state.updatePairedDeviceIds(event.list));
      },
    );

    on<_BluetoothUpdateDiscoveredListEvent>(
      (event, emit) async {
        if (event.list.isEmpty) {
          scanner.clearDiscoveredList();
        }
        emit(state.updateDiscoveredDevices(event.list));
      },
    );

    on<_BluetoothUpdateDeviceConnectionListEvent>(
      (event, emit) async {
        emit(state.updateDeviceConnections(event.list));
      },
      transformer: debounceSequential(_debounce),
    );
  }
}
