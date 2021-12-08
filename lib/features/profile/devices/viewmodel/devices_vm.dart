part of '../devices.dart';

class DevicesVm extends ChangeNotifier {
  LoadingProgress _state = LoadingProgress.LOADING;
  LoadingProgress get state => _state;
  List<PairedDevice> devices;
  set state(LoadingProgress value) {
    _state = value;
    notifyListeners();
  }

  DevicesVm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAll();
    });
  }

  Future<void> getAll() async {
    state = LoadingProgress.LOADING;
    devices = await getIt<BleDeviceManager>().getPairedDevices();
    state = LoadingProgress.DONE;
  }

  deletePairedDevice(String id) {
    print('here: $id');

    getIt<BleDeviceManager>().deletePairedDevice(id);
    devices.removeWhere((element) => element.deviceId == id);

    notifyListeners();

    Atom.dismiss();
    ScaffoldMessenger.of(Atom.context).showSnackBar(SnackBar(
        content: Text('${LocaleProvider.current.paired_devices_deleted}')));
  }
}
