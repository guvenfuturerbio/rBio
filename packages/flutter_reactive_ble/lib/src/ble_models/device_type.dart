import 'package:collection/collection.dart';

class DeviceConnectionType {
  String? name;
  String? imagePath;
  bool? usesBLE;
  bool? enable;
  String? navigateLink;
  DeviceType? deviceType;

  DeviceConnectionType({
    this.name,
    this.imagePath,
    this.usesBLE = true,
    this.navigateLink,
    this.deviceType,
    this.enable,
  });
}

enum DeviceType {
  accuChek,
  contourPlusOne,
  omronBloodPressureArm,
  omronBloodPressureWrist,
  omronScale,
  miScale,
  manuel,
}

extension DeviceTypeEnumExtension on DeviceType {
  String get xRawValue => toString().split('.').last;
}

extension DeviceTypeStringExtension on String {
  DeviceType? get xDeviceType => DeviceType.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension DeviceTypeExtension on DeviceType {
  String? get name {
    switch (this) {
      case DeviceType.accuChek:
        return 'ACCU-CHEK';

      case DeviceType.contourPlusOne:
        return 'Contour Plus One';

      case DeviceType.omronBloodPressureArm:
        return 'Omron Blood Pressure Arm';

      case DeviceType.omronBloodPressureWrist:
        return 'Omron Blood Pressure Wrist';

      case DeviceType.omronScale:
        return 'Omron Scale';

      case DeviceType.miScale:
        return 'Mi Scale';

      case DeviceType.manuel:
        return 'manuel';

      default:
        return null;
    }
  }
}

extension TypeExtensionOnDevice on String {
  DeviceType? get toType {
    if (this == 'ACCU-CHEK') {
      return DeviceType.accuChek;
    } else if (this == 'Contour Plus One') {
      return DeviceType.contourPlusOne;
    } else if (this == 'Omron Blood Pressure Arm') {
      return DeviceType.omronBloodPressureArm;
    } else if (this == 'Omron Blood Pressure Wrist') {
      return DeviceType.omronBloodPressureWrist;
    } else if (this == 'Omron Scale') {
      return DeviceType.omronScale;
    } else if (this == 'Mi Scale') {
      return DeviceType.miScale;
    } else if (this == 'manuel') {
      return DeviceType.manuel;
    } else {
      return null;
    }
  }

  DeviceType? get fromEnv {
    if (this == 'ACCU_CHEK') {
      return DeviceType.accuChek;
    } else if (this == 'CONTOUR_PLUS_ONE') {
      return DeviceType.contourPlusOne;
    } else if (this == 'OMRON_BLOOD_PRESSURE_ARM') {
      return DeviceType.omronBloodPressureArm;
    } else if (this == 'OMRON_BLOOD_PRESSURE_WRIST') {
      return DeviceType.omronBloodPressureWrist;
    } else if (this == 'OMRON_SCALE') {
      return DeviceType.omronScale;
    } else if (this == 'MI_SCALE') {
      return DeviceType.miScale;
    } else {
      return null;
    }
  }
}
