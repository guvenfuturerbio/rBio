import 'package:collection/collection.dart';

import '../core.dart';

enum SecretKeys {
  baseUrl,
  clientId,
  clientSecret,
  mockAppointment,
  dev4Guven,
  sentryDsn,
  symtonCheckerLogin,
  symtomRequestLogin,
  chronicTrackingBaseUrl,
  doctorBaseUrl,
  doctorClientId,
  doctorClientSecret,
}

extension SecretKeysStringExt on String {
  SecretKeys? get xSecretKeys => SecretKeys.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension SecretKeysExt on SecretKeys {
  String get xRawValue => GetEnumValue(this);
}
