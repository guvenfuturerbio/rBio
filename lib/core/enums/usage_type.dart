import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../core.dart';

enum UsageType {
  hungry,
  full,
  irrelevant,
}

extension UsageTypeExtension on UsageType {
  String get xRawValue => getEnumValue(this);

  String xToString() {
    switch (this) {
      case UsageType.hungry:
        return LocaleProvider.current.before_meal;

      case UsageType.full:
        return LocaleProvider.current.after_meal;

      case UsageType.irrelevant:
        return LocaleProvider.current.other;

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

      case UsageType.irrelevant:
        return LocaleProvider.current.irrelevant;

      default:
        return '';
    }
  }
}

extension UsageTypeKeysStringExt on String {
  UsageType? get xUsageTypeKeys =>
      UsageType.values.firstWhereOrNull((element) => element.xRawValue == this);
}
