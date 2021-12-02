import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:onedosehealth/model/ble_models/paired_device.dart';

import '../core.dart';

@HiveType(typeId: 1)
class ScaleModel extends HiveObject {
  /// const DB Parameters

  /// Table
  static final TABLE = 'scale';

  /// Unic
  static final TIME = 'time';

  /// Device Constants
  static final String DEVICE = 'device';
  static final String DEVICE_TYPE = 'device_type';
  static final String DEVICE_NAME = 'device_name';
  static final String DEVICE_ID = 'device_id';

  /// Scale Constants
  static final String BMI = 'bmi';
  static final String BODY_FAT = 'body_fat';
  static final String BONE_MASS = 'bone_mass';
  static final String DATE_TIME = 'date_time';
  static final String HEIGHT = 'height';
  static final String MANUEL = 'manuel';
  static final String MEASUREMENT_ID = 'measurement_id';
  static final String VISCERAL_FAT = 'visceral_fat';
  static final String WATER = 'water';
  static final String WEIGHT = 'weight';
  static final String SCALE_UNIT = 'unit';
  static final String MUSCLE = 'muscle';

  /// Spesific Constants
  static final String USER_ID = 'user_id';
  static final String IMAGES = 'images';
  static final String NOTE = 'note';
  static final String IS_DELETED = 'is_deleted';

  /// Value is `true` if the weight has stabilized.
  final bool weightStabilized;

  /// Value is `true` if the device is done measuring.
  /// This value is usually given after other measurements (such as body fat) have been completed as well.
  final bool measurementComplete;

  /// Value is `true` if there is no weight detected.
  final bool weightRemoved;

  /// ID of the device this data was parsed from.

  @HiveField(0)
  final Map<String, dynamic> device;

  @HiveField(1)
  double weight;

  /// The currently configured weight unit on the device.
  @HiveField(2)
  final ScaleUnit unit;

  /// Body Index Variables
  /// This variable calculating after measurement complete.
  @HiveField(3)
  double bmi;
  @HiveField(4)
  double water;
  @HiveField(5)
  double bodyFat;
  @HiveField(6)
  double visceralFat;
  @HiveField(7)
  double boneMass;
  @HiveField(8)
  double muscle;
  @HiveField(9)
  double bmh;

  /// This variable giving the data has deleted on db
  @HiveField(10)
  bool isDeleted;

  /// User optinally can add the note related this measurements
  @HiveField(11)
  String note;

  /// User can add manualy own weight but taken as a default value [false]
  @HiveField(12)
  bool isManuel;

  /// Image variable holding only path/url data for the scale not required.
  /// The variable length must be <=3,
  /// When trying to parse this stuation must be handeled
  @HiveField(13)
  List<String> images = [];

  /// Data will use calculate BMI Body Mass etc.
  @HiveField(14)
  int impedance;

  /// This variables taken by user information.
  /// required for calculating other variable
  @HiveField(15)
  int height;
  @HiveField(16)
  int gender;
  @HiveField(17)
  int age;

  /// Each scale measurement must have a unic id. We are giving this value as a [dateTime.milisecondsSinceEpoch(dateTime)]
  @HiveField(18)
  int time;

  /// The timestamp given by the device.
  ///
  /// Note that this value must only be considered valid if [weightRemoved] is `false` and [weightStabilized] is `true`.
  /// This can also be checked by calling [dateTimeValid]
  @HiveField(19)
  DateTime dateTime;

  /// this value provided by server.
  /// So can be return null.
  @HiveField(20)
  int measurementId;

  bool get dateTimeValid => weightStabilized && !weightRemoved;

  @override
  ScaleModel({
    this.device,
    this.measurementId,
    this.weight,
    this.weightStabilized,
    this.measurementComplete,
    this.weightRemoved,
    this.unit,
    this.dateTime,
    this.impedance,
    this.isManuel = false,
    this.images = const <String>[],
    this.note = '',
    this.bmi,
    this.bodyFat,
    this.boneMass,
    this.isDeleted = false,
    this.muscle,
    this.time,
    this.visceralFat,
    this.water,
    this.bmh,
    this.gender,
    this.height,
    this.age,
  }) {
    gender = getIt<ProfileStorageImpl>().getFirst().gender == 'Male' ||
            getIt<ProfileStorageImpl>().getFirst().gender == 'Erkek'
        ? 1
        : 0;
    height = int.parse(getIt<ProfileStorageImpl>().getFirst().height);

    List<String> nums =
        getIt<ProfileStorageImpl>().getFirst().birthDate.split(".");
    var yearOfBirth = int.parse(nums[2]);

    age = DateTime.now().year - yearOfBirth < 15
        ? 15
        : DateTime.now().year - yearOfBirth;
  }

  @override
  factory ScaleModel.fromMap(Map map) {
    return ScaleModel(
        device: jsonDecode(map[DEVICE]),
        time: map[TIME],
        weight: map[WEIGHT],
        unit: (map[SCALE_UNIT] as String).fromStr,
        isManuel: map[MANUEL] == 0 ? false : true,
        images: (map[IMAGES] as List).cast<String>(),
        note: map[NOTE],
        water: map[WATER],
        bmi: map[BMI],
        bodyFat: map[BODY_FAT],
        boneMass: map[BONE_MASS],
        muscle: map[MUSCLE],
        visceralFat: map[VISCERAL_FAT],
        isDeleted: map[IS_DELETED] == 0 ? false : true,
        dateTime: DateTime.parse(map[DATE_TIME]));
  }

  @override
  bool operator ==(Object other) => other is ScaleModel && time == other.time;

  @override
  int get hashCode =>
      weight.hashCode ^
      weightStabilized.hashCode ^
      measurementComplete.hashCode ^
      weightRemoved.hashCode ^
      unit.hashCode ^
      dateTime.hashCode;

  @override
  String toString() {
    return toMap().toString();
  }

  String get getUnit {
    switch (unit) {
      case ScaleUnit.KG:
        return 'kg';
        break;
      case ScaleUnit.LBS:
        return 'lbs';
        break;
      default:
        throw Exception('Unit has not defined');
    }
  }

  ScaleModel copy() {
    return ScaleModel.fromMap(jsonDecode(jsonEncode(this.toMap())));
  }

  ScaleModel fromMap(Map map) => ScaleModel(
      device: jsonDecode(map[DEVICE]),
      time: map[TIME],
      weight: map[WEIGHT],
      unit: map[SCALE_UNIT],
      isManuel: map[MANUEL] == 0 ? false : true,
      images: (map[IMAGES] as List).cast<String>(),
      note: map[NOTE],
      water: map[WATER],
      bmi: map[BMI],
      bodyFat: map[BODY_FAT],
      boneMass: map[BONE_MASS],
      muscle: map[MUSCLE],
      visceralFat: map[VISCERAL_FAT],
      isDeleted: map[IS_DELETED] == 0 ? false : true,
      dateTime: DateTime.parse(map[DATE_TIME]));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DEVICE: device == null ? null : jsonEncode(device),
      TIME: time,
      WEIGHT: weight,
      SCALE_UNIT: unit.toStr,
      MANUEL: isManuel ? 1 : 0,
      IMAGES: images,
      NOTE: note,
      WATER: water,
      BMI: bmi,
      BODY_FAT: bodyFat,
      BONE_MASS: boneMass,
      MUSCLE: muscle,
      HEIGHT: height,
      MEASUREMENT_ID: time,
      VISCERAL_FAT: visceralFat,
      IS_DELETED: isDeleted ? 1 : 0,
      USER_ID: 0,
      DATE_TIME: dateTime.toIso8601String(),
    };
  }

  bool isEqual(ScaleModel other) {
    return jsonEncode(this.toMap()) == jsonEncode(other.toMap());
  }
}

enum ScaleUnit { KG, LBS }
enum StripMode { ADD, SUBTRACT, NONE }

extension SUE on ScaleUnit {
  String get toStr {
    switch (this) {
      case ScaleUnit.KG:
        return 'kg';
        break;
      case ScaleUnit.LBS:
        return 'lbs';
      default:
        throw Exception('Unhandled scale type');
    }
  }
}

extension ScalUnitString on String {
  ScaleUnit get fromStr {
    switch (this) {
      case 'kg':
        return ScaleUnit.KG;
      case 'lbs':
        return ScaleUnit.LBS;
      default:
        return ScaleUnit.KG;
    }
  }
}

class ScaleModelAdapter extends TypeAdapter<ScaleModel> {
  @override
  final int typeId = 1;

  @override
  ScaleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScaleModel(
      device: jsonDecode(fields[0] as String),
      weight: fields[1] as double,
      unit: (fields[2] as String).fromStr,
      dateTime: DateTime.parse(fields[19] as String),
      impedance: fields[14] as int,
      isManuel: fields[12] as bool,
      images: (fields[13] as List).cast<String>(),
      note: fields[11] as String,
      bmi: fields[3] as double,
      bodyFat: fields[5] as double,
      boneMass: fields[7] as double,
      isDeleted: fields[10] as bool,
      muscle: fields[8] as double,
      time: fields[18] as int,
      visceralFat: fields[6] as double,
      gender: fields[16] as int,
      height: fields[15] as int,
      bmh: fields[9] as double,
      age: fields[17] as int,
      water: fields[4] as double,
      measurementId: fields[20] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ScaleModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(jsonEncode(obj.device))
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.unit.toStr)
      ..writeByte(3)
      ..write(obj.bmi)
      ..writeByte(4)
      ..write(obj.water)
      ..writeByte(5)
      ..write(obj.bodyFat)
      ..writeByte(6)
      ..write(obj.visceralFat)
      ..writeByte(7)
      ..write(obj.boneMass)
      ..writeByte(8)
      ..write(obj.muscle)
      ..writeByte(9)
      ..write(obj.bmh)
      ..writeByte(10)
      ..write(obj.isDeleted)
      ..writeByte(11)
      ..write(obj.note)
      ..writeByte(12)
      ..write(obj.isManuel)
      ..writeByte(13)
      ..write(obj.images)
      ..writeByte(14)
      ..write(obj.impedance)
      ..writeByte(15)
      ..write(obj.height)
      ..writeByte(16)
      ..write(obj.gender)
      ..writeByte(17)
      ..write(obj.age)
      ..writeByte(18)
      ..write(obj.time)
      ..writeByte(19)
      ..write(obj.dateTime.toIso8601String())
      ..writeByte(20)
      ..write(obj.measurementId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScaleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
