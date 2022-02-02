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
  String get xRawValue => GetEnumValue(this);

  ITheme get xGetTheme {
    switch (this) {
      case ThemeType.green:
        return GreenTheme();

      case ThemeType.burgundy:
        return BurgundyTheme();

      default:
        return GreenTheme();
    }
  }
}
