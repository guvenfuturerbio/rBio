import 'dart:typed_data';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../../features/chronic_tracking/progress_sections/scale/viewmodel/scale_measurement_vm.dart';
import '../ble_models/paired_device.dart';

abstract class ScaleDevice<T> {
  final DiscoveredDevice? device;
  ScaleMeasurementViewModel? scaleData;

  ScaleDevice(this.device);

  /// The id of the discovere d device
  String? get id => device?.id;

  /// The name of the discovered device
  String? get name => device?.name;

  /// The signal strength of the device when it was first discovered
  int? get rssi => device?.rssi;

  /// Parse the raw advertisement data to obtain a [T] instance
  ScaleMeasurementViewModel? parseScaleData(
    PairedDevice device,
    Uint8List data,
  );

  bool matchesDeviceType(DiscoveredDevice device);

  /// Constructs an instance of an extending [Device] class.
  ///
  /// Returns `null` if [device] has no matching class for its device type.
  T from(DiscoveredDevice device);
}
