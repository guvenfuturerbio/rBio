import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import 'package:onedosehealth/core/core.dart';

@HiveType(typeId: 0)
class GlucoseData extends HiveObject {
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

  @HiveField(0)
  int measurementId;
  @HiveField(1)
  String level;
  @HiveField(2)
  int tag; // 1 aç 2 tok 3 other
  @HiveField(3)
  String note;
  @HiveField(4)
  int time;
  @HiveField(5)
  int device;
  @HiveField(6)
  bool manual;
  @HiveField(7)
  String deviceName;
  @HiveField(8)
  String deviceUUID;
  @HiveField(9)
  String imageURL;
  PickedFile imageFile = PickedFile("");
  @HiveField(10)
  bool isDeleted;
  @HiveField(11)
  int userId;
  // BG
  String get date => DateTime.fromMillisecondsSinceEpoch(time).toString();
  Color get color =>
      UtilityManager().getGlucoseMeasurementColor(int.parse(level));

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

  @override
  bool operator ==(Object other) {
    return other is GlucoseData && other.time == time;
  }
}

class GlucoseDataAdapter extends TypeAdapter<GlucoseData> {
  @override
  final int typeId = 1;

  @override
  GlucoseData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GlucoseData(
      level: fields[1] as String,
      tag: fields[2] as int,
      note: fields[3] as String,
      time: fields[4] as int,
      device: fields[5] as int,
      manual: fields[6] as bool,
      deviceUUID: fields[8] as String,
      deviceName: fields[7] as String,
      imageURL: fields[9] as String,
      isDeleted: fields[10] as bool,
      userId: fields[11] as int,
      measurementId: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GlucoseData obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.measurementId)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.tag)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.device)
      ..writeByte(6)
      ..write(obj.manual)
      ..writeByte(7)
      ..write(obj.deviceName)
      ..writeByte(8)
      ..write(obj.deviceUUID)
      ..writeByte(9)
      ..write(obj.imageURL)
      ..writeByte(10)
      ..write(obj.isDeleted)
      ..writeByte(11)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlucoseDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
