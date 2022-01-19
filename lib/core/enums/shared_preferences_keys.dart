import 'package:collection/collection.dart';

import '../core.dart';

enum SharedPreferencesKeys {
  UPDATE_DIALOG,
  SELECTED_LOCALE,
  DID_COMPLETE_SURVEY,
  LOGIN_USERNAME,
  LOGIN_PASSWORD,
  PROFILE_IMAGE,
  APPLICATION_CONSENT_FORM,
  JWT_TOKEN,
  PATIENT,
  USERACCOUNT,
  CANACCESSHOSPITALOPS,
  THEME,
  TEXT_SCALE,
  SYMPTOM_AUTH_TOKEN,
  PAIRED_DEVICES,
  CHAT_NOTIFICATION,
  ALL_USERS, // Home Widget List Tutuyor

  hba1cList,
  medicines,
  usedStripCount,
}

extension SharedPreferencesKeysStringExt on String {
  SharedPreferencesKeys get xSharedKeys => SharedPreferencesKeys.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension SharedPreferencesKeysExt on SharedPreferencesKeys {
  String get xRawValue => GetEnumValue(this);
}
