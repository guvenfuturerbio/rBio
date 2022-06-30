import 'package:flutter_test/flutter_test.dart';
import 'package:onedosehealth/core/core.dart';

import '../setup/locator_setup.dart';

void main() {
  late ApiService apiService;
  setUpAll(() {
    initializeLocatorTest(ProductType.oneDose);
    apiService = getTestApiService();
  });

  const _testUsername = "18620716416";
  const _testPassword = "Numlock1234!!";
  const _testWrongPassword = "Numlock1234!!*";
  const _testConsentId = "2";

  group(
    "Login",
    () {
      test('Login Success Test', () async {
        final result = await apiService.login(
          _testUsername,
          _testPassword,
          _testConsentId,
        );
        expect(result.isSuccessful, true);
      });

      test('Login Failure Test', () async {
        try {
          await apiService.login(
            _testUsername,
            _testWrongPassword,
            _testConsentId,
          );
        } on RbioClientException catch (e) {
          expect(e, isNotNull);
        }
      });
    },
  );
}
