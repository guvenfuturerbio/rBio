import 'package:onedosehealth/core/core.dart';

class SharedPreferencesTestManager extends ISharedPreferencesManager {
  final String _token =
      """eyJhbGciOiJFUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJoQVJFNkNYN01laWE0TXNTVkl5UGRoVzZqVk5xSnZsV1FqZzZwUEh4X0ljIn0.eyJqdGkiOiI2NmRhYWM1NC0wNjk5LTQ3OTQtYmZjYy1lYTI4YWZhMGIxMmIiLCJleHAiOjE2NTcyMTM2NTcsIm5iZiI6MCwiaWF0IjoxNjU3MTc3NjU3LCJpc3MiOiJodHRwOi8vc3NvLm9uZWRvc2VoZWFsdGguY29tL2F1dGgvcmVhbG1zL0d1dmVuQ29tcGxleCIsImF1ZCI6WyJDZXJlYnJ1bVBsdXNQcm9kdWN0aW9uRXh0ZXJuYWwiLCJPbmVEb3NlTG9jYWwiLCJPbmVEb3NlUHJvZHVjdGlvbkV4dGVybmFsIiwiQ2VyZWJydW1QbHVzTG9jYWxFeHRlcm5hbCIsImFjY291bnQiLCJDZXJlYnJ1bVBsdXNUZXN0RXh0ZXJuYWwiXSwic3ViIjoiYjFmM2JlMjctMTc3My00Y2IwLThiOTctYTU1NzFiM2RkY2YxIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiT25lRG9zZUxvY2FsRXh0ZXJuYWwiLCJhdXRoX3RpbWUiOjAsInNlc3Npb25fc3RhdGUiOiJjMjkxYTc1Ny1mYjBkLTRkZGYtYTUyMC1iYWI4NWY1MjdkZTEiLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwiUFRNYWluIiwidW1hX2F1dGhvcml6YXRpb24iLCJMb2dpbiIsIkFsbE1haW4iXX0sInJlc291cmNlX2FjY2VzcyI6eyJDZXJlYnJ1bVBsdXNQcm9kdWN0aW9uRXh0ZXJuYWwiOnsicm9sZXMiOlsiTG9naW4iXX0sIk9uZURvc2VMb2NhbCI6eyJyb2xlcyI6WyJMb2dpbiJdfSwiT25lRG9zZVByb2R1Y3Rpb25FeHRlcm5hbCI6eyJyb2xlcyI6WyJMb2dpbiJdfSwiT25lRG9zZUxvY2FsRXh0ZXJuYWwiOnsicm9sZXMiOlsiTG9naW4iXX0sIkNlcmVicnVtUGx1c0xvY2FsRXh0ZXJuYWwiOnsicm9sZXMiOlsiTG9naW4iXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfSwiQ2VyZWJydW1QbHVzVGVzdEV4dGVybmFsIjp7InJvbGVzIjpbIkxvZ2luIl19fSwic2NvcGUiOiJvcGVuaWQgZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiWUlMTUFaIEJFUktBWSBCRUtFTiIsInByZWZlcnJlZF91c2VybmFtZSI6IjM0OTU0NjE3MjEyIiwiZ2l2ZW5fbmFtZSI6IllJTE1BWiBCRVJLQVkiLCJmYW1pbHlfbmFtZSI6IkJFS0VOIiwiZW1haWwiOiI3OTk2YWZlMy1kMjE5LTQxYzAtYTVhZi01MWY2MWIyNTA3YjdAbWFpbHlvay5jb20ifQ.MEQCIDuPd1jjFpKnI3hERrzp7-Dxl7ihq0wH0k3ppcOQGLr-AiBhjpU7g0r2jI7IKR8m3WthxwVW1Mc1xr5UEcosQ5mBfQ""";

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
