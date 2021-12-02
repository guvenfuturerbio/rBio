import '../../../../../generated/l10n.dart';

class DeviceConnectionType {
  String name;
  String imagePath;
  bool usesBLE;
  String navigateLink;
  DeviceType deviceType;
  DeviceConnectionType(
      {this.name,
      this.imagePath,
      this.usesBLE = true,
      this.navigateLink,
      this.deviceType});
}

enum DeviceType {
  ACCU_CHEK,
  CONTOUR_PLUS_ONE,
  OMRON_BLOOD_PRESSURE_ARM,
  OMRON_BLOOD_PRESSURE_WRIST,
  OMRON_SCALE,
  MI_SCALE
}

extension DeviceTypeExtension on DeviceType {
  String get name {
    switch (this) {
      case DeviceType.ACCU_CHEK:
        return 'ACCU-CHEK';
      case DeviceType.CONTOUR_PLUS_ONE:
        return 'Contour Plus One';
      case DeviceType.OMRON_BLOOD_PRESSURE_ARM:
        return LocaleProvider.current.omron_blood_pressure_arm;
      case DeviceType.OMRON_BLOOD_PRESSURE_WRIST:
        return LocaleProvider.current.omron_blood_pressure_wrist;
      case DeviceType.OMRON_SCALE:
        return LocaleProvider.current.omron_scale;
      case DeviceType.MI_SCALE:
        return LocaleProvider.current.mi_scale;
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
    } else if (this == LocaleProvider.current.omron_blood_pressure_arm) {
      return DeviceType.OMRON_BLOOD_PRESSURE_ARM;
    } else if (this == LocaleProvider.current.omron_blood_pressure_wrist) {
      return DeviceType.OMRON_BLOOD_PRESSURE_WRIST;
    } else if (this == LocaleProvider.current.omron_scale) {
      return DeviceType.OMRON_SCALE;
    } else if (this == LocaleProvider.current.mi_scale) {
      return DeviceType.MI_SCALE;
    } else {
      return null;
    }
  }
}
