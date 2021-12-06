import '../../../../../generated/l10n.dart';

enum ScaleMarginsFilter { VERY_LOW, LOW, TARGET, HIGH, VERY_HIGH, OTHER }

extension ScaleMarginsFilterExtension on ScaleMarginsFilter {
  String toShortString() {
    switch (this) {
      case ScaleMarginsFilter.VERY_LOW:
        return LocaleProvider.current.very_low;
        break;
      case ScaleMarginsFilter.LOW:
        return LocaleProvider.current.low;
        break;
      case ScaleMarginsFilter.TARGET:
        return LocaleProvider.current.target;
        break;
      case ScaleMarginsFilter.HIGH:
        return LocaleProvider.current.high;
        break;
      case ScaleMarginsFilter.OTHER:
        return LocaleProvider.current.other;
        break;
      case ScaleMarginsFilter.VERY_HIGH:
        return LocaleProvider.current.very_high;
        break;
    }
  }
}
