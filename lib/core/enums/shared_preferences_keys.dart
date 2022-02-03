import 'package:collection/collection.dart';

import '../core.dart';

enum SharedPreferencesKeys {
  updateDialog,
  selectedLocale,
  didCompleteSurvey,
  loginUserName,
  loginPassword,
  profileImage,
  applicationConsentForm,
  jwtToken,
  patient,
  userAccount,
  canAccessHospitalOps,
  theme,
  textScale,
  symtomAuthToken,
  pairedDevices,
  chatNotification,
  allUsers, // Home Widget List Tutuyor

  hba1cList,
  medicines,
  usedStripCount,
}

extension SharedPreferencesKeysStringExt on String {
  SharedPreferencesKeys? get xSharedKeys => SharedPreferencesKeys.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension SharedPreferencesKeysExt on SharedPreferencesKeys {
  String get xRawValue => getEnumValue(this);
}
