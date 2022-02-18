part of '../omron.dart';

class OmronDeviceConnectionRequestModel {
  final String deviceName;
  final String uuid;
  final String hashId;
  final int userIndex;

  OmronDeviceConnectionRequestModel({
    required this.deviceName,
    required this.uuid,
    required this.hashId,
    required this.userIndex,
  });

  Map<String, dynamic> toJson() {
    return {
      'device': deviceName,
      'uuid': uuid,
      'hashId': hashId,
      'userType': userIndex,
    };
  }
}
