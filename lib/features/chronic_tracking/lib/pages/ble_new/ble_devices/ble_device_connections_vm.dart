import 'package:flutter/cupertino.dart';
import 'package:onedosehealth/model/ble_models/DeviceTypes.dart';

import '../../../../../../core/core.dart';
import '../../../../../../generated/l10n.dart';
import '../../../helper/resources.dart';

class DeviceConnectionsVm extends ChangeNotifier {
  List<DeviceConnectionType> _deviceConnectionTypes;
  BuildContext mContext;
  DeviceConnectionsVm({BuildContext context}) {
    this.mContext = context;
    setDevices();
  }

  setDevices() async {
    List<DeviceConnectionType> deviceConnectionTypes =
        List<DeviceConnectionType>();
    deviceConnectionTypes.add(new DeviceConnectionType(
        deviceType: DeviceType.CONTOUR_PLUS_ONE,
        name: LocaleProvider.current.contour_plus_blood_sugar,
        navigateLink: Routes.BLE_SCANNER_PAGE,
        imagePath: R.image.contour_png,
        usesBLE: true));
    deviceConnectionTypes.add(new DeviceConnectionType(
        deviceType: DeviceType.ACCU_CHEK,
        name: LocaleProvider.current.accu_chek_blood_sugar,
        navigateLink: Routes.BLE_SCANNER_PAGE,
        imagePath: R.image.accu_check_png,
        usesBLE: true));
    deviceConnectionTypes.add(new DeviceConnectionType(
        deviceType: DeviceType.OMRON_BLOOD_PRESSURE_ARM,
        name: LocaleProvider.current.omron_blood_pressure_arm,
        navigateLink: Routes.BLE_SCANNER_PAGE,
        imagePath: R.image.omron_blood_pressure_arm,
        usesBLE: true));
    deviceConnectionTypes.add(new DeviceConnectionType(
        deviceType: DeviceType.OMRON_BLOOD_PRESSURE_WRIST,
        name: LocaleProvider.current.omron_blood_pressure_wrist,
        navigateLink: Routes.BLE_SCANNER_PAGE,
        imagePath: R.image.omron_blood_pressure_wrist,
        usesBLE: true));
    deviceConnectionTypes.add(new DeviceConnectionType(
        deviceType: DeviceType.OMRON_SCALE,
        name: LocaleProvider.current.omron_scale,
        navigateLink: Routes.BLE_SCANNER_PAGE,
        imagePath: R.image.omron_scale,
        usesBLE: false));
    deviceConnectionTypes.add(new DeviceConnectionType(
        deviceType: DeviceType.MI_SCALE,
        name: LocaleProvider.current.mi_scale,
        navigateLink: Routes.BLE_SCANNER_PAGE,
        imagePath: R.image.mi_scale,
        usesBLE: false));
    this._deviceConnectionTypes = deviceConnectionTypes;
    notifyListeners();
  }

  List<DeviceConnectionType> get deviceConnectionTypes =>
      this._deviceConnectionTypes;
}
