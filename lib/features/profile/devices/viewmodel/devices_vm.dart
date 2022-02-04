part of '../devices.dart';

class DevicesVm extends ChangeNotifier {
  LoadingProgress state = LoadingProgress.loading;
  List<PairedDevice> devices = [];

  DevicesVm() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getAll();
    });
  }

  Future<void> getAll() async {
    try {
      state = LoadingProgress.loading;
      devices = await getIt<BleDeviceManager>().getPairedDevices();
      state = LoadingProgress.done;
    } catch (e) {
      state = LoadingProgress.error;
    }
  }

  void deletePairedDevice(String id) {
    getIt<BleDeviceManager>().deletePairedDevice(id);
    devices.removeWhere((element) => element.deviceId == id);
    notifyListeners();
    Atom.dismiss();
    ScaffoldMessenger.of(Atom.context).showSnackBar(
      SnackBar(
        content: Text(LocaleProvider.current.paired_devices_deleted),
      ),
    );
  }
}
