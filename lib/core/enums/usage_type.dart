import 'package:onedosehealth/core/core.dart';

enum UsageType {
  HUNGRY,
  FULL,
  IRRELEVANT,
}

extension UserTypeExtension on UsageType {
  String xToString() {
    switch (this) {
      case UsageType.HUNGRY:
        return LocaleProvider.current.hungry;

      case UsageType.FULL:
        return LocaleProvider.current.full;

      case UsageType.IRRELEVANT:
        return LocaleProvider.current.irrelevant;

      default:
        return '';
    }
  }
}
