import '../../../../core/core.dart';
import '../../data/models/device_model.dart';

class DeviceEntity extends IBaseModel<DeviceEntity> {
  DeviceEntity({
    required this.id,
    required this.name,
    required this.strength,
    required this.kind,
    required this.deviceType,
  });

  final String id;
  final String name;
  final int strength;
  final DeviceKind kind;
  final DeviceType? deviceType;

  factory DeviceEntity.empty() {
    return DeviceEntity(
      id: '',
      name: '',
      strength: 0,
      kind: DeviceKind.none,
      deviceType: null,
    );
  }

  factory DeviceEntity.fromJson(Map<String, dynamic> json) => DeviceEntity(
        id: json["id"],
        name: json["name"],
        strength: json["strength"],
        kind: (json["kind"] as String).xDeviceKind ?? DeviceKind.none,
        deviceType: (json["deviceType"] as String).xDeviceType,
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
        "deviceType": deviceType!.xRawValue,
      };

  DeviceEntity setDeviceType({
    required DeviceType newDeviceType,
  }) {
    return DeviceEntity(
      id: id,
      name: name,
      strength: strength,
      kind: kind,
      deviceType: newDeviceType,
    );
  }
}
