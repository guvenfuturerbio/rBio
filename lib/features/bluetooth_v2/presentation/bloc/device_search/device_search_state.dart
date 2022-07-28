part of 'device_search_cubit.dart';

enum DeviceSearchStatus {
  initial,
  searching,
  done,
  error,
}

class DeviceSearchState extends Equatable {
  const DeviceSearchState.initial()
      : devices = const <DeviceEntity>[],
        message = null,
        status = DeviceSearchStatus.initial;

  const DeviceSearchState.searching()
      : devices = const <DeviceEntity>[],
        message = null,
        status = DeviceSearchStatus.searching;

  const DeviceSearchState.done(this.devices)
      : message = null,
        status = DeviceSearchStatus.done;

  const DeviceSearchState.error(this.message)
      : devices = const <DeviceEntity>[],
        status = DeviceSearchStatus.error;

  final DeviceSearchStatus status;
  final String? message;
  final List<DeviceEntity> devices;

  @override
  List<Object?> get props => [
        message,
        devices,
        status,
      ];
}
