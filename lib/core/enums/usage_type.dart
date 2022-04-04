import 'package:collection/collection.dart';

import '../core.dart';

enum UsageType {
  hungry,
  full,
}

extension UsageTypeExtension on UsageType {
  String get xRawValue => getEnumValue(this);

  String toShortString() {
    switch (this) {
      case UsageType.hungry:
        return LocaleProvider.current.before_meal;

      case UsageType.full:
        return LocaleProvider.current.after_meal;

      default:
        return '';
    }
  }
}

extension UsageTypeNullExtension on UsageType? {
  String get xGetText {
    if (this == null) return '';

    switch (this) {
      case UsageType.hungry:
        return LocaleProvider.current.hungry;

      case UsageType.full:
        return LocaleProvider.current.full;

      default:
        return '';
    }
  }
}

extension UsageTypeKeysStringExt on String {
  UsageType? get xUsageTypeKeys =>
      UsageType.values.firstWhereOrNull((element) => element.xRawValue == this);
}
