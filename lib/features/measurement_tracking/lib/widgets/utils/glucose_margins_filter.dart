import 'package:onedosehealth/generated/l10n.dart';

enum GlucoseMarginsFilter {
  VERY_LOW,
  LOW,
  TARGET,
  HIGH,
  VERY_HIGH,
  HUNGRY,
  FULL,
  OTHER
}

extension GlucoseMarginsFilterExtension on GlucoseMarginsFilter {
  String toShortString() {
    switch (this) {
      case GlucoseMarginsFilter.VERY_LOW:
        return LocaleProvider.current.very_low;
        break;
      case GlucoseMarginsFilter.LOW:
        return LocaleProvider.current.low;
        break;
      case GlucoseMarginsFilter.TARGET:
        return LocaleProvider.current.target;
        break;
      case GlucoseMarginsFilter.HIGH:
        return LocaleProvider.current.high;
        break;
      case GlucoseMarginsFilter.VERY_HIGH:
        return LocaleProvider.current.very_high;
        break;
      case GlucoseMarginsFilter.HUNGRY:
        return LocaleProvider.current.hungry;
        break;
      case GlucoseMarginsFilter.FULL:
        return LocaleProvider.current.full;
        break;
      case GlucoseMarginsFilter.OTHER:
        return LocaleProvider.current.other;
        break;
    }
  }
}
