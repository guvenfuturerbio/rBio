// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:shared_preferences_manager/shared_preferences_manager.dart';

void main() {
  group('SharedPreferencesManager', () {
    test('can be instantiated', () {
      expect(SharedPreferencesManager(), isNotNull);
    });
  });
}
