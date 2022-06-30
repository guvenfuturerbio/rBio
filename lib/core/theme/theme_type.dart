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
  String get xRawValue => Utils.instance.getEnumValue(this);

  IAppTheme get xGetTheme {
    switch (this) {
      case ThemeType.green:
        return OneDoseTheme();

      case ThemeType.burgundy:
        return GuvenTheme();

      default:
        return OneDoseTheme();
    }
  }
}
