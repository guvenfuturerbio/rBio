enum Environment {
  DEV,
  STAGING,
  PROD,
}

extension EnvironmentExtension on Environment {
  String get xFileName {
    switch (this) {
      case Environment.DEV:
        return 'env/.dev.env';
      case Environment.PROD:
        return 'env/.prod.env';
      case Environment.STAGING:
        return 'env/.staging.env';
      default:
        return 'env/.prod.env';
    }
  }
}
