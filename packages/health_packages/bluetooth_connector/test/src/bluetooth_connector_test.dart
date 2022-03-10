// ignore_for_file: prefer_const_constructors
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:test/test.dart';

void main() {
  group('BluetoothConnector', () {
    test('can be instantiated', () {
      expect(BluetoothConnector(), isNotNull);
    });
  });
}
