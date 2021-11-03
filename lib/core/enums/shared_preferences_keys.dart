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
  DELETED_WIDGETS,
  WIDGET_QUERY
}

extension SharedPreferencesKeysStringExt on String {
  SharedPreferencesKeys get xSharedKeys => SharedPreferencesKeys.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension SharedPreferencesKeysExt on SharedPreferencesKeys {
  String get xRawValue => GetEnumValue(this);
}
