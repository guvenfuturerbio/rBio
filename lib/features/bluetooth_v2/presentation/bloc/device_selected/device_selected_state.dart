part of 'device_selected_cubit.dart';

enum DeviceSelectedStatus {
  initial,
  connected,
  error,
}

class DeviceSelectedState extends Equatable {
  DeviceSelectedState.initial()
      : device = DeviceEntity.empty(),
        message = null,
        connected = false,
        status = DeviceSelectedStatus.initial;

  const DeviceSelectedState.done(this.device, this.connected)
      : message = null,
        status = DeviceSelectedStatus.connected;

  DeviceSelectedState.error(this.message)
      : device = DeviceEntity.empty(),
        connected = false,
        status = DeviceSelectedStatus.error;

  final DeviceSelectedStatus status;
  final String? message;
  final DeviceEntity device;
  final bool connected;

  @override
  List<Object?> get props => [
        message,
        device,
        status,
        connected,
      ];
}
