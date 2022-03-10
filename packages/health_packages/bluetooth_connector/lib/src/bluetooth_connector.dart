import 'package:mi_scale/mi_scale.dart';
import 'package:onedosehealth/core/core.dart';

import '../bluetooth_connector.dart';

class BluetoothConnector {
  late BleConnector _connector;
  late BleDeviceManager _deviceManager;
  late BleScanner _scannerOps;
  late BleReactorOps _reactorOps;

  BluetoothConnector(
    this._connector,
    this._deviceManager,
    this._scannerOps,
    this._reactorOps,
  );

  void listenConnectedDeviceStream(
    void Function(List<ConnectionStateUpdate>) emitState,
    void Function(List<int>) emit2State,
    void Function(MiScaleDevice) emit3State,
  ) {
    final stream = _connector.listenConnectedDeviceStream(emitState);

    stream.listen((event) {
      //Reactor dosyasına gönderilen kısım. Cihazı tanıdıktan sonra cihazın verilerini yazıyoruz.
      if (event.connectionState == DeviceConnectionState.connected) {
        switch (_connector.getDeviceType()) {
          case DeviceType.accuChek:
            getIt<BleReactorOps>().write(
              _connector.device!,
              emit2State,
            );
            break;

          case DeviceType.contourPlusOne:
            getIt<BleReactorOps>().write(
              _connector.device!,
              emit2State,
            );
            break;

          case DeviceType.miScale:
            getIt<BleReactorOps>().subscribeScaleDevice(
              _connector.device!,
              emit2State,
              emit3State,
            );
            break;

          default:
            break;
        }
      } else if (event.connectionState == DeviceConnectionState.disconnected) {
        _scannerOps.refreshDeviceList();
      }
    });
  }

  Future<List<String>> getPairedDevices() async {
    final List<PairedDevice> pairedDevice =
        await _deviceManager.getPairedDevices();
    return pairedDevice.map((e) => e.deviceId!).toList();
  }

  void startScan(void Function(List<DiscoveredDevice>) emitState) =>
      _scannerOps.startScan(emitState);

  Future<void> stopScan(
          void Function(List<DiscoveredDevice>) emitState) async =>
      _scannerOps.stopScan(emitState);

  Future<bool> savePairedDevices(PairedDevice pairedDevice) async {
    final pairedDevices = await _deviceManager.savePairedDevices(pairedDevice);
    if (pairedDevices.isNotEmpty) {
      _scannerOps.pairedDevices =
          pairedDevices.map((e) => e.deviceId!).toList();
      return true;
    } else {
      return false;
    }
    //notifyListeners();
  }

  Future<bool> deletePairedDevice(String id) async {
    final pairedDevices = await _deviceManager.deletePairedDevice(id);
    if (pairedDevices.isNotEmpty) {
      _connector.removePairedDevice();
      _scannerOps.pairedDevices =
          pairedDevices.map((e) => e.deviceId ?? '').toList();
      return true;
    } else {
      return false;
    }
    //notifyListeners();
  }

  Future<void> connect(
    DiscoveredDevice device,
    void Function(DiscoveredDevice) emitState,
  ) =>
      _connector.connect(device, emitState);

  void clearControlPointResponse(void Function(List<int>) emitState) =>
      _reactorOps.clearControlPointResponse(emitState);
}
