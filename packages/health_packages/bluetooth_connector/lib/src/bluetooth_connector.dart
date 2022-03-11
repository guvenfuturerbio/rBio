import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../bluetooth_connector.dart';

class BluetoothConnector {
  late final BleConnector _connector;
  late final BleDeviceManager _deviceManager;
  late final BleScanner _scanner;

  BluetoothConnector(
    this._connector,
    this._deviceManager,
    this._scanner,
  );

  void listenConnectedDeviceStream({
    required void Function(List<ConnectionStateUpdate>) emitState,
    required void Function(DiscoveredDevice) accuChek,
    required void Function(DiscoveredDevice) contourPlusOne,
    required void Function(DiscoveredDevice) miScale,
  }) {
    final stream = _connector.listenConnectedDeviceStream(emitState);

    stream.listen((event) {
      //Reactor dosyasına gönderilen kısım. Cihazı tanıdıktan sonra cihazın verilerini yazıyoruz.
      if (event.connectionState == DeviceConnectionState.connected) {
        switch (_connector.getDeviceType()) {
          case DeviceType.accuChek:
            accuChek(_connector.device!);
            break;

          case DeviceType.contourPlusOne:
            contourPlusOne(_connector.device!);
            break;

          case DeviceType.miScale:
            miScale(_connector.device!);
            break;

          default:
            break;
        }
      } else if (event.connectionState == DeviceConnectionState.disconnected) {
        _scanner.refreshDeviceList();
      }
    });
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

  Future<void> startScan(
    void Function(List<DiscoveredDevice>) emitState,
    void Function(DiscoveredDevice) emit2State,
  ) async {
    await _scanner.startScan(
      emitState: emitState,
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
}
