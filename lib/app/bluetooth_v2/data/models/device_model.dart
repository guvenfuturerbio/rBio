import '../../domain/entity/device_entity.dart';

class DeviceModel extends DeviceEntity {
  DeviceModel({
    required String id,
    required String name,
    required int strength,
    required DeviceKind kind,
  }) : super(
          id: id,
          name: name,
          strength: strength,
          kind: kind,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'strength': strength,
      'kind': "$kind",
    };
  }
}

enum DeviceKind {
  ble,
  wifi,
  classicBluetooth,
  usb,
  none,
  unknown,
}
