import '../../../../core/core.dart';

enum StripMode {
  add,
  subtract,
  none,
}

extension StripModeExtension on StripMode {
  String get xGetTitle {
    switch (this) {
      case StripMode.add:
        return LocaleProvider.current.add_strips;

      case StripMode.subtract:
        return LocaleProvider.current.remove_strips;

      case StripMode.none:
      default:
        return "";
    }
  }
}
