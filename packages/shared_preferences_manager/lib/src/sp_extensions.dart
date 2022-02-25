part of 'sp_manager.dart';

extension SharedPreferencesKeysStringExt on String {
  SharedPreferencesKeys? get xSharedKeys => SharedPreferencesKeys.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension SharedPreferencesKeysExt on SharedPreferencesKeys {
  String get xRawValue => toString().split('.').last;
}
