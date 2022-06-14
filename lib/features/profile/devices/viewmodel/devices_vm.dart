part of '../devices.dart';

class DevicesVm extends ChangeNotifier {
  LoadingProgress _state = LoadingProgress.loading;
  LoadingProgress get state => _state;
  set state(LoadingProgress value) {
    _state = value;
    notifyListeners();
  }

  List<RbioDevice> devices = [];

  DevicesVm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAll();
    });
  }

  Future<void> getAll() async {
    try {
      state = LoadingProgress.loading;
      final devicesV1 = getIt<BleDeviceManager>().getPairedDevices();
      final devicesV2 = getIt<BluetoothLocalManager>().getPairedDevices();
      for (var element in devicesV1) {
        devices.add(
            RbioDevice(version: BluetoothDeviceVersion.v1, v1Device: element));
      }
      for (var element in devicesV2) {
        devices.add(
            RbioDevice(version: BluetoothDeviceVersion.v2, v2Device: element));
      }
      state = LoadingProgress.done;
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      state = LoadingProgress.error;
    }
  }

  Future<void> deletePairedDeviceV1(String id) async {
    await getIt<BleDeviceManager>().deletePairedDevice(id);

    devices.removeWhere((element) {
      if (id == element.v1Device?.deviceId) {
        return true;
      } else {
        return false;
      }
    });

    notifyListeners();
    Atom.dismiss();
    Utils.instance.showSnackbar(
      Atom.context,
      LocaleProvider.current.paired_devices_deleted,
    );
  }

  Future<void> deletePairedDeviceV2(
    BuildContext context,
    DeviceEntity device,
  ) async {
    devices.removeWhere((element) {
      if (device.id == element.v2Device?.id) {
        return true;
      } else {
        return false;
      }
    });

    await getIt<BluetoothLocalManager>().deletePairedDevice(device.id);

    context.read<DeviceSelectedCubit>().disconnect(device);

    if (device.deviceType == DeviceType.miScale) {
      BlocProvider.of<MiScaleStatusCubit>(context).resetState();
    }

    notifyListeners();
    Atom.dismiss();
    Utils.instance.showSnackbar(
      Atom.context,
      LocaleProvider.current.paired_devices_deleted,
    );
  }
}
