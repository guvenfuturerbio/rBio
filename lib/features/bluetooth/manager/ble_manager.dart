part of 'ble_operators.dart';

class BleDeviceManager {
  final BleScanner scanner;
  final BleConnector connector;
  final ISharedPreferencesManager sharedPreferencesManager;

  BleDeviceManager(this.scanner, this.connector, this.sharedPreferencesManager);

  /// First of all fetching all saved paired device on localStorage.
  /// Then checking sending value it's exist.
  /// If sending value is not exist new value saving the localStorage
  /// or else do nothing.
  Future<bool> savePairedDevices(PairedDevice pairedDevice) async {
    if (!hasDeviceAlreadyPaired(pairedDevice)) {
      final _pairedDevices = getPairedDevices();
      _pairedDevices.add(pairedDevice);
      final _pairedDeviceOnLocal =
          _pairedDevices.map((device) => jsonEncode(device.toJson())).toList();
      final response = await sharedPreferencesManager.setStringList(
        SharedPreferencesKeys.pairedDevices,
        _pairedDeviceOnLocal,
      );
      scanner
          .setPairedDeviceIds(_pairedDevices.map((e) => e.deviceId!).toList());
      return response;
    } else {
      return false;
    }
  }

  bool hasDeviceAlreadyPaired(PairedDevice device) {
    final _pairedDevices = getPairedDevices();
    final pairedDeviceIndex = _pairedDevices
        .indexWhere((element) => element.deviceId == device.deviceId);
    return pairedDeviceIndex != -1;
  }

  Future<void> deletePairedDevice(String id) async {
    final response = getPairedDevices();
    final selectedDeviceIndex =
        response.indexWhere((element) => element.deviceId == id);
    if (selectedDeviceIndex != -1) {
      response.removeAt(selectedDeviceIndex);
      scanner
          .setPairedDeviceIds(response.map((e) => e.deviceId ?? '').toList());
      connector.removePairedDevice();
      final _pairedDeviceOnLocal =
          response.map((device) => jsonEncode(device.toJson())).toList();
      await sharedPreferencesManager.setStringList(
        SharedPreferencesKeys.pairedDevices,
        _pairedDeviceOnLocal,
      );
    }
  }

  /// multiple Paired device can be associated. So This method getting all [PairedDevice] as a [List<PairedDevice>]
  List<PairedDevice> getPairedDevices() {
    final List<String>? paired = sharedPreferencesManager
        .getStringList(SharedPreferencesKeys.pairedDevices);
    List<PairedDevice> pairedDevices = [];
    if (paired != null) {
      pairedDevices =
          paired.map((e) => PairedDevice.fromJson(jsonDecode(e))).toList();
    } else {
      return [];
    }
    return pairedDevices;
  }
}
