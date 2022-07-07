import 'package:flutter_test/flutter_test.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/dashboard/search/model/filter_resources_request.dart';
import 'package:onedosehealth/features/take_appointment/create_appointment/model/filter_tenants_request.dart';
import 'package:onedosehealth/features/take_appointment/create_appointment/model/filter_departments_request.dart';
import 'package:onedosehealth/features/take_appointment/create_appointment_events/model/resources_request.dart';
import 'package:onedosehealth/features/take_appointment/create_appointment_summary/model/save_appointment_request.dart';
import 'package:onedosehealth/features/take_appointment/do_mobile_payment/appointment_request.dart';
import 'package:onedosehealth/features/store/credit_card/model/package_payment_request.dart';
import 'package:onedosehealth/features/store/credit_card/model/payment_cc_request.dart';

import '../setup/locator_setup.dart';

void main() {
  late ApiService apiService;
  setUpAll(() {
    initializeLocatorTest(ProductType.oneDose);
    apiService = getTestApiService();
  });

  const _testUsername = "18620716416";
  const _testBerkayUserName = "34954617212";
  const _testPassword = "Numlock1234!!";
  const _testWrongPassword = "Numlock1234!!*";
  const _testConsentId = "2";
  const _userNameString = "34954617212";
  // const _userName = 34954617212;
  const _userId = 54775;
  const _smsCode = "403283";
  const _wrongSmsCode = "222222";
  const _bbPassword = "Berkay1!";
  const _cardHolder = "test";
  const _cardNumber = "test";
  const _ccv = "test";
  const _expirationMonth = "02";
  const _expirationYear = "24";
  const _identityNumber = "34954617212";
  const _cayyoluTenantId = 7;
  const _dietDepartmentId = 119;
  const _appointmentDietResourceId = 863;
  const _patientIdBerkay = 677379;
  const _fromAppointmentStart = "2022-09-09T13:30:00";
  const _toAppointmentStart = "2022-09-09T14:15:00";
  const _resourceRequestId = null;
  const _appointmentHospitalType = 1;
  const _appointmentStatus = 1;
  const _appointmentPatientType = 0;
  const _appointmentSource = 3;
  const _hospitalVideoCallLink = null;
  const _hospitalVoucherCode = null;

  group(
    "Login",
    () {
      test('Login Success Test', () async {
        final result = await apiService.login(
          _testBerkayUserName,
          _bbPassword,
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

      test('getSubCategoryItems', () async {
        final result =
            await apiService.getSubCategoryItems("22" // Masaj Paketleri
                );
        expect(result, isNotEmpty);
      });

      // test('doPackagePayment', () async {
      //   final result = await apiService.doPackagePayment(PackagePaymentRequest(
      //       subPackageItemId: "22",
      //       cc: PaymentCCRequest(
      //           cardHolder: _cardHolder,
      //           cardNumber: _cardNumber,
      //           cvv: _ccv,
      //           expirationMonth: _expirationMonth,
      //           expirationYear: _expirationYear))); // Masaj Paketleri

      //   expect(result, isNotEmpty);
      // });
    },
  );

  test('updateUserSystemName', () async {
    final result = await apiService.updateUserSystemName(_identityNumber);
    expect(result, isNotEmpty);
  });

  test('filterTenants', () async {
    final result = await apiService.filterTenants(
        getIt<IAppConfig>().endpoints.base.filterTenantsPath,
        FilterTenantsRequest(departmanId: 7));
    expect(result.isNotEmpty, true);
  });

  test('filterDepartments', () async {
    final result = await apiService.filterDepartments(FilterDepartmentsRequest(
        tenantId: 7, search: "Instance of 'SearchObject"));
    expect(result.isNotEmpty, true);
  });

  test('filterResources', () async {
    final result = await apiService.filterResources(FilterResourcesRequest(
        departmentId: 13,
        tenantId: 1,
        search: "Instance of 'SearchObject'",
        appointmentType: 1));
    expect(result.isEmpty, true);
  });

  test('saveAppointment', () async {
    final result = await apiService.saveAppointment(
      AppointmentRequest(
        saveAppointmentsRequest: SaveAppointmentsRequest(
            tenantId: _cayyoluTenantId,
            patientId: _patientIdBerkay,
            resourcesRequestList: [
              ResourcesRequest(
                  tenantId: _cayyoluTenantId,
                  departmentId: _dietDepartmentId,
                  resourceId: _appointmentDietResourceId,
                  from: _fromAppointmentStart,
                  to: _toAppointmentStart,
                  id: _resourceRequestId)
            ],
            type: _appointmentHospitalType,
            status: _appointmentStatus,
            patientType: _appointmentPatientType,
            appointmentSource: _appointmentSource,
            videoCallLink: _hospitalVideoCallLink),
        voucherCode: _hospitalVoucherCode,
      ),
    );
    expect(result, true);
  });

  // test('Get Countries Test', () async {
  //   final result = await apiService.getCountries();
  //   expect(result.isSuccessful, true);
  // });   // test('Get Countries Test', () async {
  //   final result = await apiService.getCountries();
  //   expect(result.isSuccessful, true);
  // });

//
}
