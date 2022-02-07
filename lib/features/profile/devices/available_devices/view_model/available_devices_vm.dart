part of '../../devices.dart';

class AvailableDevicesVm extends ChangeNotifier {
  final devDevices = [
    DeviceConnectionType(
      deviceType: DeviceType.CONTOUR_PLUS_ONE,
      name: LocaleProvider.current.contour_plus_blood_sugar,
      imagePath: R.image.contour,
      enable: true,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.ACCU_CHEK,
      name: LocaleProvider.current.accu_chek_blood_sugar,
      imagePath: R.image.accuCheckPng,
      enable: true,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.OMRON_BLOOD_PRESSURE_ARM,
      name: LocaleProvider.current.omron_blood_pressure_arm,
      imagePath: R.image.omronBloodPressureArm,
      enable: false,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.OMRON_BLOOD_PRESSURE_WRIST,
      name: LocaleProvider.current.omron_blood_pressure_wrist,
      imagePath: R.image.omronBloodPressureWrist,
      enable: false,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.OMRON_SCALE,
      name: LocaleProvider.current.omron_scale,
      imagePath: R.image.omronScale,
      enable: false,
      usesBLE: false,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.MI_SCALE,
      name: LocaleProvider.current.mi_scale,
      imagePath: R.image.miScale,
      enable: true,
      usesBLE: false,
    ),
  ];

  final prodDevices = [
    DeviceConnectionType(
      deviceType: DeviceType.CONTOUR_PLUS_ONE,
      name: LocaleProvider.current.contour_plus_blood_sugar,
      imagePath: R.image.contour,
      enable: true,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.ACCU_CHEK,
      name: LocaleProvider.current.accu_chek_blood_sugar,
      imagePath: R.image.accuCheckPng,
      enable: true,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.MI_SCALE,
      name: LocaleProvider.current.mi_scale,
      imagePath: R.image.miScale,
      enable: true,
      usesBLE: false,
    ),
  ];

  List<DeviceConnectionType> items = [];

  AvailableDevicesVm() {
    items.addAll(devDevices);
  }
}
