// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mi_scale_status_cubit.dart';

class MiScaleStatus {
  final DeviceStatus? status;
  final DeviceEntity? device;

  MiScaleStatus({
    this.status,
    this.device,
  });

  MiScaleStatus copyWith({
    DeviceStatus? status,
    DeviceEntity? device,
  }) {
    return MiScaleStatus(
      status: status ?? this.status,
      device: device ?? this.device,
    );
  }
}
