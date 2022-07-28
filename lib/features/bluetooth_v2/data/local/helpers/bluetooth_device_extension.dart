import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus/gen/flutterblueplus.pb.dart' as proto;

import '../../models/device_model.dart';

extension BluetoothDeviceExtension on DeviceModel {
  BluetoothDevice toBluetoothDevice() {
    proto.BluetoothDevice p = proto.BluetoothDevice.create();
    p.name = name;
    p.type = proto.BluetoothDevice_Type.LE;
    p.remoteId = id;
    return BluetoothDevice.fromProto(p);
  }
}
