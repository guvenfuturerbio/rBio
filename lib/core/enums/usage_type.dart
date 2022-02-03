import '../core.dart';

enum UsageType {
  hungry,
  full,
  irrelevant,
}

extension UserTypeExtension on UsageType {
  String xToString() {
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
