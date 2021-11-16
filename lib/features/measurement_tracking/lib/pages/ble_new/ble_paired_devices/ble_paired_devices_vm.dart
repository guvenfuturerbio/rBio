import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/ble_models/DeviceTypes.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/ble_models/paired_device.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/notifiers/shared_pref_notifiers.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/utils.dart';
import 'package:path/path.dart';

class PairedDevicesVm extends ChangeNotifier {
  List<PairedDevice> _pairedDevices;
  BuildContext mContext;
  bool _disposed = false;
  PairedDevicesVm({BuildContext context}) {
    this.mContext = context;
    setPairedDevice();
    if (!_disposed) {
      SharedPrefNotifiers().addListener(() {
        setPairedDevice();
      });
    }
  }

  setPairedDevice() async {
    List<PairedDevice> pairedDevices =
        await SharedPrefNotifiers().getPairedDevices();
    this._pairedDevices = pairedDevices;
    notifyListeners();
  }

  List<PairedDevice> get pairedDevices => this._pairedDevices;

  deletePairedDevice(String id) {
    print('here: $id');

    SharedPrefNotifiers().deletePairedDevice(id);
    _pairedDevices.removeWhere((element) => element.deviceId == id);
    _pairedDevices.forEach((element) {
      print(element.deviceId);
    });
    notifyListeners();

    Navigator.pop(mContext, 'dialog');
    ScaffoldMessenger.of(mContext).showSnackBar(SnackBar(
        content: Text('${LocaleProvider.current.paired_devices_deleted}')));
  }

  infoFetcher(PairedDevice device) {
    List<String> currentDeviceInfos = [];
    if (device.deviceType == DeviceType.ACCU_CHEK) {
      currentDeviceInfos = R.guide.accu_check;
      return guidePopUpContextWidget(currentDeviceInfos);
    } else if (device.deviceType == DeviceType.CONTOUR_PLUS_ONE) {
      currentDeviceInfos = R.guide.contour_plus_blood;
      return guidePopUpContextWidget(currentDeviceInfos);
    } else if (device.deviceType == DeviceType.OMRON_BLOOD_PRESSURE_ARM) {
      currentDeviceInfos = R.guide.omron_arm;
      return guidePopUpContextWidget(currentDeviceInfos);
    } else if (device.deviceType == DeviceType.OMRON_BLOOD_PRESSURE_WRIST) {
      currentDeviceInfos = R.guide.omron_wrist;
      return guidePopUpContextWidget(currentDeviceInfos);
    } else if (device.deviceType == DeviceType.OMRON_SCALE) {
      currentDeviceInfos = R.guide.omron_scale;
      return guidePopUpContextWidget(currentDeviceInfos);
    } else if (device.deviceType == DeviceType.MI_SCALE) {
      currentDeviceInfos = R.guide.mi_scale;
      return guidePopUpContextWidget(currentDeviceInfos);
    } else {
      Text("There is no device info");
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
