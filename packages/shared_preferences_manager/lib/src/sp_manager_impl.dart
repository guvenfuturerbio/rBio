part of 'sp_manager.dart';

class SharedPreferencesManager extends ISharedPreferencesManager {
  late SharedPreferences sharedPreferences;

  @override
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> setBool(SharedPreferencesKeys key, bool value) async =>
      sharedPreferences.setBool(key.xRawValue, value);

  @override
  Future<bool> setDouble(SharedPreferencesKeys key, double value) async =>
      sharedPreferences.setDouble(key.xRawValue, value);

  @override
  Future<bool> setInt(SharedPreferencesKeys key, int value) async =>
      sharedPreferences.setInt(key.xRawValue, value);

  @override
  Future<bool> setString(SharedPreferencesKeys key, String value) async =>
      sharedPreferences.setString(key.xRawValue, value);

  @override
  Future<bool> setStringList(
    SharedPreferencesKeys key,
    List<String> value,
  ) async =>
      sharedPreferences.setStringList(key.xRawValue, value);

  @override
  dynamic get(SharedPreferencesKeys key) {
    try {
      return sharedPreferences.get(key.xRawValue);
    } catch (e) {
      return null;
    }
  }

  @override
  bool? getBool(SharedPreferencesKeys key) {
    try {
      return sharedPreferences.getBool(key.xRawValue);
    } catch (e) {
      return null;
    }
  }

  @override
  double? getDouble(SharedPreferencesKeys key) {
    try {
      return sharedPreferences.getDouble(key.xRawValue);
    } catch (e) {
      return null;
    }
  }

  @override
  int? getInt(SharedPreferencesKeys key) {
    try {
      return sharedPreferences.getInt(key.xRawValue);
    } catch (e) {
      return null;
    }
  }

  @override
  String? getString(SharedPreferencesKeys key) {
    try {
      return sharedPreferences.getString(key.xRawValue);
    } catch (e) {
      return null;
    }
  }

  @override
  List<String>? getStringList(SharedPreferencesKeys key) {
    try {
      return sharedPreferences.getStringList(key.xRawValue);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> remove(SharedPreferencesKeys key) async =>
      sharedPreferences.remove(key.xRawValue);

  @override
  Future<bool> clear() async => sharedPreferences.clear();

  @override
  Set<String> getKeys() => sharedPreferences.getKeys();

  @override
  bool containsKey(SharedPreferencesKeys key) =>
      sharedPreferences.containsKey(key.xRawValue);

  @override
  Future<void> reload() async => sharedPreferences.reload();
}
