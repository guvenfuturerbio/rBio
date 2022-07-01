import 'package:onedosehealth/core/core.dart';

class SharedPreferencesTestManager extends ISharedPreferencesManager {
  final String _token =
      """eyJhbGciOiJFUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJoQVJFNkNYN01laWE0TXNTVkl5UGRoVzZqVk5xSnZsV1FqZzZwUEh4X0ljIn0.eyJqdGkiOiJmNTQwMWNkZC03MDNjLTRmMWEtYjc4Yi1kMTNiNGEwN2VmOTgiLCJleHAiOjE2NTY3MDY5NjAsIm5iZiI6MCwiaWF0IjoxNjU2NjcwOTYwLCJpc3MiOiJodHRwOi8vc3NvLm9uZWRvc2VoZWFsdGguY29tL2F1dGgvcmVhbG1zL0d1dmVuQ29tcGxleCIsImF1ZCI6WyJDZXJlYnJ1bVBsdXNQcm9kdWN0aW9uRXh0ZXJuYWwiLCJPbmVEb3NlTG9jYWwiLCJPbmVEb3NlUHJvZHVjdGlvbkV4dGVybmFsIiwiQ2VyZWJydW1QbHVzTG9jYWxFeHRlcm5hbCIsImFjY291bnQiLCJDZXJlYnJ1bVBsdXNUZXN0RXh0ZXJuYWwiXSwic3ViIjoiMjdmNTc0MjctODM2Yy00Nzg2LWJmNDQtNzg4ZjQ1N2Y4NzFmIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiT25lRG9zZUxvY2FsRXh0ZXJuYWwiLCJhdXRoX3RpbWUiOjAsInNlc3Npb25fc3RhdGUiOiI3MGEwOTIwOC1mODQyLTRhYjgtOTQ0ZS0wZTE5YTNlZTA2ZGQiLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwiUFRNYWluIiwidW1hX2F1dGhvcml6YXRpb24iLCJMb2dpbiIsIkFsbE1haW4iLCJjcm9uaWNQYXRpZW50Il19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiQ2VyZWJydW1QbHVzUHJvZHVjdGlvbkV4dGVybmFsIjp7InJvbGVzIjpbIkxvZ2luIl19LCJPbmVEb3NlTG9jYWwiOnsicm9sZXMiOlsiTG9naW4iXX0sIk9uZURvc2VQcm9kdWN0aW9uRXh0ZXJuYWwiOnsicm9sZXMiOlsiTG9naW4iXX0sIk9uZURvc2VMb2NhbEV4dGVybmFsIjp7InJvbGVzIjpbIkxvZ2luIl19LCJDZXJlYnJ1bVBsdXNMb2NhbEV4dGVybmFsIjp7InJvbGVzIjpbIkxvZ2luIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX0sIkNlcmVicnVtUGx1c1Rlc3RFeHRlcm5hbCI6eyJyb2xlcyI6WyJMb2dpbiJdfX0sInNjb3BlIjoib3BlbmlkIGVtYWlsIHByb2ZpbGUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6IlNFUktBTiAgw5ZaVMOcUksgIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiMTg2MjA3MTY0MTYiLCJnaXZlbl9uYW1lIjoiU0VSS0FOICIsImZhbWlseV9uYW1lIjoiw5ZaVMOcUksgIiwiZW1haWwiOiI5NjI4MTgyNy03NGJiLTQxNzctOTMwMS00M2U3ZWI2MmNkOWRAbWFpbHlvay5jb20ifQ.MEUCIQCpUHosgH8gkb32XgZum0bilt9ikpj1lTwK5r1WRnSG_wIgEYRp5Ox7dPgwgbRjbJ3HcRy335mCx_HZwfZWZ5eOW-I""";

  @override
  Future<bool> clear() {
    throw UnimplementedError();
  }

  @override
  bool containsKey(SharedPreferencesKeys key) {
    throw UnimplementedError();
  }

  @override
  get(SharedPreferencesKeys key) {
    throw UnimplementedError();
  }

  @override
  bool? getBool(SharedPreferencesKeys key) {
    throw UnimplementedError();
  }

  @override
  double? getDouble(SharedPreferencesKeys key) {
    throw UnimplementedError();
  }

  @override
  int? getInt(SharedPreferencesKeys key) {
    throw UnimplementedError();
  }

  @override
  Set<String> getKeys() {
    throw UnimplementedError();
  }

  @override
  String? getString(SharedPreferencesKeys key) {
    if (key == SharedPreferencesKeys.jwtToken) {
      return _token;
    }

    throw UnimplementedError();
  }

  @override
  List<String>? getStringList(SharedPreferencesKeys key) {
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  Future<void> reload() {
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(SharedPreferencesKeys key) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setBool(SharedPreferencesKeys key, bool value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setDouble(SharedPreferencesKeys key, double value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setInt(SharedPreferencesKeys key, int value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setString(SharedPreferencesKeys key, String value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setStringList(SharedPreferencesKeys key, List<String> value) {
    throw UnimplementedError();
  }
}
