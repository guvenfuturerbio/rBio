import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../core.dart';

@HiveType(typeId: 0)
class GlucoseData extends HiveObject {
  static const LEVEL = "level";
  static const TAG = "tag"; // -1, 0, 1, 2, 3
  static const NOTE = "note";
  static const TIME = "time";
  static const DEVICE = "device"; // Accu-Chek = 0 ; Contour Plus = 1;
  static const MANUAL =
      "manual"; // If data is manually entered the field is true, otherwise it's false
  static const DEVICE_NAME = "device_name";
  static const DEVICE_UUID = "device_uuid";
  static const IMAGE_URL = "image_url";
  static const IS_DELETED = "is_deleted";
  static const USER_ID = "user_id";
  static const TABLE = "glucose";
  static const MEASUREMENT_ID = "id";

  @HiveField(0)
  int? measurementId;
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
  int? userId;
  // BG
  String get date => DateTime.fromMillisecondsSinceEpoch(time).toString();
  Color get color =>
      UtilityManager().getGlucoseMeasurementColor(int.parse(level));

  GlucoseData({
    required this.level,
    required this.tag,
    required this.note,
    required this.time,
    required this.device,
    this.manual = false,
    this.deviceUUID = "",
    this.deviceName = "",
    this.imageURL = "",
    this.isDeleted = false,
    this.userId,
    this.measurementId,
  });

  GlucoseData fromGlucoseData(GlucoseData glucoseData) {
    return GlucoseData(
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
      measurementId: glucoseData.measurementId,
    );
  }

  GlucoseData copy() {
    return GlucoseData.fromMap(
        jsonDecode(jsonEncode(toMap())) as Map<String, dynamic>);
  }

  factory GlucoseData.fromMap(Map map) => GlucoseData(
        level: map[LEVEL] as String,
        tag: map[TAG] as int,
        note: map[NOTE] as String,
        time: map[TIME] as int,
        device: map[DEVICE] as int,
        manual: map[MANUAL] == 0 ? false : true,
        deviceName: map[DEVICE_NAME] as String,
        deviceUUID: map[DEVICE_UUID] as String,
        imageURL: map[IMAGE_URL] as String,
        isDeleted: map[IS_DELETED] == 0 ? false : true,
        userId: map[USER_ID] as int,
        measurementId: map[MEASUREMENT_ID] as int,
      );

  GlucoseData fromMap(Map map) {
    return GlucoseData(
      level: map[LEVEL] as String,
      tag: map[TAG] as int,
      note: map[NOTE] as String,
      time: map[TIME] as int,
      device: map[DEVICE] as int,
      manual: map[MANUAL] == 0 ? false : true,
      deviceName: map[DEVICE_NAME] as String,
      deviceUUID: map[DEVICE_UUID] as String,
      imageURL: map[IMAGE_URL] as String,
      isDeleted: map[IS_DELETED] == 0 ? false : true,
      userId: map[USER_ID] as int,
      measurementId: map[MEASUREMENT_ID] as int,
    );
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
    if (other is GlucoseData) {
      if (measurementId == null || other.measurementId == null) {
        return time == other.time;
      } else {
        return measurementId == other.measurementId;
      }
    } else {
      return false;
    }
  }

  bool isEqual(GlucoseData other) {
    return jsonEncode(this.toMap()) == jsonEncode(other.toMap());
  }
}

class GlucoseDataAdapter extends TypeAdapter<GlucoseData> {
  @override
  final int typeId = 0;

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
