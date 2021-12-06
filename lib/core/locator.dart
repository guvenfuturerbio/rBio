import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../features/chronic_tracking/lib/notifiers/ble_operators/ble_connector.dart';
import '../features/chronic_tracking/lib/notifiers/ble_operators/ble_reactor.dart';
import '../features/chronic_tracking/lib/notifiers/ble_operators/ble_scanner.dart';

import '../features/chronic_tracking/lib/notifiers/login_view_model.dart';
import '../features/chronic_tracking/lib/notifiers/user_profiles_notifier.dart';
import 'core.dart';
import 'data/helper/dio_helper.dart';
import 'data/imports/cronic_tracking.dart';
import 'data/repository/repository.dart';
import 'data/repository/symptom_repository.dart';
import 'data/service/api_service.dart';
import 'data/service/chronic_service/chronic_storage_service.dart';
import 'data/service/local_cache_service.dart';
import 'data/service/symptom_api_service.dart';
import 'manager/shared_preferences_manager.dart';
import 'manager/user_manager.dart';
import 'utils/user_info.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

Future<void> setupLocator(AppConfig appConfig) async {
  getIt.registerSingleton<AppConfig>(appConfig);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  GuvenSettings settings = GuvenSettings(
    appName: packageInfo.appName,
    buildNumber: packageInfo.buildNumber,
    packageName: packageInfo.packageName,
    version: packageInfo.version,
  );
  getIt.registerSingleton<GuvenSettings>(settings);

  getIt.registerSingleton<IDioHelper>(DioHelper());
  getIt
      .registerSingleton<ISharedPreferencesManager>(SharedPreferencesManager());
  getIt.registerSingleton<UserManager>(UserManagerImpl());

  getIt.registerSingleton<LocalCacheService>(LocalCacheServiceImpl());
  getIt.registerSingleton<ApiService>(ApiServiceImpl(getIt<IDioHelper>()));
  getIt.registerSingleton<ChronicTrackingApiService>(
      ChronicTrackingApiServiceImpl(getIt<IDioHelper>()));
  getIt.registerSingleton<Repository>(Repository(
      apiService: getIt<ApiService>(),
      localCacheService: getIt<LocalCacheService>()));

  getIt.registerSingleton<SymptomApiService>(
      SymptomApiServiceImpl(getIt<IDioHelper>()));
  getIt.registerSingleton<SymptomRepository>(
      SymptomRepository(getIt<SymptomApiService>()));

  await getIt<ISharedPreferencesManager>().init();
  await getIt<LocalCacheService>().init();

  getIt.registerLazySingleton(() => GlucoseStorageImpl());
  getIt.registerLazySingleton(() => ProfileStorageImpl());

  await getIt<GlucoseStorageImpl>().init();
  await getIt<ProfileStorageImpl>().init();

  getIt.registerSingleton<UserInfo>(
      UserInfo(getIt<ISharedPreferencesManager>()));

  getIt.registerLazySingleton(() => LoginViewModel());
  getIt.registerLazySingleton(() => UserProfilesNotifier());

  getIt.registerLazySingleton(() => ChronicTrackingRepository(
      apiService: getIt<ChronicTrackingApiService>(),
      localCacheService: getIt<LocalCacheService>()));

  if (!Atom.isWeb) {
    getIt.registerSingleton<FlutterReactiveBle>(FlutterReactiveBle());
    getIt.registerLazySingleton<BleReactorOps>(
        () => BleReactorOps(ble: getIt<FlutterReactiveBle>()));
    getIt.registerLazySingleton<BleConnectorOps>(
        () => BleConnectorOps(ble: getIt<FlutterReactiveBle>()));
    getIt.registerLazySingleton<BleScannerOps>(
        () => BleScannerOps(ble: getIt<FlutterReactiveBle>()));
  }
}

class GuvenSettings {
  String appName;
  String packageName;
  String version;
  String buildNumber;

  GuvenSettings({
    @required this.appName,
    @required this.packageName,
    @required this.version,
    @required this.buildNumber,
  });
}
