import 'package:collection/collection.dart';

import '../core.dart';

enum SecretKeys {
  SSO_URL,
  BASE_URL,
  CLIENT_ID,
  CLIENT_SECRET,
  MOCK_APPOINTMENT,
  DEV_4_GUVEN,
  SENTRY_DSN,
  SYMPTOM_CHECKER_LOGIN,
  SYMPTOM_REQUEST_URL
}

extension SecretKeysStringExt on String {
  SecretKeys get xSecretKeys => SecretKeys.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension SecretKeysExt on SecretKeys {
  String get xRawValue => GetEnumValue(this);
}
