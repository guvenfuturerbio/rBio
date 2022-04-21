import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:scale_dependencies/scale_dependencies.dart';

import '../../../omron_wrist/omron_connectivity_platform.dart';
import '../../../omron_wrist/omron_wrist_core/core.dart';
import '../../bluetooth_v2.dart';

abstract class DeviceLocalDataSource {
  Stream<BluetoothState> readBluetoothStatus();
  Stream<List<DeviceModel>> searchDevices(DeviceType deviceType);
  Future<void> stopScan();
  bool connect(DeviceModel device);
  bool readFromOmronMethode();
  bool disconnect(DeviceModel device);
  Stream<DeviceStatus> readStatus(DeviceModel device);
  Stream<MiScaleModel> miScaleReadValues(DeviceModel device);
  void miScaleStopListen();
  Future<DeviceStatus> getLastStateOfDevice(DeviceModel device);
  Future<bool> pillarSmallTrigger(DeviceModel device);
}

class BluetoothDeviceLocalDataSourceImpl extends DeviceLocalDataSource {
  Timer? miScaleTimer;

  @override
  Stream<BluetoothState> readBluetoothStatus() {
    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
    return flutterBlue.state;
  }

  @override
  Stream<List<DeviceModel>> searchDevices(DeviceType deviceType) {
    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
    flutterBlue.startScan();
    return flutterBlue.scanResults.map(
      (event) {
        var tempList = event;
        tempList = tempList.where((element) {
          if (deviceType == DeviceType.miScale) {
            if ((element.device.name == 'MIBFS' &&
                element.advertisementData.serviceData.length == 1 &&
                element.advertisementData.serviceData.values.first.length ==
                    13)) {
              return true;
            }
          } else if (deviceType == DeviceType.accuCheck) {
            if (element.device.name.contains("meter") &&
                element.advertisementData.manufacturerData ==
                    {
                      368: [215, 33, 0, 1, 0, 1]
                    }) {
              return true;
            }
          } else if (deviceType == DeviceType.pillarSmall) {
            if (element.device.name.contains("Arduino")) {
              LoggerUtils.instance.i("BURADA");
              LoggerUtils.instance
                  .i(element.advertisementData.manufacturerData);
            }
          } else if (deviceType == DeviceType.omronBloodPressureWrist) {
            if (element.device.id.id.substring(0, 8) == '28:FF:B2' &&
                element.device.name.contains('BLEsmart_00000244')) {
              return true;
            }
          } else if (deviceType == DeviceType.omronBloodPressureArm) {
            if ((element.device.id.id.substring(0, 8) == '28:FF:B2' &&
                    element.device.name.contains("BLEsmart_00000264")) ||
                element.device.name.contains("M4 Intelli")) {
              return true;
            }
          }
          return false;
        }).toList();

        return tempList.map(
          (e) {
            LoggerUtils.instance.wtf(e.device.name);
            return DeviceModel(
              id: e.device.id.id,
              name: e.device.name,
              localName: e.advertisementData.localName,
              strength: e.rssi,
              kind: DeviceKind.ble,
              deviceType: deviceType,
            );
          },
        ).toList();
      },
    );
  }

  @override
  Future<void> stopScan() async {
    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
    await flutterBlue.stopScan();
  }

  @override
  bool connect(DeviceModel device) {
    final bluetoothDevice = device.toBluetoothDevice();
    bluetoothDevice.connect().onError(
          (error, stackTrace) => throw UnableToConnectDeviceFailure(),
        );
    //
    if (device.deviceType == DeviceType.omronBloodPressureArm) {
      // ignore: void_checks
      connectAndReadFromOmron().onError((error, stackTrace) {
        LoggerUtils.instance.wtf(stackTrace);
        throw UnableToConnectDeviceFailure();
      });
    } else {
      // ignore: void_checks
      bluetoothDevice.connect().onError((error, stackTrace) {
        LoggerUtils.instance.wtf(stackTrace);
        throw UnableToConnectDeviceFailure();
      });
    }

    return true;
  }

  @override
  readFromOmronMethode() {
    CancelListening? transferListener;
    Map<String, dynamic> map = {};
    List<Map> mapl = [];
    map = {
      'userType': 1,
      'name': 'BLEsmart_0000026428FFB297052D',
      'uuid': '28:FF:B2:97:05:2D',
      'hashId': 'eyc'
    };
    readDatasFromOmron(map, mapl, transferListener);
    return true;
  }

  @override
  bool disconnect(DeviceModel device) {
    final bluetoothDevice = device.toBluetoothDevice();
    bluetoothDevice
        .disconnect()
        .onError((error, stackTrace) => throw UnableToConnectDeviceFailure());
    return true;
  }

  @override
  Stream<DeviceStatus> readStatus(DeviceModel device) {
    final bluetoothDevice = device.toBluetoothDevice();
    return bluetoothDevice.state.map((event) {
      switch (event) {
        case BluetoothDeviceState.disconnected:
          return DeviceStatus.disconnected;
        case BluetoothDeviceState.connecting:
          return DeviceStatus.connecting;
        case BluetoothDeviceState.connected:
          return DeviceStatus.connected;
        case BluetoothDeviceState.disconnecting:
          return DeviceStatus.disconnecting;
      }
    });
  }

  @override
  Stream<MiScaleModel> miScaleReadValues(
    DeviceModel device,
  ) async* {
    final ble = device.toBluetoothDevice();
    final services = await ble.discoverServices();
    BluetoothService relatedService = services.firstWhere((element) =>
        element.uuid.toString() == BluetoothConstants.miScale.serviceUuid);
    var characteristic = relatedService.characteristics.firstWhere((element) =>
        element.uuid.toString() ==
        BluetoothConstants.miScale.characteristicUuid);
    await characteristic.setNotifyValue(true);

    try {
      miScaleTimer?.cancel();
      miScaleTimer = null;
      miScaleTimer = Timer.periodic(BluetoothConstants.miScaleNotifyDuration,
          (timer) async {
        if (await ble.state.last == BluetoothDeviceState.disconnected) {
          timer.cancel();
          return;
        }
        await characteristic.setNotifyValue(true);
      });
    } catch (e) {
      LoggerUtils.instance
          .e("[BluetoothDeviceLocalDataSourceImpl] - miScaleReadValues() - $e");
    }

    await for (List<int> value in characteristic.value) {
      var newValue = Uint8List.fromList(value);
      MiScaleModel? model = parseScaleData(newValue, device.toJson());
      if (model != null) {
        if (!(model.measurementComplete == true &&
            model.weightRemoved == true)) {
          yield model;
        }
      }
    }
  }

  @override
  void miScaleStopListen() {
    miScaleTimer?.cancel();
    miScaleTimer = null;
  }

  @override
  Future<DeviceStatus> getLastStateOfDevice(DeviceModel device) async {
    final bluetoothDevice = device.toBluetoothDevice();
    final result = await bluetoothDevice.state.last;
    switch (result) {
      case BluetoothDeviceState.disconnected:
        return DeviceStatus.disconnected;
      case BluetoothDeviceState.connecting:
        return DeviceStatus.connecting;
      case BluetoothDeviceState.connected:
        return DeviceStatus.connected;
      case BluetoothDeviceState.disconnecting:
        return DeviceStatus.disconnecting;
    }
  }

  @override
  Future<bool> pillarSmallTrigger(DeviceModel device) async {
    final bluetoothDevice = device.toBluetoothDevice();
    final services = await bluetoothDevice.discoverServices();
    BluetoothService relatedService = services.firstWhere((element) =>
        element.uuid.toString() == BluetoothConstants.pillarSmall.serviceUuid);
    var characteristic = relatedService.characteristics.firstWhere((element) =>
        element.uuid.toString() ==
        BluetoothConstants.pillarSmall.characteristicUuid);
    await characteristic.write([1]);
    return true;
  }

  Future<void> connectAndReadFromOmron() async {
    Map<String, dynamic> map = {};
    map = {
      'userType': 1,
      'name': 'BLEsmart_0000026428FFB297052D',
      'uuid': '28:FF:B2:97:05:2D',
      'hashId': 'eyc'
    };
    await connectDevice(map);
    await continueToConnection(map);
  }

  void readDatasFromOmron(Map<String, dynamic> map,
      List<Map<dynamic, dynamic>> mapl, CancelListening? transferListener) {
    startTransferProcess(map, 'eyc');
    connectionStateChecker(
      (val) {
        LoggerUtils.instance.e('EYC ' + val.toString());
        if (val == ConnState.connected) {
          transferData((data) {
            mapl.add(PulseModel.fromMap(data).toMap());
            LoggerUtils.instance
                .e(PulseModel.fromMap(data).toJson().toString());
          });
        } else if (val == ConnState.disConnected && transferListener != null) {
          transferListener();
        }
      },
    );
  }
}
