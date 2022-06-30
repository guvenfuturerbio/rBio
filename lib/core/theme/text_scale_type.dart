import 'package:collection/collection.dart';

import '../core.dart';

enum TextScaleType {
  small,
  medium,
  large,
}

extension TextScaleTypeExtensions on TextScaleType {
  TextScaleType getNextType() {
    switch (this) {
      case TextScaleType.small:
        return TextScaleType.medium;

      case TextScaleType.medium:
        return TextScaleType.large;

      case TextScaleType.large:
        return TextScaleType.small;

      default:
        return TextScaleType.medium;
    }
  }

  double getValue() {
    switch (this) {
      case TextScaleType.small:
        return 1.0;

      case TextScaleType.medium:
        return 1.5;

      case TextScaleType.large:
        return 2.0;

      default:
        return 1.0;
    }
  }

  String get xRawValue => Utils.instance.getEnumValue(this);
}

extension TextScaleTypeStringExt on String {
  TextScaleType? get xTextScaleKeys => TextScaleType.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}
