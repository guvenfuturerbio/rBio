import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/utils.dart';
import 'map_convertable.dart';

class GlucoseData extends MapConvertible {
  static final LEVEL = "level";
  static final TAG = "tag"; // -1, 0, 1, 2, 3
  static final NOTE = "note";
  static final TIME = "time";
  static final DEVICE = "device"; // Accu-Chek = 0 ; Contour Plus = 1;
  static final MANUAL =
      "manual"; // If data is manually entered the field is true, otherwise it's false
  static final DEVICE_NAME = "device_name";
  static final DEVICE_UUID = "device_uuid";
  static final IMAGE_URL = "image_url";
  static final IS_DELETED = "is_deleted";
  static final USER_ID = "user_id";
  static final TABLE = "glucose";
  static final MEASUREMENT_ID = "id";

  int measurementId;
  String level;
  int tag; // 1 aç 2 tok 3 other
  String note;
  int time;
  int device;
  bool manual;
  String deviceName;
  String deviceUUID;
  String imageURL;
  XFile imageFile = XFile("");
  bool isDeleted;
  int userId;
  // BG
  String get date => DateTime.fromMillisecondsSinceEpoch(time).toString();
  Color get color =>
      UtilityManager().getGlucoseMeasurementColor(int.parse(level));

  @override
  GlucoseData(
      {this.level,
      this.tag,
      this.note,
      this.time,
      this.device,
      this.manual = false,
      this.deviceUUID = "",
      this.deviceName = "",
      this.imageURL = "",
      this.isDeleted = false,
      this.userId,
      this.measurementId});

  GlucoseData fromGlucoseData(GlucoseData glucoseData) {
    return new GlucoseData(
        level: glucoseData.level,
        tag: glucoseData.tag,
        note: glucoseData.note,
        time: glucoseData.time,
        device: glucoseData.device,
        manual: glucoseData.manual,
        deviceName: glucoseData.deviceName,
        deviceUUID: glucoseData.deviceUUID,
        imageURL: glucoseData.imageURL,
        isDeleted: glucoseData.isDeleted,
        userId: glucoseData.userId,
        measurementId: glucoseData.measurementId);
  }

  @override
  factory GlucoseData.fromMap(Map map) => GlucoseData(
      level: map[LEVEL],
      tag: map[TAG],
      note: map[NOTE],
      time: map[TIME],
      device: map[DEVICE],
      manual: map[MANUAL] == 0 ? false : true,
      deviceName: map[DEVICE_NAME],
      deviceUUID: map[DEVICE_UUID],
      imageURL: map[IMAGE_URL],
      isDeleted: map[IS_DELETED] == 0 ? false : true,
      userId: map[USER_ID],
      measurementId: map[MEASUREMENT_ID]);

  @override
  GlucoseData fromMap(Map map) {
    return GlucoseData(
        level: map[LEVEL],
        tag: map[TAG],
        note: map[NOTE],
        time: map[TIME],
        device: map[DEVICE],
        manual: map[MANUAL] == 0 ? false : true,
        deviceName: map[DEVICE_NAME],
        deviceUUID: map[DEVICE_UUID],
        imageURL: map[IMAGE_URL],
        isDeleted: map[IS_DELETED] == 0 ? false : true,
        userId: map[USER_ID],
        measurementId: map[MEASUREMENT_ID]);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      LEVEL: level,
      TAG: tag,
      NOTE: note,
      TIME: time,
      DEVICE: device,
      MANUAL: manual,
      DEVICE_NAME: deviceName,
      DEVICE_UUID: deviceUUID,
      IMAGE_URL: imageURL,
      IS_DELETED: isDeleted,
      USER_ID: userId,
      MEASUREMENT_ID: measurementId
    };
  }

  @override
  String toString() {
    return "Time: ${time} - Level: ${level} - Tag ${tag}";
  }
}
