import 'package:onedosehealth/core/core.dart';

void initializeLocatorTest(ProductType type) {
  if (type == ProductType.oneDose) {
    getIt
        .registerSingleton<KeyManager>(TestOneDoseKeyManager()..loadTestData());
  }

  getIt.registerSingleton<IAppConfig>(OneDoseConfig());
}

ApiService getTestApiService() => ApiServiceImpl(
      DioHelper(true),
      getIt<IAppConfig>().endpoints,
    );

class TestOneDoseKeyManager extends KeyManager {
  void loadTestData() {
    map.addAll(
      {
        Keys.baseUrl: "https://rbio.guven.com.tr/api/v1",
        Keys.devApiTest: "https://apitestbeta.onedosehealth.com/api/v1",
        Keys.doctorBaseUrl: "https://apitestbeta.onedosehealth.com",
        Keys.clientId: "CerebrumPlusProductionExternal",
        Keys.clientSecret: "87702b40-56f5-458e-b3f6-d24d09727dbc",
        Keys.mockAppointment: "199b9d0c22e64f0e88deeb10ec511474",
        Keys.dev4Guven: "https://dev4.guven.com.tr",
        Keys.sentryDsn:
            "https://f54e64bc5a8a4c9bbcddf7bb771c5967@o983734.ingest.sentry.io/5940445",
        Keys.symtonCheckerLogin: "https://authservice.priaid.ch",
        Keys.symtomRequestLogin: "https://healthservice.priaid.ch",
        Keys.doctorClientId: "OneDoseLocal",
        Keys.doctorClientSecret: "514b7ffb-e8bc-40a7-a26b-f0b80fac8b99"
      },
    );
  }
}
