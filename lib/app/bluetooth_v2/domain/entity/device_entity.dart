import '../../../../core/core.dart';
import '../../data/models/device_model.dart';

class DeviceEntity extends IBaseModel<DeviceEntity> {
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

  factory DeviceEntity.fromJson(Map<String, dynamic> json) => DeviceEntity(
        id: json["id"],
        name: json["name"],
        strength: json["strength"],
        kind: (json["kind"] as String).xDeviceKind ?? DeviceKind.none,
      );

  @override
  DeviceEntity fromJson(Map<String, dynamic> json) =>
      DeviceEntity.fromJson(json);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "name": name,
        "strength": strength,
        "kind": kind.xRawValue,
      };
}
