import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:onedosehealth/core/manager/ble_manager.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/notifiers/notification_handler_new.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../features/chronic_tracking/lib/notifiers/user_profiles_notifier.dart';
import 'core.dart';
import 'data/helper/dio_helper.dart';
import 'data/imports/cronic_tracking.dart';
import 'data/repository/repository.dart';
import 'data/repository/symptom_repository.dart';
import 'data/service/api_service.dart';
import 'data/service/local_cache_service.dart';
import 'data/service/symptom_api_service.dart';
import 'manager/shared_preferences_manager.dart';
import 'manager/user_manager.dart';
import 'utils/user_info.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  String directory;

  if (!Atom.isWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    final appDocumentDirectory = await getApplicationDocumentsDirectory();

    directory = appDocumentDirectory.path;
    Hive.init(directory);
  }

  getIt.registerLazySingleton(() => ProfileStorageImpl());
  getIt.registerLazySingleton(() => GlucoseStorageImpl());
  getIt.registerLazySingleton(() => ScaleStorageImpl());

  try {
    Hive.registerAdapter<Person>(PersonAdapter());
    Hive.registerAdapter<GlucoseData>(GlucoseDataAdapter());
    Hive.registerAdapter<ScaleModel>(ScaleModelAdapter());
    await getIt<ProfileStorageImpl>().init();
    await getIt<GlucoseStorageImpl>().init();
    await getIt<ScaleStorageImpl>().init();
  } catch (e, stk) {
    log(e.toString());
    debugPrintStack(stackTrace: stk);
  }
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  GuvenSettings settings = GuvenSettings(
      appName: packageInfo.appName,
      buildNumber: packageInfo.buildNumber,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      appDocDirectory: directory);

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

  getIt.registerSingleton<UserInfo>(
      UserInfo(getIt<ISharedPreferencesManager>()));

  getIt.registerLazySingleton(() => UserProfilesNotifier());

  getIt.registerLazySingleton(() => ChronicTrackingRepository(
      apiService: getIt<ChronicTrackingApiService>(),
      localCacheService: getIt<LocalCacheService>()));

  getIt.registerLazySingleton(() => PushedNotificationHandlerNew());
  getIt<PushedNotificationHandlerNew>().initializeGCM();

  if (!Atom.isWeb) {
    getIt.registerSingleton<FlutterReactiveBle>(FlutterReactiveBle());
    getIt.registerLazySingleton<BleReactorOps>(
        () => BleReactorOps(ble: getIt<FlutterReactiveBle>()));
    getIt.registerLazySingleton<BleConnectorOps>(
        () => BleConnectorOps(ble: getIt<FlutterReactiveBle>()));
    getIt.registerLazySingleton<BleScannerOps>(
        () => BleScannerOps(ble: getIt<FlutterReactiveBle>()));
    getIt.registerLazySingleton<BleDeviceManager>(() => BleDeviceManager());
  }
}

class GuvenSettings {
  String appName;
  String packageName;
  String version;
  String buildNumber;
  String appDocDirectory;

  GuvenSettings(
      {@required this.appName,
      @required this.packageName,
      @required this.version,
      @required this.buildNumber,
      @required this.appDocDirectory});
}
