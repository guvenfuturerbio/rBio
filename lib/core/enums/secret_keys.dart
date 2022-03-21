import 'package:collection/collection.dart';

import '../core.dart';

enum SecretKeys {
  baseUrl,
  apiGuven,
  prodApiTest,
  devApiTest,
  doctorBaseUrl,

  clientId,
  clientSecret,
  mockAppointment,
  dev4Guven,
  sentryDsn,
  symtonCheckerLogin,
  symtomRequestLogin,
  doctorClientId,
  doctorClientSecret,
}

extension SecretKeysStringExt on String {
  SecretKeys? get xSecretKeys => SecretKeys.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension SecretKeysExt on SecretKeys {
  String get xRawValue => getEnumValue(this);
}
