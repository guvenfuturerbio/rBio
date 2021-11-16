import 'package:onedosehealth/features/measurement_tracking/lib/models/ble_models/DeviceTypes.dart';

class PairedDevice {
  String deviceId;
  String manufacturerName;
  String modelName;
  String serialNumber;
  DeviceType deviceType;

  PairedDevice(
      {this.deviceId,
      this.manufacturerName,
      this.modelName,
      this.serialNumber,
      this.deviceType});

  PairedDevice.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    manufacturerName = json['manufacturerName'];
    modelName = json['modelName'];
    serialNumber = json['serialNumber'];
    deviceType = (json['deviceType'] as String).toType;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceId'] = this.deviceId;
    data['manufacturerName'] = this.manufacturerName;
    data['modelName'] = this.modelName;
    data['serialNumber'] = this.serialNumber;
    data['deviceType'] = this.deviceType.name;
    return data;
  }
}
