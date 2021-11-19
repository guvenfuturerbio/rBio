import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onedosehealth/generated/l10n.dart';

import '../../core/services/enum/selected_scale_type.dart';
import '../../helper/resources.dart';
import '../../models/ble_models/paired_device.dart';
import '../../types/unit.dart';
import '../repository/profile_repository.dart';
import 'map_convertable.dart';

class ScaleModel extends MapConvertible {
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
  static final String IMAGE_ONE = 'image_one';
  static final String IMAGE_TWO = 'image_two';
  static final String IMAGE_THREE = 'image_three';
  static final String NOTE = 'note';
  static final String IS_DELETED = 'is_deleted';

  /// ID of the device this data was parsed from.
  final PairedDevice device;
  double weight;

  /// Value is `true` if the weight has stabilized.
  final bool weightStabilized;

  /// Value is `true` if the device is done measuring.
  /// This value is usually given after other measurements (such as body fat) have been completed as well.
  final bool measurementComplete;

  /// Value is `true` if there is no weight detected.
  final bool weightRemoved;

  /// The currently configured weight unit on the device.
  final ScaleUnit unit;

  /// Body Index Variables
  /// This variable calculating after measurement complete.
  double bmi;
  double water;
  double bodyFat;
  double visceralFat;
  double boneMass;
  double muscle;
  double bmh;

  /// This variable giving the data has deleted on db
  bool isDeleted;

  /// User optinally can add the note related this measurements
  String note;

  /// User can add manualy own weight but taken as a default value [false]
  bool isManuel;

  /// Image variable holding only path/url data for the scale not required.
  /// The variable length must be <=3,
  /// When trying to parse this stuation must be handeled
  List<String> images = [];

  /// When image path came we will convert and save to [imageFile]
  List<PickedFile> imageFile = [];

  /// Data will use calculate BMI Body Mass etc.
  int impedance;

  /// This variables taken by user information.
  /// required for calculating other variable
  int height;
  int gender;
  int age;

  /// Each scale measurement must have a unic id. We are giving this value as a [dateTime.milisecondsSinceEpoch(dateTime)]
  int time;

  /// The timestamp given by the device.
  ///
  /// Note that this value must only be considered valid if [weightRemoved] is `false` and [weightStabilized] is `true`.
  /// This can also be checked by calling [dateTimeValid]
  DateTime dateTime;

  /// this value provided by server.
  /// So can be return null.
  int measurementId;

  Map<String, int> get _getBmiRange {
    var range = {'min': 19, 'max': 25};
    return range;
  }

  Map<String, int> get _getWeightRange {
    var range = {
      'min': (weightTarget['target'] ?? 0).toInt(),
      'max': ((weightTarget['high'] - 1) ?? 0).toInt(),
    };

    return range;
  }

  Map<String, int> get _getBodyFatRange {
    var range = {
      'min': (bodyFatTarget['target'] ?? 0).toInt(),
      'max': ((bodyFatTarget['high'] - 1) ?? 0).toInt(),
    };

    return range;
  }

  /// BoneMass için bir aralık söz konusu olmadığı için plotband uygulanamaz!!!
  Map<String, int> get _getBoneMassRange {
    return {'min': 0, 'max': 0};
  }

  Map<String, int> get _getWaterRange {
    var range = {'min': 0, 'max': 0};
    if (water != null && gender == 0) {
      range = {'min': 51, 'max': 65};
    } else if (water != null && gender == 1) {
      range = {'min': 46, 'max': 60};
    }
    return range;
  }

  Map<String, int> get _getVisceralFatRange {
    var range = {'min': 0, 'max': 0};
    if (visceralFat != null) {
      range = {'min': 0, 'max': 10};
    }
    return range;
  }

  Map<String, int> get _getMuscleRange {
    return {'min': 0, 'max': 0};
  }

  Color getColor(SelectedScaleType type) => _getColor(type);

  /// TODO Extension will be use
  double getReleatedMeasurement(SelectedScaleType type) {
    switch (type) {
      case SelectedScaleType.BMI:
        return bmi;
      case SelectedScaleType.WEIGHT:
        return weight;
      case SelectedScaleType.BODY_FAT:
        return bodyFat;
      case SelectedScaleType.BONE_MASS:
        return boneMass;
      case SelectedScaleType.WATER:
        return water;
      case SelectedScaleType.VISCERAL_FAT:
        return visceralFat;
      case SelectedScaleType.MUSCLE:
        return muscle;
    }
  }

  int getTargetMin(SelectedScaleType type) {
    switch (type) {
      case SelectedScaleType.BMI:
        return _getBmiRange['min'];
        break;
      case SelectedScaleType.WEIGHT:
        return _getWeightRange['min'];
        break;
      case SelectedScaleType.BODY_FAT:
        return _getBodyFatRange['min'];
        break;
      case SelectedScaleType.BONE_MASS:
        return _getBoneMassRange['min'];
        break;
      case SelectedScaleType.WATER:
        return _getWaterRange['min'];
        break;
      case SelectedScaleType.VISCERAL_FAT:
        return _getVisceralFatRange['min'];
        break;
      case SelectedScaleType.MUSCLE:
        return _getMuscleRange['min'];
        break;
      default:
        return 0;
    }
  }

  int getTargetMax(SelectedScaleType type) {
    switch (type) {
      case SelectedScaleType.BMI:
        return _getBmiRange['max'];
        break;
      case SelectedScaleType.WEIGHT:
        return _getWeightRange['max'];
        break;
      case SelectedScaleType.BODY_FAT:
        return _getBodyFatRange['max'];
        break;
      case SelectedScaleType.BONE_MASS:
        return _getBoneMassRange['max'];
        break;
      case SelectedScaleType.WATER:
        return _getWaterRange['max'];
        break;
      case SelectedScaleType.VISCERAL_FAT:
        return _getVisceralFatRange['max'];
        break;
      case SelectedScaleType.MUSCLE:
        return _getMuscleRange['max'];

        break;
      default:
        return 0;
    }
  }

  Color _getColor(SelectedScaleType type) {
    switch (type) {
      case SelectedScaleType.BMI:
        return _getBmiColor(bmi);
        break;
      case SelectedScaleType.WEIGHT:
        return _getWeightColor(weight);
        break;
      case SelectedScaleType.BODY_FAT:
        return _getBodyFatColor(bodyFat);
        break;
      case SelectedScaleType.BONE_MASS:
        return _getBoneMassColor(boneMass);
        break;
      case SelectedScaleType.WATER:
        return _getWaterColor(water);
        break;
      case SelectedScaleType.VISCERAL_FAT:
        return _getVisceralFatColor(visceralFat);
        break;
      case SelectedScaleType.MUSCLE:
        return _getMuscleColor(muscle);
        break;
      default:
        return R.color.grey.withOpacity(.2);
    }
  }

  @override
  ScaleModel(
      {this.device,
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
      this.water}) {
    gender =
        ProfileRepository().activeProfile.gender == LocaleProvider.current.male
            ? 1
            : 0;
    height = int.parse(ProfileRepository().activeProfile.height);

    List<String> nums = ProfileRepository().activeProfile.birthDate.split(".");
    var yearOfBirth = int.parse(nums[2]);

    age = DateTime.now().year - yearOfBirth < 15
        ? 15
        : DateTime.now().year - yearOfBirth;
  }

  @override
  factory ScaleModel.fromMap(Map map) {
    var _tempImages = <String>[];

    if (map[IMAGE_ONE] != null) {
      _tempImages.add(map[IMAGE_ONE]);
    }
    if (map[IMAGE_TWO] != null) {
      _tempImages.add(map[IMAGE_TWO]);
    }
    if (map[IMAGE_THREE] != null) {
      _tempImages.add(map[IMAGE_THREE]);
    }
    return ScaleModel(
        device: map[DEVICE] != null
            ? PairedDevice.fromJson(jsonDecode(map[DEVICE]))
            : null,
        time: map[TIME],
        weight: map[WEIGHT],
        unit: map[SCALE_UNIT],
        isManuel: map[MANUEL] == 0 ? false : true,
        images: _tempImages,
        note: map[NOTE],
        water: map[WATER],
        bmi: map[BMI],
        bodyFat: map[BODY_FAT],
        boneMass: map[BONE_MASS],
        muscle: map[MUSCLE],
        visceralFat: map[VISCERAL_FAT],
        isDeleted: map[IS_DELETED] == 0 ? false : true,
        dateTime: DateTime.fromMillisecondsSinceEpoch(map[TIME]));
  }

  void calculateVariables() {
    bmi = getBMI();
    bmh = getBMH();
    time = (dateTime ?? DateTime.now()).millisecondsSinceEpoch;
    if (!isManuel) {
      visceralFat = getVisceralFat();
      if (impedance != null) {
        water = getWater();
        muscle = getMuscle();
        bodyFat = getBodyFat();
        boneMass = getBoneMass();
      }
    }
  }

  bool get dateTimeValid => weightStabilized && !weightRemoved;

  double getBMI() => weight / (((height * height) / 100.0) / 100.0);

  double getWater() {
    var coeff;
    var water = (100.0 - getBodyFat()) * 0.7;

    if (water < 50) {
      coeff = 1.02;
    } else {
      coeff = 0.98;
    }

    return coeff * water;
  }

  double getBodyFat() {
    double bodyFat = 0.0;
    double lbmSub = 0.8;
    if (gender == 0 && age <= 49) {
      lbmSub = 9.25;
    } else if (gender == 0 && age > 49) {
      lbmSub = 7.25;
    }
    double lbmCoeff = getLBMCoefficient();
    double coeff = 1.0;
    if (gender == 1 && weight < 61.0) {
      coeff = 0.98;
    } else if (gender == 0 && weight > 60.0) {
      coeff = 0.96;

      if (height > 160) {
        coeff *= 1.03;
      }
    } else if (gender == 0 && weight < 50.0) {
      coeff = 1.02;

      if (height > 160) {
        coeff *= 1.03;
      }
    }

    bodyFat = (1.0 - (((lbmCoeff - lbmSub) * coeff) / weight)) * 100.0;

    if (bodyFat > 63.0) {
      bodyFat = 75.0;
    }

    return bodyFat;
  }

  double getLBMCoefficient() {
    double lbm = (height * 9.058 / 100.0) * (height / 100.0);
    lbm += weight * 0.32 + 12.226;
    lbm -= impedance * 0.0068;
    lbm -= age * 0.0542;

    return lbm;
  }

  double getVisceralFat() {
    double visceralFat = 0.0;
    if (gender == 0) {
      if (weight > (13.0 - (height * 0.5)) * -1.0) {
        double subsubcalc =
            ((height * 1.45) + (height * 0.1158) * height) - 120.0;
        double subcalc = weight * 500.0 / subsubcalc;
        visceralFat = (subcalc - 6.0) + (age * 0.07);
      } else {
        double subcalc = 0.691 + (height * -0.0024) + (height * -0.0024);
        visceralFat = (((height * 0.027) - (subcalc * weight)) * -1.0) +
            (age * 0.07) -
            age;
      }
    } else {
      if (height < weight * 1.6) {
        double subcalc = ((height * 0.4) - (height * (height * 0.0826))) * -1.0;
        visceralFat =
            ((weight * 305.0) / (subcalc + 48.0)) - 2.9 + (age * 0.15);
      } else {
        double subcalc = 0.765 + height * -0.0015;
        visceralFat = (((height * 0.143) - (weight * subcalc)) * -1.0) +
            (age * 0.15) -
            5.0;
      }
    }

    return visceralFat;
  }

  double getBoneMass() {
    double boneMass;
    double base;
    if (gender == 0) {
      base = 0.245691014;
    } else {
      base = 0.18016894;
    }

    boneMass = (base - (getLBMCoefficient() * 0.05158)) * -1.0;

    if (boneMass > 2.2) {
      boneMass += 0.1;
    } else {
      boneMass -= 0.1;
    }

    if (gender == 0 && boneMass > 5.1) {
      boneMass = 8.0;
    } else if (gender == 1 && boneMass > 5.2) {
      boneMass = 8.0;
    }

    return boneMass;
  }

  double getMuscle() {
    double muscleMass =
        weight - ((getBodyFat() * 0.01) * weight) - getBoneMass();

    if (gender == 0 && muscleMass >= 84.0) {
      muscleMass = 120.0;
    } else if (gender == 1 && muscleMass >= 93.5) {
      muscleMass = 120.0;
    }

    return muscleMass;
  }

  addImage(String path) {
    images.add(path);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScaleModel &&
          runtimeType == other.runtimeType &&
          weight == other.weight &&
          weightStabilized == other.weightStabilized &&
          measurementComplete == other.measurementComplete &&
          weightRemoved == other.weightRemoved &&
          unit == other.unit &&
          dateTime == other.dateTime;

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

  @override
  ScaleModel fromMap(Map map) {
    var _tempImages = <String>[];

    if (map[IMAGE_ONE] != null) {
      _tempImages.add(map[IMAGE_ONE]);
    }
    if (map[IMAGE_TWO] != null) {
      _tempImages.add(map[IMAGE_TWO]);
    }
    if (map[IMAGE_THREE] != null) {
      _tempImages.add(map[IMAGE_THREE]);
    }
    return ScaleModel(
        device: map[DEVICE] != null
            ? PairedDevice.fromJson(jsonDecode(map[DEVICE]))
            : null,
        time: map[TIME],
        weight: map[WEIGHT],
        unit: map[SCALE_UNIT],
        isManuel: map[MANUEL] == 0 ? false : true,
        images: _tempImages,
        note: map[NOTE],
        water: map[WATER],
        bmi: map[BMI],
        bodyFat: map[BODY_FAT],
        boneMass: map[BONE_MASS],
        muscle: map[MUSCLE],
        visceralFat: map[VISCERAL_FAT],
        isDeleted: map[IS_DELETED] == 0 ? false : true,
        dateTime: DateTime.fromMillisecondsSinceEpoch(map[TIME]));
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DEVICE: device == null ? null : jsonEncode(device.toJson()),
      TIME: time,
      BMI: bmi,
      BODY_FAT: bodyFat,
      BONE_MASS: boneMass,
      DATE_TIME: dateTime.toIso8601String(),
      HEIGHT: height,
      MANUEL: isManuel ? 1 : 0,
      MEASUREMENT_ID: time,
      VISCERAL_FAT: visceralFat,
      MUSCLE: muscle,
      WATER: water,
      WEIGHT: weight ?? 0,
      USER_ID: ProfileRepository().activeProfile.id,
      IMAGE_ONE: images.length >= 1 ? images[0] : null,
      IMAGE_TWO: images.length >= 2 ? images[1] : null,
      IMAGE_THREE: images.length >= 3 ? images[2] : null,
      NOTE: '',
      IS_DELETED: isDeleted ? 1 : 0
    };
  }

  Color _getWeightColor(double weight) {
    double low, target, high;
    var map = weightTarget;
    low = map['low'] ?? 0;
    target = map['target'] ?? 0;
    high = map['high'] ?? 0;

    if (weight != null) {
      if (weight < low) {
        return R.color.very_low;
      } else if (weight >= low && weight < target) {
        return R.color.low;
      } else if (weight >= target && weight < high) {
        return R.color.target;
      } else if (weight >= high) {
        return R.color.high;
      } else {
        return R.color.grey.withOpacity(.2);
      }
    } else {
      return R.color.grey.withOpacity(.2);
    }
  }

  Map<String, double> get weightTarget {
    Map<String, double> map = {};
    if (age > 10 && age < 25) {
      map['low'] = (height * height) / 10000 * 19;
      map['target'] = (height * height) / 10000 * 22;
      map['high'] = (height * height) / 10000 * 24;
    } else if (age > 24 && age < 35) {
      map['low'] = (height * height) / 10000 * 20;
      map['target'] = (height * height) / 10000 * 23;
      map['high'] = (height * height) / 10000 * 25;
    } else if (age > 34 && age < 45) {
      map['low'] = (height * height) / 10000 * 21;
      map['target'] = (height * height) / 10000 * 24;
      map['high'] = (height * height) / 10000 * 26;
    } else if (age > 44 && age < 55) {
      map['low'] = (height * height) / 10000 * 22;
      map['target'] = (height * height) / 10000 * 25;
      map['high'] = (height * height) / 10000 * 27;
    } else if (age > 54 && age < 65) {
      map['low'] = (height * height) / 10000 * 23;
      map['target'] = (height * height) / 10000 * 26;
      map['high'] = (height * height) / 10000 * 28;
    } else if (age > 65) {
      map['low'] = (height * height) / 10000 * 24;
      map['target'] = (height * height) / 10000 * 27;
      map['high'] = (height * height) / 10000 * 29;
    }
    return map;
  }

  Color _getBmiColor(double bmi) {
    if (bmi != null) {
      if (bmi < 19) {
        return R.color.low;
      } else if (bmi >= 19 && bmi < 25) {
        return R.color.target;
      } else if (bmi >= 25 && bmi < 30) {
        return R.color.high;
      } else if (bmi >= 30) {
        return R.color.very_high;
      } else {
        return R.color.grey.withOpacity(.2);
      }
    } else {
      return R.color.grey.withOpacity(.2);
    }
  }

  Color _getBodyFatColor(double bodyFat) {
    double low, target, high;

    Map<String, double> map = bodyFatTarget;
    print(map);
    low = map['low'] ?? 0;
    target = map['target'] ?? 0;
    high = map['high'] ?? 0;

    if (bodyFat != null) {
      if (bodyFat < low) {
        return R.color.very_low;
      } else if (bodyFat >= low && bodyFat < target) {
        return R.color.target;
      } else if (bodyFat >= target && bodyFat < high) {
        return R.color.high;
      } else if (bodyFat >= high) {
        return R.color.very_high;
      } else {
        return R.color.grey.withOpacity(.2);
      }
    } else {
      return R.color.grey.withOpacity(.2);
    }
  }

  ScaleModel copy() {
    return ScaleModel.fromMap(jsonDecode(jsonEncode(this.toMap())));
  }

  Map<String, double> get bodyFatTarget {
    Map<String, double> map = {};
    if (age > 10 && age < 18) {
      map['low'] = 16;
      map['target'] = 30;
      map['high'] = 35;
    } else if (age == 19) {
      map['low'] = 18;
      map['target'] = 31;
      map['high'] = 36;
    } else if (age >= 20 && age < 40) {
      map['low'] = 20;
      map['target'] = 32;
      map['high'] = 38;
    } else if (age >= 40 && age < 60) {
      map['low'] = 22;
      map['target'] = 33;
      map['high'] = 39;
    } else if (age >= 60) {
      map['low'] = 23;
      map['target'] = 35;
      map['high'] = 41;
    }
    return map;
  }

  Color _getBoneMassColor(double boneMass) {
    if (weight != null) {
      if (gender == 0 &&
          ((weight <= 65 && boneMass == 2.65) ||
              ((weight <= 65 && weight >= 95) && boneMass == 3.29) ||
              ((weight > 95) && boneMass == 3.69))) {
        return R.color.target;
      } else if (((weight <= 50 && boneMass == 1.95) ||
          ((weight <= 50 && weight >= 75) && boneMass == 2.40) ||
          ((weight > 76) && boneMass == 2.95))) {
        return R.color.target;
      }
    }
    return R.color.grey.withOpacity(.2);
  }

  Color _getWaterColor(double water) {
    if (water != null) {
      if (gender == 0) {
        if (water < 51) {
          return R.color.very_low;
        } else if (water < 66) {
          return R.color.target;
        } else if (water > 65) {
          return R.color.very_high;
        } else {
          return R.color.grey.withOpacity(.2);
        }
      } else {
        if (water < 46) {
          return R.color.very_low;
        } else if (water < 61) {
          return R.color.target;
        } else if (water > 60) {
          return R.color.very_high;
        } else {
          return R.color.grey.withOpacity(.2);
        }
      }
    } else {
      return R.color.grey.withOpacity(.2);
    }
  }

  Color _getVisceralFatColor(double visceralFat) {
    if (visceralFat != null) {
      if (visceralFat > 0 && visceralFat <= 10) {
        return R.color.target;
      } else if (visceralFat > 10) {
        return R.color.very_high;
      } else {
        return R.color.grey.withOpacity(.2);
      }
    } else {
      return R.color.grey.withOpacity(.2);
    }
  }

  Color _getMuscleColor(double muscle) {
    if (muscle != null) {
      return R.color.target;
    } else {
      return R.color.grey.withOpacity(.2);
    }
  }

  double getBMH() {
    if (gender == 0) {
      return 66.5 + (13.75 * weight) + (5.03 * height) - (6.75 * age);
    } else {
      return 655.1 + (9.56 * weight) + (1.85 * height) - (4.68 * age);
    }
  }
}
