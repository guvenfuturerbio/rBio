part of '../devices.dart';

class DevicesVm extends ChangeNotifier {
  LoadingProgress _state = LoadingProgress.loading;
  LoadingProgress get state => _state;
  set state(LoadingProgress value) {
    _state = value;
    notifyListeners();
  }

  List<PairedDevice> devices = [];

  DevicesVm() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getAll();
    });
  }

  Future<void> getAll() async {
    try {
      state = LoadingProgress.loading;
      devices = await getIt<BluetoothConnector>().getPairedDevices();
      state = LoadingProgress.done;
    } catch (e) {
      state = LoadingProgress.error;
    }
  }

  void deletePairedDevice(String id) {
    getIt<BluetoothConnector>().deletePairedDevice(id);
    devices.removeWhere((element) => element.deviceId == id);
    notifyListeners();
    Atom.dismiss();
    Utils.instance.showSnackbar(
      Atom.context,
      LocaleProvider.current.paired_devices_deleted,
    );
  }
}
