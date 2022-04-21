part of '../../devices.dart';

class AvailableDevicesVm extends ChangeNotifier {
  final devDevices = [
    DeviceConnectionType(
      deviceType: DeviceType.contourPlusOne,
      name: LocaleProvider.current.contour_plus_blood_sugar,
      imagePath: R.image.contour,
      enable: true,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.accuCheck,
      name: LocaleProvider.current.accu_chek_blood_sugar,
      imagePath: R.image.accuCheckPng,
      enable: true,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.omronBloodPressureArm,
      name: LocaleProvider.current.omron_blood_pressure_arm,
      imagePath: R.image.omronBloodPressureArm,
      enable: true,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.omronBloodPressureWrist,
      name: LocaleProvider.current.omron_blood_pressure_wrist,
      imagePath: R.image.omronBloodPressureWrist,
      enable: false,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.omronScale,
      name: LocaleProvider.current.omron_scale,
      imagePath: R.image.omronScale,
      enable: false,
      usesBLE: false,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.miScale,
      name: LocaleProvider.current.mi_scale,
      imagePath: R.image.miScale,
      enable: true,
      usesBLE: false,
    ),
    // DeviceConnectionType(
    //   deviceType: DeviceType.pillarSmall,
    //   name: "Pillar Small",
    //   imagePath: R.image.trFlag,
    //   enable: true,
    //   usesBLE: false,
    // ),
  ];

  final prodDevices = [
    DeviceConnectionType(
      deviceType: DeviceType.contourPlusOne,
      name: LocaleProvider.current.contour_plus_blood_sugar,
      imagePath: R.image.contour,
      enable: true,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.accuCheck,
      name: LocaleProvider.current.accu_chek_blood_sugar,
      imagePath: R.image.accuCheckPng,
      enable: true,
      usesBLE: true,
    ),
    DeviceConnectionType(
      deviceType: DeviceType.miScale,
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
