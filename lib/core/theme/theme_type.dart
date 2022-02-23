import 'package:collection/collection.dart';

import '../core.dart';

enum ThemeType {
  green,
  burgundy,
}

extension ThemeTypeStringExt on String {
  ThemeType? get xTheme =>
      ThemeType.values.firstWhereOrNull((element) => element.xRawValue == this);
}

extension ThemeTypeExt on ThemeType {
  String get xRawValue => getEnumValue(this);

  ITheme get xGetTheme {
    switch (this) {
      case ThemeType.green:
        return RbioTheme();

      case ThemeType.burgundy:
        return GuvenTheme();

      default:
        return RbioTheme();
    }
  }
}
