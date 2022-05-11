import '../core.dart';

enum ScaleMarginsFilter {
  veryLow,
  low,
  target,
  high,
  veryHigh,
  other,
}

extension ScaleMarginsFilterExtension on ScaleMarginsFilter {
  String toShortString() {
    switch (this) {
      case ScaleMarginsFilter.veryLow:
        return LocaleProvider.current.very_low;
      case ScaleMarginsFilter.low:
        return LocaleProvider.current.low;
      case ScaleMarginsFilter.target:
        return LocaleProvider.current.target;
      case ScaleMarginsFilter.high:
        return LocaleProvider.current.high;
      case ScaleMarginsFilter.other:
        return LocaleProvider.current.other;
      case ScaleMarginsFilter.veryHigh:
        return LocaleProvider.current.very_high;
    }
  }
}
