import 'dart:typed_data';

import 'package:flutter_reactive_ble/src/model/discovered_device.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/ble_models/paired_device.dart';

import '../../database/datamodels/scale_data.dart';
import '../../types/unit.dart';
import 'scale_device_model.dart';

class MiScaleDevice extends ScaleDevice<MiScaleDevice> {
  final DiscoveredDevice device;
  MiScaleDevice({this.device}) : super(device: device);

  @override
  MiScaleDevice from(DiscoveredDevice device) {
    if (matchesDeviceType(device)) {
      return MiScaleDevice(device: device);
    } else {
      throw Exception('Device doesnt march any device');
    }
  }

  @override
  ScaleModel parseScaleData(PairedDevice device, Uint8List data) {
    return _parseScaleData(device, data);
  }

  ScaleModel _parseScaleData(PairedDevice device, Uint8List data) {
    if (data.length != 13) return null;
    // Prepare data
    final byteData = data.buffer.asByteData();
    // Parse flags
    final measurementComplete = data[1] & (0x01 << 1) != 0;
    final weightStabilized = data[1] & (0x01 << 5) != 0;
    final weightRemoved = data[1] & (0x01 << 7) != 0;
    final unit = (data[0] & 0x01 != 0) ? ScaleUnit.LBS : ScaleUnit.KG;
    final isBitSet = (data[1] & (1 << 1)) != 0;
    // Parse date
    final year = byteData.getUint16(2, Endian.little);
    final month = byteData.getUint8(4);
    final day = byteData.getUint8(5);
    final hour = byteData.getUint8(6);
    final minute = byteData.getUint8(7);
    final seconds = byteData.getUint8(8);
    final measurementTime =
        DateTime.utc(year, month, day, hour, minute, seconds);

    var impedance = 0;

    if (isBitSet) {
      impedance = ((data[10] & 0xFF) << 8) | (data[9] & 0xFF);
    }
    // Parse weight
    var weight = byteData.getUint16(11, Endian.little).toDouble();
    if (unit == ScaleUnit.LBS) {
      weight /= 100;
    } else if (unit == ScaleUnit.KG) {
      weight /= 200;
    } // Return new scale data
    super.scaleData = ScaleModel(
        device: device,
        measurementComplete: measurementComplete,
        weightStabilized: weightStabilized,
        weightRemoved: weightRemoved,
        unit: unit,
        dateTime: measurementTime,
        weight: weight,
        impedance: impedance);
    return scaleData;
  }

  @override
  bool matchesDeviceType(device) {
    return device.name == 'MIBFS' &&
        device.serviceData.length == 1 &&
        device.serviceData.values.first.length == 13;
  }
}
