import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../bluetooth_v2.dart';

class PairedDeviceListingVm extends ChangeNotifier {
  LoadingProgress _state = LoadingProgress.loading;
  LoadingProgress get state => _state;
  set state(LoadingProgress value) {
    _state = value;
    notifyListeners();
  }

  List<DeviceEntity> devices = [];

  PairedDeviceListingVm() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getAll();
    });
  }

  Future<void> getAll() async {
    try {
      state = LoadingProgress.loading;
      devices = getIt<BluetoothLocalManager>().getPairedDevices();
      state = LoadingProgress.done;
    } catch (e) {
      state = LoadingProgress.error;
    }
  }

  void deletePairedDevice(String id) {
    getIt<BluetoothLocalManager>().deletePairedDevice(id);
    devices.removeWhere((element) => element.id == id);
    notifyListeners();
    Atom.dismiss();
    Utils.instance.showSnackbar(
      Atom.context,
      LocaleProvider.current.paired_devices_deleted,
    );
  }
}
