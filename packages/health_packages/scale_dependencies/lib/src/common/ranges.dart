import '../../scale_dependencies.dart';

class ScaleRanges {
  ScaleRanges._();

  static ScaleRanges? _instance;

  static ScaleRanges get instance {
    _instance ??= ScaleRanges._();
    return _instance!;
  }

  int? getTargetMax({
    required SelectedScaleType type,
    required int? age,
    required int? height,
    required double? water,
    required int? gender,
    required double? visceralFat,
  }) {
    switch (type) {
      case SelectedScaleType.bmi:
        return _getBmiRange()['max'];

      case SelectedScaleType.weight:
        return _getWeightRange(age!, height!)['max'];

      case SelectedScaleType.bodyFat:
        return _getBodyFatRange(age!)['max'];

      case SelectedScaleType.boneMass:
        return _getBoneMassRange()['max'];

      case SelectedScaleType.water:
        return _getWaterRange(water, gender!)['max'];

      case SelectedScaleType.visceralFat:
        return _getVisceralFatRange(visceralFat)['max'];

      case SelectedScaleType.muscle:
        return _getMuscleRange()['max'];

      default:
        return 0;
    }
  }

  int? getTargetMin({
    required SelectedScaleType type,
    required int? age,
    required int? height,
    required double? water,
    required int? gender,
    required double? visceralFat,
  }) {
    switch (type) {
      case SelectedScaleType.bmi:
        return _getBmiRange()['min'];

      case SelectedScaleType.weight:
        return _getWeightRange(age!, height!)['min'];

      case SelectedScaleType.bodyFat:
        return _getBodyFatRange(age!)['min'];

      case SelectedScaleType.boneMass:
        return _getBoneMassRange()['min'];

      case SelectedScaleType.water:
        return _getWaterRange(water, gender!)['min'];

      case SelectedScaleType.visceralFat:
        return _getVisceralFatRange(visceralFat)['min'];

      case SelectedScaleType.muscle:
        return _getMuscleRange()['min'];

      default:
        return 0;
    }
  }

  Map<String, int> _getBmiRange() => {'min': 19, 'max': 25};

  Map<String, int> _getWeightRange(int age, int height) {
    var range = {
      'min': (weightTarget(age, height)['target'] ?? 0).toInt(),
      'max': (weightTarget(age, height)['high'] ?? 1 - 1).toInt(),
    };

    return range;
  }

  Map<String, int> _getBodyFatRange(int age) {
    var range = {
      'min': (bodyFatTarget(age)['target'] ?? 0).toInt(),
      'max': (bodyFatTarget(age)['high'] ?? 1 - 1).toInt(),
    };

    return range;
  }

  /// BoneMass için bir aralık söz konusu olmadığı için plotband uygulanamaz!!!
  Map<String, int> _getBoneMassRange() => {'min': 0, 'max': 0};

  Map<String, int> _getWaterRange(double? water, int gender) {
    var range = {'min': 0, 'max': 0};
    if (water != null && gender == 0) {
      range = {'min': 51, 'max': 65};
    } else if (water != null && gender == 1) {
      range = {'min': 46, 'max': 60};
    }
    return range;
  }

  Map<String, int> _getVisceralFatRange(double? visceralFat) {
    var range = {'min': 0, 'max': 0};
    if (visceralFat != null) {
      range = {'min': 0, 'max': 10};
    }
    return range;
  }

  Map<String, int> _getMuscleRange() => {'min': 0, 'max': 0};

  Map<String, double> weightTarget(int age, int height) {
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

  Map<String, double> bodyFatTarget(int age) {
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
}
