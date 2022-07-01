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
  const _userNameString = "34954617212";
  const _userName = 34954617212;
  const _userId = 67193;
  const _smsCode = "403283";
  const _wrongSmsCode = "222222";
  const _bbPassword = "4";
  const _testEmptyPath = "";

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

  group(
    "loginStarter",
    () {
      test('Login Success Test', () async {
        final result = await apiService.loginStarter(
          _userNameString,
          _bbPassword,
        );
        expect(result.isSuccessful, true);
      });

      test('Login Failure Test', () async {
        try {
          await apiService.loginStarter(
            _userNameString,
            _testWrongPassword,
          );
        } on RbioClientException catch (e) {
          expect(e, isNotNull);
        }
      });
    },
  );

  group(
    "2 FA Login",
    () {
      test('2 FA Login', () async {
        final result = await apiService.verifyConfirmation2fa(
          _smsCode,
          _userId,
        );
        expect(result, true);
      });

      test('2 FA Login Failure Test', () async {
        try {
          await apiService.verifyConfirmation2fa(
            _wrongSmsCode,
            _userId,
          );
        } on RbioClientException catch (e) {
          expect(e, isNotNull);
        }
      });
    },
  );

  group(
    "For You",
    () {
      test('Get Packages', () async {
        final result = await apiService.getAllPackage(
          getIt<IAppConfig>().endpoints.base.getAllPackagePath,
        );
        expect(result, isNotEmpty);
      });

      test('getAllSubCategories', () async {
        final result = await apiService.getAllSubCategories(
          getIt<IAppConfig>()
              .endpoints
              .base
              .getAllSubCategoriesPath(13), // Masaj Paketleri
        );
        expect(result, isNotEmpty);
      });

      test('getSubCategoryDetail', () async {
        final result = await apiService.getSubCategoryDetail(
          getIt<IAppConfig>()
              .endpoints
              .base
              .getSubCategoryDetailPath(22), // Masaj Paketleri
        );
        expect(result, isNotEmpty);
      });
    },
  );
}
