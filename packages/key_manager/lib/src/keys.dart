import 'package:collection/collection.dart';

enum Keys {
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
  devApiTest,
  doctorClientId,
  doctorClientSecret,
}

extension KeysStringExt on String {
  Keys? get xSecretKeys =>
      Keys.values.firstWhereOrNull((element) => element.xRawValue == this);
}

extension SecretKeysExt on Keys {
  String get xRawValue => name;
}
