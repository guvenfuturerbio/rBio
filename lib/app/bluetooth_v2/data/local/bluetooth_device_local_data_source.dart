import 'dart:async';
import 'dart:typed_data';

import 'package:mi_scale/mi_scale.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:onedosehealth/app/bluetooth_v2/core/failures.dart';

import '../../../../core/core.dart';
import '../../core/constants.dart';
import '../../domain/usecase/read_status_device_usecase.dart';
import '../models/device_model.dart';
import 'helpers/bluetooth_device_extension.dart';

abstract class DeviceLocalDataSource {
  Stream<List<DeviceModel>> searchDevices(DeviceType deviceType);
  Future<void> stopScan();
  bool connect(DeviceModel device);
  bool disconnect(DeviceModel device);
  Stream<DeviceStatus> readStatus(DeviceModel device);
  Stream<MiScaleModel> miScaleReadValues(DeviceModel device, String field);
}

class BluetoothDeviceLocalDataSourceImpl extends DeviceLocalDataSource {
  @override
  Stream<List<DeviceModel>> searchDevices(DeviceType deviceType) {
    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
    flutterBlue.startScan();
    return flutterBlue.scanResults.map(
      (event) {
        var tempList = event;
        tempList = tempList.where((element) {
          if (deviceType == DeviceType.miScale) {
            if (element.device.name == 'MIBFS' &&
                element.advertisementData.serviceData.length == 1 &&
                element.advertisementData.serviceData.values.first.length ==
                    13) {
              return true;
            }
          }

          return false;
        }).toList();

        return tempList.map(
          (e) {
            return DeviceModel(
              name: e.device.name,
              strength: e.rssi,
              id: e.device.id.id,
              kind: DeviceKind.ble,
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
    bluetoothDevice
        .connect()
        .onError((error, stackTrace) => throw UnableToConnectDeviceFailure());
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
      DeviceModel device, String field) async* {
    final BluetoothDevice ble = device.toBluetoothDevice();
    final services = await ble.discoverServices();
    BluetoothService relatedService = services.firstWhere((element) =>
        element.uuid.toString() ==
        BluetoothConstants.miScaleUUIDs["Weight"]?["serviceUUID"]);
    var characteristic = relatedService.characteristics.firstWhere((element) =>
        element.uuid.toString() ==
        BluetoothConstants.miScaleUUIDs["Weight"]?["characteristicUUID"]);
    await characteristic.setNotifyValue(true);
    Timer.periodic(BluetoothConstants.miScaleNotifyDuration, (timer) async {
      await characteristic.setNotifyValue(true);
    });
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
}
