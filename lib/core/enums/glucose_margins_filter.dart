import '../../../../generated/l10n.dart';

enum GlucoseMarginsFilter {
  veryLow,
  low,
  target,
  high,
  veryHigh,
  hungry,
  full,
  other
}

extension GlucoseMarginsFilterExtension on GlucoseMarginsFilter {
  String toShortString() {
    switch (this) {
      case GlucoseMarginsFilter.veryLow:
        return LocaleProvider.current.very_low;
      case GlucoseMarginsFilter.low:
        return LocaleProvider.current.low;
      case GlucoseMarginsFilter.target:
        return LocaleProvider.current.target;
      case GlucoseMarginsFilter.high:
        return LocaleProvider.current.high;
      case GlucoseMarginsFilter.veryHigh:
        return LocaleProvider.current.very_high;
      case GlucoseMarginsFilter.hungry:
        return LocaleProvider.current.hungry;
      case GlucoseMarginsFilter.full:
        return LocaleProvider.current.full;
      case GlucoseMarginsFilter.other:
        return LocaleProvider.current.other;
    }
  }
}
