import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/generated/l10n.dart';

class DeviceConnectionType {
  String name;
  String imagePath;
  bool usesBLE;
  bool enable;
  String navigateLink;
  DeviceType deviceType;
  DeviceConnectionType(
      {this.name,
      this.imagePath,
      this.usesBLE = true,
      this.navigateLink,
      this.deviceType,
      this.enable});
}

enum DeviceType {
  ACCU_CHEK,
  CONTOUR_PLUS_ONE,
  OMRON_BLOOD_PRESSURE_ARM,
  OMRON_BLOOD_PRESSURE_WRIST,
  OMRON_SCALE,
  MI_SCALE,
  MANUEL
}

extension DeviceTypeExtension on DeviceType {
  String get name {
    switch (this) {
      case DeviceType.ACCU_CHEK:
        return 'ACCU-CHEK';
      case DeviceType.CONTOUR_PLUS_ONE:
        return 'Contour Plus One';
      case DeviceType.OMRON_BLOOD_PRESSURE_ARM:
        return 'Omron Blood Pressure Arm';
      case DeviceType.OMRON_BLOOD_PRESSURE_WRIST:
        return 'Omron Blood Pressure Wrist';
      case DeviceType.OMRON_SCALE:
        return 'Omron Scale';
      case DeviceType.MI_SCALE:
        return 'Mi Scale';
      case DeviceType.MANUEL:
        return 'manuel';
      default:
        return null;
    }
  }
}

extension TypeExtensionOnDevice on String {
  DeviceType get toType {
    if (this == 'ACCU-CHEK') {
      return DeviceType.ACCU_CHEK;
    } else if (this == 'Contour Plus One') {
      return DeviceType.CONTOUR_PLUS_ONE;
    } else if (this == 'Omron Blood Pressure Arm') {
      return DeviceType.OMRON_BLOOD_PRESSURE_ARM;
    } else if (this == 'Omron Blood Pressure Wrist') {
      return DeviceType.OMRON_BLOOD_PRESSURE_WRIST;
    } else if (this == 'Omron Scale') {
      return DeviceType.OMRON_SCALE;
    } else if (this == 'Mi Scale') {
      return DeviceType.MI_SCALE;
    } else if (this == 'manuel') {
      return DeviceType.MANUEL;
    } else {
      return null;
    }
  }

  DeviceType get fromEnv {
    if (this == 'ACCU_CHEK') {
      return DeviceType.ACCU_CHEK;
    } else if (this == 'CONTOUR_PLUS_ONE') {
      return DeviceType.CONTOUR_PLUS_ONE;
    } else if (this == 'OMRON_BLOOD_PRESSURE_ARM') {
      return DeviceType.OMRON_BLOOD_PRESSURE_ARM;
    } else if (this == 'OMRON_BLOOD_PRESSURE_WRIST') {
      return DeviceType.OMRON_BLOOD_PRESSURE_WRIST;
    } else if (this == 'OMRON_SCALE') {
      return DeviceType.OMRON_SCALE;
    } else if (this == 'MI_SCALE') {
      return DeviceType.MI_SCALE;
    } else {
      return null;
    }
  }
}
