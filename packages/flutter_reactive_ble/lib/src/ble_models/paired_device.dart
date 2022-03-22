import 'device_type.dart';

enum BluetoothDeviceVersion {
  v1,
  v2,
}

class PairedDevice {
  String? deviceId;
  String? modelName;
  DeviceType? deviceType;

  String? manufacturerName;
  String? serialNumber;

  PairedDevice({
    this.deviceId,
    this.manufacturerName,
    this.modelName,
    this.serialNumber,
    this.deviceType,
  });

  PairedDevice.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'] as String?;
    manufacturerName = json['manufacturerName'] as String?;
    modelName = json['modelName'] as String?;
    serialNumber = json['serialNumber'] as String?;
    deviceType = (json['deviceType'] as String).toType;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = deviceId;
    data['manufacturerName'] = manufacturerName;
    data['modelName'] = modelName;
    data['serialNumber'] = serialNumber;
    data['deviceType'] = deviceType?.name;
    return data;
  }
}
