import 'package:collection/src/iterable_extensions.dart';

import '../core.dart';

enum TextScaleType {
  Small,
  Medium,
  Large,
}

extension TextScaleTypeExtensions on TextScaleType {
  TextScaleType getNextType() {
    switch (this) {
      case TextScaleType.Small:
        return TextScaleType.Medium;

      case TextScaleType.Medium:
        return TextScaleType.Large;

      case TextScaleType.Large:
        return TextScaleType.Small;

      default:
        return TextScaleType.Medium;
    }
  }

  double getValue() {
    switch (this) {
      case TextScaleType.Small:
        return 1.0;

      case TextScaleType.Medium:
        return 1.5;

      case TextScaleType.Large:
        return 2.0;

      default:
        return 1.0;
    }
  }

  String get xRawValue => GetEnumValue(this);
}

extension TextScaleTypeStringExt on String {
  TextScaleType get xTextScaleKeys => TextScaleType.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}
