import 'package:flutter/material.dart';
import 'package:scale_api/scale_api.dart';

class ScaleColors {
  ScaleColors._();

  static ScaleColors? _instance;

  static ScaleColors get instance {
    _instance ??= ScaleColors._();
    return _instance!;
  }

  final _colorGrey = const Color(0xFF696969);
  final _colorVeryHigh = const Color(0xFFf4bb44);
  final _colorHigh = const Color(0xFFf7ec57);
  final _colorTarget = const Color(0xFF66c791);
  final _colorLow = const Color(0xFFe98884);
  final _colorVeryLow = const Color(0xFFe2605b);

  Color getColor({
    required SelectedScaleType type,
    required double? bmi,
    required double? weight,
    required double? bodyFat,
    required double? boneMass,
    required double? water,
    required double? visceralFat,
    required double? muscle,
    required int? gender,
    required Map<String, double> weightTarget,
    required Map<String, double> bodyFatTarget,
  }) =>
      _getColor(
        type: type,
        bmi: bmi,
        weight: weight,
        bodyFat: bodyFat,
        boneMass: boneMass,
        water: water,
        visceralFat: visceralFat,
        muscle: muscle,
        gender: gender,
        weightTarget: weightTarget,
        bodyFatTarget: bodyFatTarget,
      );

  Color _getColor({
    required SelectedScaleType type,
    required double? bmi,
    required double? weight,
    required double? bodyFat,
    required double? boneMass,
    required double? water,
    required double? visceralFat,
    required double? muscle,
    required int? gender,
    required Map<String, double> weightTarget,
    required Map<String, double> bodyFatTarget,
  }) {
    switch (type) {
      case SelectedScaleType.bmi:
        return _getBmiColor(bmi);

      case SelectedScaleType.weight:
        return _getWeightColor(weight, weightTarget);

      case SelectedScaleType.bodyFat:
        return _getBodyFatColor(bodyFat, bodyFatTarget);

      case SelectedScaleType.boneMass:
        return _getBoneMassColor(boneMass, weight, gender);

      case SelectedScaleType.water:
        return _getWaterColor(water, gender);

      case SelectedScaleType.visceralFat:
        return _getVisceralFatColor(visceralFat);

      case SelectedScaleType.muscle:
        return _getMuscleColor(muscle);

      default:
        return _colorGrey.withOpacity(.2);
    }
  }

  Color _getWeightColor(double? weight, Map<String, dynamic> weightTarget) {
    double low, target, high;
    var map = weightTarget;
    low = map['low'] ?? 0;
    target = map['target'] ?? 0;
    high = map['high'] ?? 0;

    if (weight != null) {
      if (weight < low) {
        return _colorVeryLow;
      } else if (weight >= low && weight < target) {
        return _colorLow;
      } else if (weight >= target && weight < high) {
        return _colorTarget;
      } else if (weight >= high) {
        return _colorHigh;
      } else {
        return _colorGrey.withOpacity(.2);
      }
    } else {
      return _colorGrey.withOpacity(.2);
    }
  }

  Color _getBmiColor(double? bmi) {
    if (bmi != null) {
      if (bmi < 19) {
        return _colorLow;
      } else if (bmi >= 19 && bmi < 25) {
        return _colorTarget;
      } else if (bmi >= 25 && bmi < 30) {
        return _colorHigh;
      } else if (bmi >= 30) {
        return _colorVeryHigh;
      } else {
        return _colorGrey.withOpacity(.2);
      }
    } else {
      return _colorGrey.withOpacity(.2);
    }
  }

  Color _getBodyFatColor(double? bodyFat, Map<String, double> bodyFatTarget) {
    double low, target, high;

    final map = bodyFatTarget;
    low = map['low'] ?? 0;
    target = map['target'] ?? 0;
    high = map['high'] ?? 0;

    if (bodyFat != null) {
      if (bodyFat < low) {
        return _colorVeryLow;
      } else if (bodyFat >= low && bodyFat < target) {
        return _colorTarget;
      } else if (bodyFat >= target && bodyFat < high) {
        return _colorHigh;
      } else if (bodyFat >= high) {
        return _colorVeryHigh;
      } else {
        return _colorGrey.withOpacity(.2);
      }
    } else {
      return _colorGrey.withOpacity(.2);
    }
  }

  Color _getBoneMassColor(
    double? boneMass,
    double? weight,
    int? gender,
  ) {
    if (weight != null && boneMass != null) {
      if (gender == 0 &&
          ((weight <= 65 && boneMass == 2.65) ||
              ((weight <= 65 && weight >= 95) && boneMass == 3.29) ||
              ((weight > 95) && boneMass == 3.69))) {
        return _colorTarget;
      } else if (((weight <= 50 && boneMass == 1.95) ||
          ((weight <= 50 && weight >= 75) && boneMass == 2.40) ||
          ((weight > 76) && boneMass == 2.95))) {
        return _colorTarget;
      }
    }

    return _colorGrey.withOpacity(.2);
  }

  Color _getWaterColor(
    double? water,
    int? gender,
  ) {
    if (water != null) {
      if (gender == 0) {
        if (water < 51) {
          return _colorVeryLow;
        } else if (water < 66) {
          return _colorTarget;
        } else if (water > 65) {
          return _colorVeryHigh;
        } else {
          return _colorGrey.withOpacity(.2);
        }
      } else {
        if (water < 46) {
          return _colorVeryLow;
        } else if (water < 61) {
          return _colorTarget;
        } else if (water > 60) {
          return _colorVeryHigh;
        } else {
          return _colorGrey.withOpacity(.2);
        }
      }
    } else {
      return _colorGrey.withOpacity(.2);
    }
  }

  Color _getVisceralFatColor(double? visceralFat) {
    if (visceralFat != null) {
      if (visceralFat > 0 && visceralFat <= 10) {
        return _colorTarget;
      } else if (visceralFat > 10) {
        return _colorVeryHigh;
      } else {
        return _colorGrey.withOpacity(.2);
      }
    } else {
      return _colorGrey.withOpacity(.2);
    }
  }

  Color _getMuscleColor(double? muscle) {
    if (muscle != null) {
      return _colorTarget;
    } else {
      return _colorGrey.withOpacity(.2);
    }
  }
}

extension SelectedScaleTypeRangeExt on SelectedScaleType {
  List<double> xGetRanges() {
    switch (this) {
      case SelectedScaleType.bmi:
        // TODO: Handle this case.
        break;
      case SelectedScaleType.weight:
        // TODO: Handle this case.
        break;
      case SelectedScaleType.bodyFat:
        // TODO: Handle this case.
        break;
      case SelectedScaleType.boneMass:
        // TODO: Handle this case.
        break;
      case SelectedScaleType.water:
        // TODO: Handle this case.
        break;
      case SelectedScaleType.visceralFat:
        // TODO: Handle this case.
        break;
      case SelectedScaleType.muscle:
        // TODO: Handle this case.
        break;
    }

    return [];
  }
}
