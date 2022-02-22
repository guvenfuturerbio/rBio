enum Environment {
  dev,
  staging,
  prod,
}

extension EnvironmentExtension on Environment {
  String get xFileName {
    switch (this) {
      case Environment.dev:
        return 'env/.dev.env';
      case Environment.prod:
        return 'env/.prod.env';
      case Environment.staging:
        return 'env/.staging.env';
      default:
        return 'env/.prod.env';
    }
  }
}
