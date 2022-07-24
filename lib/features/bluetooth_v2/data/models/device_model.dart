import 'package:collection/collection.dart';

import '../../../../core/core.dart';
import '../../domain/entity/device_entity.dart';

class DeviceModel extends DeviceEntity {
  DeviceModel({
    required String id,
    required String name,
    required String localName,
    required int strength,
    required DeviceKind kind,
    required DeviceType? deviceType,
  }) : super(
          id: id,
          name: name,
          localName: localName,
          strength: strength,
          kind: kind,
          deviceType: deviceType,
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
