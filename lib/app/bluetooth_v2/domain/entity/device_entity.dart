import '../../data/models/device_model.dart';

class DeviceEntity {
  DeviceEntity({
    required this.id,
    required this.name,
    required this.strength,
    required this.kind,
  });

  final String id;
  final String name;
  final int strength;
  final DeviceKind kind;

  factory DeviceEntity.empty() {
    return DeviceEntity(
      id: '',
      name: '',
      strength: 0,
      kind: DeviceKind.none,
    );
  }
}
