import 'package:collection/collection.dart';

import '../core.dart';

enum SharedPreferencesKeys {
  UPDATE_DIALOG,
  SELECTED_LOCALE,
  DID_COMPLETE_SURVEY,
  LOGIN_USERNAME,
  LOGIN_PASSWORD,
  APPLICATION_CONSENT_FORM,
  JWT_TOKEN,
  PATIENT,
  USERACCOUNT,
  CANACCESSHOSPITALOPS,
}

extension SharedPreferencesKeysStringExt on String {
  SharedPreferencesKeys get xSharedKeys => SharedPreferencesKeys.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension SharedPreferencesKeysExt on SharedPreferencesKeys {
  String get xRawValue => GetEnumValue(this);
}
