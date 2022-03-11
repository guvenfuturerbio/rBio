// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mi_scale/mi_scale.dart';

import '../../core/core.dart';

part 'bluetooth_bloc.freezed.dart';
part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  final BluetoothConnector bluetoothConnector;
  final BleReactorOps reactor;
  final ProfileStorageImpl profileStorageImpl;

  BluetoothBloc(
    this.bluetoothConnector,
    this.reactor,
    this.profileStorageImpl,
  ) : super(BluetoothState()) {
    on<_BluetoothScanStartedEvent>((event, emit) async {
      final scanStream = bluetoothConnector.startScan(
        (device) {
          emit(state.copyWith(device: device));
        },
      );
      await emit.forEach<List<DiscoveredDevice>>(
        scanStream,
        onData: (list) {
          return state.copyWith(discoveredDevices: list);
        },
        onError: (error, stacktrace) {
          LoggerUtils.instance.i(error);
          return state;
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
      final list = await bluetoothConnector.getPairedDevicesWithId();
      emit(state.copyWith(pairedDevices: list));
    });

    on<_BluetoothDeviceConnectedEvent>((event, emit) async {
      final connectedDeviceStream =
          bluetoothConnector.listenConnectedDeviceStream();

      connectedDeviceStream.listen((event) {
        if (event.connectionStateList != null) {
          deviceConnectionUpdate(event.connectionStateList!);
        }

        //Reactor dosyasına gönderilen kısım. Cihazı tanıdıktan sonra cihazın verilerini yazıyoruz.
        if (event.connectionState?.connectionState ==
            DeviceConnectionState.connected) {
          switch (bluetoothConnector.getDeviceType()) {
            case DeviceType.accuChek:
              reactor.write(
                bluetoothConnector.device!,
                controlPointResponseUpdate,
              );
              break;

            case DeviceType.contourPlusOne:
              reactor.write(
                bluetoothConnector.device!,
                controlPointResponseUpdate,
              );
              break;

            case DeviceType.miScale:
              reactor.subscribeScaleDevice(
                bluetoothConnector.device!,
                controlPointResponseUpdate,
                scaleUpdate,
              );
              break;

            default:
              break;
          }
        } else if (event.connectionState?.connectionState ==
            DeviceConnectionState.disconnected) {
          bluetoothConnector.refreshDeviceList();
        }
      });
    });

    on<_BluetoothDeviceConnectionUpdatedEvent>((event, emit) {
      emit(state.copyWith(deviceConnectionState: event.args));
    });

    on<_BluetoothConnectedEvent>((event, emit) {
      emit(state.copyWith(device: event.device));
    });

    on<_BluetoothClearedControlPointResponseEvent>((event, emit) {
      reactor.clearControlPointResponse(controlPointResponseUpdate);
    });

    on<_BluetoothDisconnectEvent>((event, emit) async {
      await bluetoothConnector.disconnect(event.deviceId);
      final newState = state.setDeviceNull();
      emit(newState);
    });

    on<_BluetoothSavePairedDevicesEvent>((event, emit) async {
      final list =
          await bluetoothConnector.savePairedDevices(event.pairedDevice);
      if (list == null) return;
      if (event.checkSuccess != null) {
        if (event.checkSuccess == true) {
          emit(state.copyWith(controlPointResponse: event.recordAccessData));
          var localUser = profileStorageImpl.getFirst();
          var newPerson = Person.fromJson(localUser.toJson());
          newPerson.deviceUUID = event.pairedDevice.deviceId;
          await profileStorageImpl.update(
            newPerson,
            localUser.key,
          );
        } else {
          emit(state.copyWith(controlPointResponse: []));
        }
      } else {
        emit(state.copyWith(pairedDevices: list));
      }
    });

    on<_BluetoothPairedDeviceDeletedEvent>((event, emit) async {
      final list = await bluetoothConnector.deletePairedDevice(event.id);
      if (list == null) return;
      emit(state.copyWith(pairedDevices: list));
    });
  }

  void deviceConnectionUpdate(List<ConnectionStateUpdate> args) {
    add(BluetoothEvent.deviceConnectionUpdate(args));
  }

  void controlPointResponseUpdate(List<int> result) {
    emit(state.copyWith(controlPointResponse: result));
  }

  void scaleUpdate(MiScaleDevice result) {
    emit(state.copyWith(scaleDevice: result));
  }
}
