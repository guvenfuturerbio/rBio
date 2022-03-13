import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:shared_preferences_manager/shared_preferences_manager.dart';

import '../bluetooth_connector.dart';

class BluetoothConnector {
  late final BleConnector _connector;
  late final BleDeviceManager _deviceManager;
  late final BleScanner _scanner;
  late final FlutterReactiveBle ble;

  BluetoothConnector(
    this.ble,
    ISharedPreferencesManager sharedPrefs, {
    BleConnector? connector,
    BleDeviceManager? deviceManager,
    BleScanner? scanner,
  })  : _connector = connector ?? BleConnector(ble),
        _deviceManager = deviceManager ?? BleDeviceManager(sharedPrefs),
        _scanner = scanner ?? BleScanner(ble);

  Stream<ListenConnectedDeviceStreamArgs> listenConnectedDeviceStream() async* {
    yield* _connector.listenConnectedDeviceStream();
  }

  Future<List<String>> getPairedDevicesWithId() async {
    final List<PairedDevice> pairedDevice =
        await _deviceManager.getPairedDevices();
    return pairedDevice.map((e) => e.deviceId!).toList();
  }

  Future<List<PairedDevice>> getPairedDevices() async {
    final List<PairedDevice> pairedDevice =
        await _deviceManager.getPairedDevices();
    return pairedDevice;
  }
  
  Stream<List<DiscoveredDevice>> startScan(
    void Function(DiscoveredDevice) emit2State,
  ) async* {
    yield* _scanner.startScan(
      autoConnect: (device) async {
        await connect(device, emit2State);
      },
    );
  }

  Future<void> stopScan(
    void Function(List<DiscoveredDevice>) emitState,
  ) async =>
      _scanner.stopScan(emitState);

  Future<List<String>?> savePairedDevices(PairedDevice pairedDevice) async {
    final pairedDevices = await _deviceManager.savePairedDevices(pairedDevice);
    if (pairedDevices.isNotEmpty) {
      _scanner.pairedDevices = pairedDevices.map((e) => e.deviceId!).toList();
      return _scanner.pairedDevices;
    } else {
      return null;
    }
  }

  Future<List<String>?> deletePairedDevice(String id) async {
    final pairedDevices = await _deviceManager.deletePairedDevice(id);
    if (pairedDevices.isNotEmpty) {
      _connector.removePairedDevice();
      _scanner.pairedDevices =
          pairedDevices.map((e) => e.deviceId ?? '').toList();
      return _scanner.pairedDevices;
    } else {
      return null;
    }
  }

  Future<void> connect(
    DiscoveredDevice device,
    void Function(DiscoveredDevice) emitState,
  ) =>
      _connector.connect(device, emitState);

  Future<void> disconnect(String deviceId) => _connector.disconnect(deviceId);

  // Bağlanmak için cihazı seçtiğimizde kartın rengi için cihaz status durumunu liste edip okuduğumuz kısım.
  ConnectionStateUpdate? getStatus(
      List<ConnectionStateUpdate> deviceConnectionState, String id) {
    final deviceIndex =
        deviceConnectionState.indexWhere((element) => element.deviceId == id);
    if (deviceIndex != -1) {
      return deviceConnectionState[deviceIndex];
    } else {
      return null;
    }
  }

  Future<bool> hasDeviceAlreadyPaired(PairedDevice device) =>
      _deviceManager.hasDeviceAlreadyPaired(device);

  void refreshDeviceList() {
    _scanner.refreshDeviceList();
  }

  DeviceType getDeviceType() => _connector.getDeviceType();

  DiscoveredDevice? get device => _connector.device;
}
