import '../../domain/entity/device_entity.dart';
import 'package:collection/collection.dart';

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
}

enum DeviceKind {
  ble,
  wifi,
  classicBluetooth,
  usb,
  none,
  unknown,
}

extension DeviceKindExtension on DeviceKind {
  String get xRawValue => toString().split('.').last;
}

extension DeviceKindStringExtension on String {
  DeviceKind? get xDeviceKind => DeviceKind.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}
