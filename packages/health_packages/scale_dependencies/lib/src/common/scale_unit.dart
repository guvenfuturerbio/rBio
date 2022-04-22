enum ScaleUnit {
  kg,
  lbs,
}

extension ScaleUnitIntExtension on int? {
  ScaleUnit get xToScaleUnit {
    switch (this) {
      case 1:
        return ScaleUnit.kg;

      case 2:
        return ScaleUnit.lbs;

      default:
        throw Exception("Undefined ${this}");
    }
  }
}

extension ScaleToInt on ScaleUnit? {
  int get xScaleToInt {
    switch (this) {
      case ScaleUnit.kg:
        return 1;

      case ScaleUnit.lbs:
        return 2;

      default:
        throw Exception("Undefined ${this}");
    }
  }
}

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
