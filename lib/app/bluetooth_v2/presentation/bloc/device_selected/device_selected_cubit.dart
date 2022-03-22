import 'package:flutter/material.dart';

import '../../../bluetooth_v2.dart';

part 'device_selected_state.dart';

class DeviceSelectedCubit extends Cubit<DeviceSelectedState> {
  DeviceSelectedCubit(
    this.connectDeviceUseCase,
    this.disconnectDeviceUseCase,
    this.bluetoothLocalManager,
    this.deviceLastStatusUseCase,
  ) : super(DeviceSelectedState.initial());
  final ConnectDeviceUseCase connectDeviceUseCase;
  final DisconnectDeviceUseCase disconnectDeviceUseCase;
  final BluetoothLocalManager bluetoothLocalManager;
  final DeviceLastStatusUseCase deviceLastStatusUseCase;

  void checkAfterConnect(DeviceEntity device) {
    final result = deviceLastStatusUseCase.call(DeviceParams(device: device));
    result.fold(
      (l) {
        LoggerUtils.instance.e("[DeviceSelectedCubit] - connect() - $l");
      },
      (deviceStatus) async {
        final deviceState = await deviceStatus;
        if (deviceState != DeviceStatus.connected) {
          final result =
              connectDeviceUseCase.call(DeviceParams(device: device));
          result.fold(
            (l) {
              emit(DeviceSelectedState.error("Something went wrong"));
            },
            (r) {
              emit(DeviceSelectedState.done(device, true));
            },
          );
        }
      },
    );
  }

  void connect(DeviceEntity device) {
    final result = connectDeviceUseCase.call(DeviceParams(device: device));
    result.fold(
      (l) {
        emit(DeviceSelectedState.error("Something went wrong"));
      },
      (r) {
        emit(DeviceSelectedState.done(device, true));
      },
    );
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
  }

  void connectAndListen(BuildContext context) {
    final pairedDevices = bluetoothLocalManager.getPairedDevices();
    for (var element in pairedDevices) {
      if (element.deviceType == DeviceType.miScale) {
        context.read<DeviceSelectedCubit>().checkAfterConnect(element);
        Future.delayed(
          const Duration(seconds: 1),
          () {
            context.read<MiScaleReadValuesCubit>().readValue(
                  DeviceModel(
                    id: element.id,
                    name: element.name,
                    localName: element.localName,
                    kind: element.kind,
                    strength: element.strength,
                    deviceType: element.deviceType,
                  ),
                  "Weight",
                );
          },
        );
      }
    }
  }
}
