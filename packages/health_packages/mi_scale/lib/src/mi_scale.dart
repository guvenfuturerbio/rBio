import 'dart:typed_data';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:scale_api/scale_api.dart';

import '../mi_scale.dart';

class MiScaleDevice {
  DiscoveredDevice? device;

  MiScaleDevice._(this.device);

  ScaleMeasurementLogic? scaleData;
  MiScaleModel? model;

  /// The id of the discovere d device
  String? get id => device?.id;

  /// The name of the discovered device
  String? get name => device?.name;

  /// The signal strength of the device when it was first discovered
  int? get rssi => device?.rssi;

  factory MiScaleDevice.from(
    DiscoveredDevice device,
  ) {
    if (matchesDeviceType(device)) {
      return MiScaleDevice._(device);
    } else {
      throw Exception('Device doesnt march any device');
    }
  }

  MiScaleModel? parseScaleData(
    PairedDevice device,
    Uint8List data,
  ) {
    return _parseScaleData(device, data);
  }

  MiScaleModel? _parseScaleData(
    PairedDevice device,
    Uint8List? data,
  ) {
    if (data?.length != 13) return null;
    // Prepare data
    final byteData = data?.buffer.asByteData();
    // Parse flags
    final measurementComplete = data![1] & (0x01 << 1) != 0;
    final weightStabilized = data[1] & (0x01 << 5) != 0;
    final weightRemoved = data[1] & (0x01 << 7) != 0;
    final unit = (data[0] & 0x01 != 0) ? ScaleUnit.lbs : ScaleUnit.kg;
    final isBitSet = (data[1] & (1 << 1)) != 0;
    // Parse date
    final year = byteData?.getUint16(2, Endian.little);
    final month = byteData?.getUint8(4);
    final day = byteData?.getUint8(5);
    final hour = byteData?.getUint8(6);
    final minute = byteData?.getUint8(7);
    final seconds = byteData?.getUint8(8);
    final measurementTime =
        DateTime.utc(year!, month!, day!, hour!, minute!, seconds!);

    var impedance = 0;

    if (isBitSet) {
      impedance = ((data[10] & 0xFF) << 8) | (data[9] & 0xFF);
    }

    // Parse weight
    double? weight = byteData?.getUint16(11, Endian.little).toDouble();
    weight ??= 1;
    if (unit == ScaleUnit.lbs) {
      weight /= 100;
    } else if (unit == ScaleUnit.kg) {
      weight /= 200;
    } // Return new scale data

    model = MiScaleModel(
      device: device.toJson(),
      measurementComplete: measurementComplete,
      weightStabilized: weightStabilized,
      weightRemoved: weightRemoved,
      unit: unit,
      dateTime: measurementTime,
      weight: weight,
      impedance: impedance,
    );

    return model;
  }

  static bool matchesDeviceType(DiscoveredDevice device) {
    return device.name == 'MIBFS' &&
        device.serviceData.length == 1 &&
        device.serviceData.values.first.length == 13;
  }
}
