import 'package:collection/collection.dart';

import '../core.dart';

enum ThemeType {
  Green,
}

extension ThemeTypeStringExt on String {
  ThemeType get xTheme =>
      ThemeType.values.firstWhereOrNull((element) => element.xRawValue == this);
}

extension ThemeTypeExt on ThemeType {
  String get xRawValue => GetEnumValue(this);

  ITheme get xGetTheme {
    switch (this) {
      case ThemeType.Green:
        return GreenTheme();

      default:
        return GreenTheme();
    }
  }
}
