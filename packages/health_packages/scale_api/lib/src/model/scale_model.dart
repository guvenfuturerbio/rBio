import 'dart:convert';

import 'package:hive/hive.dart';

part 'scale_model.g.dart';

@HiveType(typeId: 1)
class ScaleModel extends HiveObject {
  /// const DB Parameters

  /// Table
  static const table = 'scale';

  /// Unic
  static const timeConst = 'time';

  /// Device Constants
  static const String deviceConst = 'device';
  static const String deviceTypeConst = 'device_type';
  static const String deviceNameConst = 'device_name';
  static const String deviceIdConst = 'device_id';

  /// Scale Constants
  static const String bmiConst = 'bmi';
  static const String bodyFatConst = 'body_fat';
  static const String boneMassConst = 'bone_mass';
  static const String dateTimeConst = 'date_time';
  static const String heightConst = 'height';
  static const String manualConst = 'manuel';
  static const String measurementIdConst = 'measurement_id';
  static const String visceralFatConst = 'visceral_fat';
  static const String waterConst = 'water';
  static const String weightConst = 'weight';
  static const String scaleUnitConst = 'unit';
  static const String muscleConst = 'muscle';

  /// Spesific Constants
  static const String userIdConst = 'user_id';
  static const String imagesConst = 'images';
  static const String noteConst = 'note';
  static const String isDeletedConst = 'is_deleted';

  /// Value is `true` if the weight has stabilized.
  bool? weightStabilized;

  /// Value is `true` if the device is done measuring.
  /// This value is usually given after other measurements (such as body fat) have been completed as well.
  bool? measurementComplete;

  /// Value is `true` if there is no weight detected.
  bool? weightRemoved;

  /// ID of the device this data was parsed from.

  @HiveField(0)
  Map<String, dynamic>? device;

  @HiveField(1)
  double? weight;

  /// The currently configured weight unit on the device.
  @HiveField(2)
  final ScaleUnit? unit;

  /// Body Index Variables
  /// This variable calculating after measurement complete.
  @HiveField(3)
  double? bmi;

  @HiveField(4)
  double? water;

  @HiveField(5)
  double? bodyFat;

  @HiveField(6)
  double? visceralFat;

  @HiveField(7)
  double? boneMass;

  @HiveField(8)
  double? muscle;

  @HiveField(9)
  double? bmh;

  /// This variable giving the data has deleted on db
  @HiveField(10)
  bool? isDeleted;

  /// User optinally can add the note related this measurements
  @HiveField(11)
  String? note;

  /// User can add manualy own weight but taken as a default value [false]
  @HiveField(12)
  bool? isManuel;

  /// Image variable holding only path/url data for the scale not required.
  /// The variable length must be <=3,
  /// When trying to parse this stuation must be handeled
  @HiveField(13)
  List<String>? images = [];

  /// Data will use calculate BMI Body Mass etc.
  @HiveField(14)
  int? impedance;

  /// This variables taken by user information.
  /// required for calculating other variable
  @HiveField(15)
  int? height;

  @HiveField(16)
  int? gender;

  @HiveField(17)
  int? age;

  /// Each scale measurement must have a unic id. We are giving this value as a [dateTime.milisecondsSinceEpoch(dateTime)]
  @HiveField(18)
  int? time;

  /// The timestamp given by the device.
  ///
  /// Note that this value must only be considered valid if [weightRemoved] is `false` and [weightStabilized] is `true`.
  /// This can also be checked by calling dateTimeValid
  @HiveField(19)
  DateTime dateTime;

  /// this value provided by server.
  /// So can be return null.
  @HiveField(20)
  int? measurementId;

  bool isFromHealth;

  @override
  ScaleModel({
    this.device,
    this.measurementId,
    this.weight,
    this.weightStabilized,
    this.measurementComplete,
    this.weightRemoved,
    this.unit,
    required this.dateTime,
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
    this.isFromHealth = false,
  });

  @override
  factory ScaleModel.fromMap(Map map) {
    return ScaleModel(
      device: map[deviceConst] == null
          ? null
          : jsonDecode(map[deviceConst] as String) as Map<String, dynamic>,
      time: map[timeConst] as int? ??
          DateTime.parse(map['occurrence_time'] as String)
              .millisecondsSinceEpoch,
      weight: map[weightConst] as double?,
      isManuel: map[manualConst] != 0,
      unit: ((map[scaleUnitConst] as String?) ?? 'kg').fromStr,
      images: map[imagesConst] == null
          ? []
          : (map[imagesConst] as List).cast<String>(),
      note: map[noteConst] as String?,
      water: map[waterConst] as double?,
      bmi: map[bmiConst] as double?,
      bodyFat: map[bodyFatConst] as double?,
      boneMass: map[boneMassConst] as double?,
      muscle: map[muscleConst] as double?,
      measurementId: map[measurementIdConst] as int?,
      visceralFat: map[visceralFatConst] as double?,
      isDeleted: map[isDeletedConst] != 0,
      dateTime: DateTime.parse(
        (map[dateTimeConst] as String?) ?? map['occurrence_time'] as String,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is ScaleModel) {
      if (measurementId == null || other.measurementId == null) {
        return time == other.time;
      } else {
        return measurementId == other.measurementId;
      }
    } else {
      return false;
    }
  }

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
      case ScaleUnit.kg:
        return 'kg';
      case ScaleUnit.lbs:
        return 'lbs';
      default:
        throw Exception('Unit has not defined');
    }
  }

  ScaleModel copy() {
    return ScaleModel.fromMap(
      jsonDecode(jsonEncode(toMap())) as Map<String, dynamic>,
    );
  }

  ScaleModel fromMap(Map map) => ScaleModel(
        device: jsonDecode(map[deviceConst] as String) as Map<String, dynamic>,
        time: map[timeConst] as int?,
        weight: map[weightConst] as double?,
        unit: map[scaleUnitConst] as ScaleUnit?,
        isManuel: map[manualConst] != 0,
        images: (map[imagesConst] as List).cast<String>(),
        note: map[noteConst] as String?,
        water: map[waterConst] as double?,
        bmi: map[bmiConst] as double?,
        bmh: map['bmh'] as double?,
        bodyFat: map[bodyFatConst] as double?,
        boneMass: map[boneMassConst] as double?,
        muscle: map[muscleConst] as double?,
        measurementId: map[measurementIdConst] as int?,
        visceralFat: map[visceralFatConst] as double?,
        isDeleted: map[isDeletedConst] != 0,
        dateTime: DateTime.parse(
          map[dateTimeConst] as String,
        ),
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      deviceConst: device == null ? null : jsonEncode(device),
      timeConst: time,
      weightConst: weight,
      scaleUnitConst: unit?.toStr,
      manualConst: isManuel ?? false ? 1 : 0,
      imagesConst: images,
      noteConst: note,
      waterConst: water,
      bmiConst: bmi,
      bodyFatConst: bodyFat,
      boneMassConst: boneMass,
      muscleConst: muscle,
      heightConst: height,
      measurementIdConst: measurementId,
      visceralFatConst: visceralFat,
      isDeletedConst: isDeleted ?? false ? 1 : 0,
      userIdConst: 0,
      dateTimeConst: dateTime.toIso8601String(),
    };
  }

  bool isEqual(ScaleModel other) {
    if (other.isFromHealth) {
      return bmi == other.bmi &&
          weight == other.weight &&
          bodyFat == other.bodyFat &&
          dateTime.millisecondsSinceEpoch ==
              other.dateTime.millisecondsSinceEpoch;
    }

    return jsonEncode(toMap()) == jsonEncode(other.toMap());
  }
}

@HiveType(typeId: 5)
enum ScaleUnit {
  @HiveField(0)
  kg,

  @HiveField(1)
  lbs
}

enum StripMode { add, subtract, none }

extension SUE on ScaleUnit {
  String get toStr {
    switch (this) {
      case ScaleUnit.kg:
        return 'kg';
      case ScaleUnit.lbs:
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
        return ScaleUnit.kg;
      case 'lbs':
        return ScaleUnit.lbs;
      default:
        return ScaleUnit.kg;
    }
  }
}
