import 'dart:ui';

import '../../../../../core/core.dart';
import '../../../../../core/enums/selected_scale_type.dart';

class ScaleMeasurementViewModel {
  final ScaleModel scaleModel;
  ScaleMeasurementViewModel({required this.scaleModel});

  bool? get isDeleted => scaleModel.isDeleted;

  int? get id => scaleModel.time;

  bool get isManuel => scaleModel.isManuel ?? false;

  int? get measurementId => scaleModel.measurementId;

  double? get weight => scaleModel.weight;

  set weight(rhs) => scaleModel.weight = rhs;

  set time(rhs) => scaleModel.time = rhs;

  get time => scaleModel.time;

  int? get age => scaleModel.age;

  set age(int? rhs) => scaleModel.age = (DateTime.now().year - (rhs ?? 0));

  int? get height => scaleModel.height;

  int? get gender => scaleModel.gender;

  double? get bmi => scaleModel.bmi;

  set bmi(double? rhs) => scaleModel.bmi = rhs;

  double? get bodyFat => scaleModel.bodyFat;

  set bodyFat(double? rhs) => scaleModel.bodyFat = rhs;

  double? get boneMass => scaleModel.boneMass;

  set boneMass(double? rhs) => scaleModel.boneMass = rhs;

  double? get water => scaleModel.water;

  set water(double? rhs) => scaleModel.water = rhs;

  double? get visceralFat => scaleModel.visceralFat;

  set visceralFat(double? rhs) => scaleModel.visceralFat = rhs;

  double? get muscle => scaleModel.muscle;

  set muscle(double? rhs) => scaleModel.muscle = rhs;

  double? get bmh => scaleModel.bmh;

  set bmh(double? rhs) => scaleModel.bmh = rhs;

  List<String> get images => scaleModel.images ?? [];
  set images(List<String> rhs) => scaleModel.images = rhs;

  DateTime get dateTime => scaleModel.dateTime;

  set dateTime(rhs) => scaleModel.dateTime = rhs;

  String get note => scaleModel.note ?? '';

  set note(String rhs) => scaleModel.note = rhs;

  double? getMeasurement(SelectedScaleType type) =>
      _getReleatedMeasurement(type);

  Color getColor(SelectedScaleType type) => _getColor(type);

  List<String> get imageUrl => scaleModel.images ?? [];

  ScaleUnit get unit => scaleModel.unit ?? ScaleUnit.kg;

  int? minRange(SelectedScaleType selected) => getTargetMin(selected);
  int? maxRange(SelectedScaleType selected) => getTargetMax(selected);

  int? getTargetMin(SelectedScaleType type) {
    switch (type) {
      case SelectedScaleType.bmi:
        return _getBmiRange['min'];

      case SelectedScaleType.weight:
        return _getWeightRange['min'];

      case SelectedScaleType.bodyFat:
        return _getBodyFatRange['min'];

      case SelectedScaleType.boneMass:
        return _getBoneMassRange['min'];

      case SelectedScaleType.water:
        return _getWaterRange['min'];

      case SelectedScaleType.visceralFat:
        return _getVisceralFatRange['min'];

      case SelectedScaleType.muscle:
        return _getMuscleRange['min'];

      default:
        return 0;
    }
  }

  Map<String, int> get _getBmiRange {
    var range = {'min': 19, 'max': 25};
    return range;
  }

  Map<String, int> get _getWeightRange {
    var range = {
      'min': (weightTarget['target'] ?? 0).toInt(),
      'max': (weightTarget['high'] ?? 1 - 1).toInt(),
    };

    return range;
  }

  Map<String, int> get _getBodyFatRange {
    var range = {
      'min': (bodyFatTarget['target'] ?? 0).toInt(),
      'max': (bodyFatTarget['high'] ?? 1 - 1).toInt(),
    };

    return range;
  }

  /// BoneMass için bir aralık söz konusu olmadığı için plotband uygulanamaz!!!
  Map<String, int> get _getBoneMassRange {
    return {'min': 0, 'max': 0};
  }

  Map<String, int> get _getWaterRange {
    var range = {'min': 0, 'max': 0};
    if (scaleModel.water != null && scaleModel.gender == 0) {
      range = {'min': 51, 'max': 65};
    } else if (scaleModel.water != null && scaleModel.gender == 1) {
      range = {'min': 46, 'max': 60};
    }
    return range;
  }

  Map<String, int> get _getVisceralFatRange {
    var range = {'min': 0, 'max': 0};
    if (scaleModel.visceralFat != null) {
      range = {'min': 0, 'max': 10};
    }
    return range;
  }

  Map<String, int> get _getMuscleRange {
    return {'min': 0, 'max': 0};
  }

  int? getTargetMax(SelectedScaleType type) {
    switch (type) {
      case SelectedScaleType.bmi:
        return _getBmiRange['max'];
      case SelectedScaleType.weight:
        return _getWeightRange['max'];
      case SelectedScaleType.bodyFat:
        return _getBodyFatRange['max'];
      case SelectedScaleType.boneMass:
        return _getBoneMassRange['max'];
      case SelectedScaleType.water:
        return _getWaterRange['max'];
      case SelectedScaleType.visceralFat:
        return _getVisceralFatRange['max'];
      case SelectedScaleType.muscle:
        return _getMuscleRange['max'];
      default:
        return 0;
    }
  }

  Color _getWeightColor(double? weight) {
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
    if (age! > 10 && age! < 25) {
      map['low'] = (height! * height!) / 10000 * 19;
      map['target'] = (height! * height!) / 10000 * 22;
      map['high'] = (height! * height!) / 10000 * 24;
    } else if (age! > 24 && age! < 35) {
      map['low'] = (height! * height!) / 10000 * 20;
      map['target'] = (height! * height!) / 10000 * 23;
      map['high'] = (height! * height!) / 10000 * 25;
    } else if (age! > 34 && age! < 45) {
      map['low'] = (height! * height!) / 10000 * 21;
      map['target'] = (height! * height!) / 10000 * 24;
      map['high'] = (height! * height!) / 10000 * 26;
    } else if (age! > 44 && age! < 55) {
      map['low'] = (height! * height!) / 10000 * 22;
      map['target'] = (height! * height!) / 10000 * 25;
      map['high'] = (height! * height!) / 10000 * 27;
    } else if (age! > 54 && age! < 65) {
      map['low'] = (height! * height!) / 10000 * 23;
      map['target'] = (height! * height!) / 10000 * 26;
      map['high'] = (height! * height!) / 10000 * 28;
    } else if (age! > 65) {
      map['low'] = (height! * height!) / 10000 * 24;
      map['target'] = (height! * height!) / 10000 * 27;
      map['high'] = (height! * height!) / 10000 * 29;
    }
    return map;
  }

  Color _getBmiColor(double? bmi) {
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

  Color _getBodyFatColor(double? bodyFat) {
    double low, target, high;

    Map<String, double> map = bodyFatTarget;
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

  Map<String, double> get bodyFatTarget {
    Map<String, double> map = {};
    if (age! > 10 && age! < 18) {
      map['low'] = 16;
      map['target'] = 30;
      map['high'] = 35;
    } else if (age! == 19) {
      map['low'] = 18;
      map['target'] = 31;
      map['high'] = 36;
    } else if (age! >= 20 && age! < 40) {
      map['low'] = 20;
      map['target'] = 32;
      map['high'] = 38;
    } else if (age! >= 40 && age! < 60) {
      map['low'] = 22;
      map['target'] = 33;
      map['high'] = 39;
    } else if (age! >= 60) {
      map['low'] = 23;
      map['target'] = 35;
      map['high'] = 41;
    }
    return map;
  }

  Color _getBoneMassColor(double? boneMass) {
    if (weight != null && boneMass != null) {
      if (gender == 0 &&
          ((weight! <= 65 && boneMass == 2.65) ||
              ((weight! <= 65 && weight! >= 95) && boneMass == 3.29) ||
              ((weight! > 95) && boneMass == 3.69))) {
        return R.color.target;
      } else if (((weight! <= 50 && boneMass == 1.95) ||
          ((weight! <= 50 && weight! >= 75) && boneMass == 2.40) ||
          ((weight! > 76) && boneMass == 2.95))) {
        return R.color.target;
      }
    }
    return R.color.grey.withOpacity(.2);
  }

  Color _getWaterColor(double? water) {
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

  Color _getVisceralFatColor(double? visceralFat) {
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

  Color _getMuscleColor(double? muscle) {
    if (muscle != null) {
      return R.color.target;
    } else {
      return R.color.grey.withOpacity(.2);
    }
  }

  Color _getColor(SelectedScaleType type) {
    switch (type) {
      case SelectedScaleType.bmi:
        return _getBmiColor(bmi);
      case SelectedScaleType.weight:
        return _getWeightColor(weight);
      case SelectedScaleType.bodyFat:
        return _getBodyFatColor(bodyFat);
      case SelectedScaleType.boneMass:
        return _getBoneMassColor(boneMass);
      case SelectedScaleType.water:
        return _getWaterColor(water);
      case SelectedScaleType.visceralFat:
        return _getVisceralFatColor(visceralFat);
      case SelectedScaleType.muscle:
        return _getMuscleColor(muscle);
      default:
        return R.color.grey.withOpacity(.2);
    }
  }

  double? _getReleatedMeasurement(SelectedScaleType type) {
    switch (type) {
      case SelectedScaleType.bmi:
        return bmi;

      case SelectedScaleType.weight:
        return weight;

      case SelectedScaleType.bodyFat:
        return bodyFat;

      case SelectedScaleType.boneMass:
        return boneMass;

      case SelectedScaleType.water:
        return water;

      case SelectedScaleType.visceralFat:
        return visceralFat;

      case SelectedScaleType.muscle:
        return muscle;

      default:
        throw Exception('No related value as $type');
    }
  }

  void calculateVariables() {
    bmi = getBMI();
    bmh = getBMH();
    time = dateTime.millisecondsSinceEpoch;
    if (!isManuel) {
      visceralFat = getVisceralFat();
      if (scaleModel.impedance != null) {
        water = getWater();
        muscle = getMuscle();
        bodyFat = getBodyFat();
        boneMass = getBoneMass();
      }
    }
  }

  double getBMI() => weight! / (((height! * height!) / 100.0) / 100.0);

  double getWater() {
    double coeff;
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
    if (gender == 0 && age! <= 49) {
      lbmSub = 9.25;
    } else if (gender == 0 && age! > 49) {
      lbmSub = 7.25;
    }
    double lbmCoeff = getLBMCoefficient();
    double coeff = 1.0;
    if (gender == 1 && weight! < 61.0) {
      coeff = 0.98;
    } else if (gender == 0 && weight! > 60.0) {
      coeff = 0.96;

      if (height! > 160) {
        coeff *= 1.03;
      }
    } else if (gender == 0 && weight! < 50.0) {
      coeff = 1.02;

      if (height! > 160) {
        coeff *= 1.03;
      }
    }

    bodyFat = (1.0 - (((lbmCoeff - lbmSub) * coeff) / weight!)) * 100.0;

    if (bodyFat > 63.0) {
      bodyFat = 75.0;
    }

    return bodyFat;
  }

  double getLBMCoefficient() {
    double lbm = (height! * 9.058 / 100.0) * (height! / 100.0);
    lbm += weight! * 0.32 + 12.226;
    lbm -= scaleModel.impedance! * 0.0068;
    lbm -= age! * 0.0542;

    return lbm;
  }

  double getVisceralFat() {
    double visceralFat = 0.0;
    if (gender == 0) {
      if (weight! > (13.0 - (height! * 0.5)) * -1.0) {
        double subsubcalc =
            ((height! * 1.45) + (height! * 0.1158) * height!) - 120.0;
        double subcalc = weight! * 500.0 / subsubcalc;
        visceralFat = (subcalc - 6.0) + (age! * 0.07);
      } else {
        double subcalc = 0.691 + (height! * -0.0024) + (height! * -0.0024);
        visceralFat = (((height! * 0.027) - (subcalc * weight!)) * -1.0) +
            (age! * 0.07) -
            age!;
      }
    } else {
      if (height! < weight! * 1.6) {
        double subcalc =
            ((height! * 0.4) - (height! * (height! * 0.0826))) * -1.0;
        visceralFat =
            ((weight! * 305.0) / (subcalc + 48.0)) - 2.9 + (age! * 0.15);
      } else {
        double subcalc = 0.765 + height! * -0.0015;
        visceralFat = (((height! * 0.143) - (weight! * subcalc)) * -1.0) +
            (age! * 0.15) -
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
        weight! - ((getBodyFat() * 0.01) * weight!) - getBoneMass();

    if (gender == 0 && muscleMass >= 84.0) {
      muscleMass = 120.0;
    } else if (gender == 1 && muscleMass >= 93.5) {
      muscleMass = 120.0;
    }

    return muscleMass;
  }

  double getBMH() {
    if (gender == 0) {
      return 66.5 + (13.75 * weight!) + (5.03 * height!) - (6.75 * age!);
    } else {
      return 655.1 + (9.56 * weight!) + (1.85 * height!) - (4.68 * age!);
    }
  }

  addImage(String path) {
    images.add(path);
  }
}
