import '../../../bluetooth_v2.dart';

part 'device_selected_state.dart';

class DeviceSelectedCubit extends Cubit<DeviceSelectedState> {
  DeviceSelectedCubit(
    this.connectDeviceUseCase,
    this.disconnectDeviceUseCase,
  ) : super(DeviceSelectedState.initial());
  final ConnectDeviceUseCase connectDeviceUseCase;
  final DisconnectDeviceUseCase disconnectDeviceUseCase;

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
}
