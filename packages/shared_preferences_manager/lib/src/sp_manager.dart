import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

part 'sp_extensions.dart';
part 'sp_keys.dart';
part 'sp_manager_impl.dart';

abstract class ISharedPreferencesManager {
  Future<void> init();

  Future<bool> setBool(SharedPreferencesKeys key, bool value);
  Future<bool> setDouble(SharedPreferencesKeys key, double value);
  Future<bool> setInt(SharedPreferencesKeys key, int value);
  Future<bool> setString(SharedPreferencesKeys key, String value);
  Future<bool> setStringList(SharedPreferencesKeys key, List<String> value);

  dynamic get(SharedPreferencesKeys key);
  bool? getBool(SharedPreferencesKeys key);
  double? getDouble(SharedPreferencesKeys key);
  int? getInt(SharedPreferencesKeys key);
  String? getString(SharedPreferencesKeys key);
  List<String>? getStringList(SharedPreferencesKeys key);

  Future<bool> remove(SharedPreferencesKeys key);
  Set<String> getKeys();
  Future<bool> clear();
  bool containsKey(SharedPreferencesKeys key);
  Future<void> reload();
}
