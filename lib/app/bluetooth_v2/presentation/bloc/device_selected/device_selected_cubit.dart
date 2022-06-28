import 'dart:async';

import 'package:flutter/material.dart';

import '../../../bluetooth_v2.dart';

part 'device_selected_state.dart';

class DeviceSelectedCubit extends Cubit<DeviceSelectedState> {
  DeviceSelectedCubit(
    this.miScaleStatusCubit,
    this.connectDeviceUseCase,
    this.disconnectDeviceUseCase,
    this.bluetoothLocalManager,
    this.deviceLastStatusUseCase,
    this.searchDeviceUseCase,
  ) : super(DeviceSelectedState.initial());
  final MiScaleStatusCubit miScaleStatusCubit;
  final ConnectDeviceUseCase connectDeviceUseCase;
  final DisconnectDeviceUseCase disconnectDeviceUseCase;
  final BluetoothLocalManager bluetoothLocalManager;
  final DeviceLastStatusUseCase deviceLastStatusUseCase;
  final SearchDeviceUseCase searchDeviceUseCase;

  StreamSubscription<List<DeviceEntity>>? searchDeviceSubscription;

  void connect(DeviceEntity device) {
    final result = connectDeviceUseCase.call(DeviceParams(device: device));
    result.fold(
      (BluetoothFailures l) {
        emit(DeviceSelectedState.error("Something went wrong"));
      },
      (bool r) {
        emit(DeviceSelectedState.done(device, true));
      },
    );

    if (device.deviceType == DeviceType.miScale) {
      miScaleStatusCubit.readStatus(device);
    }
  }

  void disconnect(DeviceEntity device) {
    final result = disconnectDeviceUseCase.call(DeviceParams(device: device));
    result.fold(
      (l) {
        emit(DeviceSelectedState.error("Something went wrong"));
      },
      (r) {
        emit(DeviceSelectedState.done(device, false));
      },
    );

    if (device.deviceType == DeviceType.miScale) {
      miScaleStatusCubit.disconnect();
    }
  }

  void connectAndListen(BuildContext context) {
    final pairedDevices = bluetoothLocalManager.getPairedDevices();
    for (var element in pairedDevices) {
      if (element.deviceType == DeviceType.miScale) {
        final stream = searchDeviceUseCase.call(SearchParams(deviceType: DeviceType.miScale));
        stream.fold(
          (BluetoothFailures l) {},
          (Stream<List<DeviceEntity>> r) {
            searchDeviceSubscription?.cancel();
            searchDeviceSubscription = r.listen(
              (event) {
                if (event.any((DeviceEntity item) => item.id == element.id)) {
                  context.read<DeviceSelectedCubit>().connect(element);
                }
              },
            );
          },
        );
      }
    }
  }
}
