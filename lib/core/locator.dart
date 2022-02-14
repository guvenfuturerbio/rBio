import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../features/mediminder/managers/reminder_notifications_manager.dart';
import '../model/treatment_model/treatment_model.dart';
import 'core.dart';
import 'manager/firebase_messaging_manager.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

Future<void> setupLocator(AppConfig appConfig) async {
  getIt.registerSingleton<AppConfig>(appConfig);
  String? directory;

  if (!Atom.isWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    final appDocumentDirectory = await getApplicationDocumentsDirectory();

    directory = appDocumentDirectory.path;
    Hive.init(directory);
  }

  getIt.registerSingleton<NotificationBadgeNotifier>(
      NotificationBadgeNotifier());

  getIt.registerLazySingleton(() => ProfileStorageImpl());
  getIt.registerLazySingleton(() => GlucoseStorageImpl());
  getIt.registerLazySingleton(() => ScaleStorageImpl());
  getIt.registerLazySingleton(() => BloodPressureStorageImpl());

  getIt.registerLazySingleton<ReminderNotificationsManager>(() =>
      ReminderNotificationsManagerImpl(getIt<LocalNotificationManager>()));

  try {
    await registerStorage();
  } catch (_) {
    clearStorage();
    await registerStorage();
  }

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  GuvenSettings settings = GuvenSettings(
      appName: packageInfo.appName,
      buildNumber: packageInfo.buildNumber,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      appDocDirectory: directory);

  getIt.registerSingleton<GuvenSettings>(settings);
  getIt.registerSingleton<FirestoreManager>(FirestoreManager());
  getIt.registerSingleton<IDioHelper>(DioHelper());
  getIt
      .registerSingleton<ISharedPreferencesManager>(SharedPreferencesManager());
  getIt.registerSingleton<UserManager>(UserManagerImpl());
  getIt.registerSingleton<UserNotifier>(UserNotifier());
  getIt.registerSingleton<LocaleNotifier>(LocaleNotifier());

  getIt.registerSingleton<LocalCacheService>(LocalCacheServiceImpl());
  getIt.registerSingleton<ApiService>(ApiServiceImpl(getIt<IDioHelper>()));
  getIt.registerSingleton<ChronicTrackingApiService>(
      ChronicTrackingApiServiceImpl(getIt<IDioHelper>()));
  getIt.registerSingleton<Repository>(Repository(
      apiService: getIt<ApiService>(),
      localCacheService: getIt<LocalCacheService>()));

  getIt.registerSingleton<DoctorApiService>(
      DoctorApiServiceImpl(getIt<IDioHelper>()));
  getIt.registerSingleton<DoctorRepository>(
    DoctorRepository(
      apiService: getIt<DoctorApiService>(),
      localCacheService: getIt<LocalCacheService>(),
    ),
  );

  getIt.registerSingleton<SymptomApiService>(
      SymptomApiServiceImpl(getIt<IDioHelper>()));
  getIt.registerSingleton<SymptomRepository>(
      SymptomRepository(getIt<SymptomApiService>()));

  await getIt<ISharedPreferencesManager>().init();
  await getIt<LocalCacheService>().init();
  await getIt<LocaleNotifier>().init();

  getIt.registerLazySingleton(() => ChronicTrackingRepository(
      apiService: getIt<ChronicTrackingApiService>(),
      localCacheService: getIt<LocalCacheService>()));

  getIt.registerLazySingleton<LocalNotificationManager>(
      () => LocalNotificationManagerImpl());

  //  getIt.registerLazySingleton(() => PushedNotificationHandlerNew());
  // getIt<PushedNotificationHandlerNew>().initializeGCM();

  if (!Atom.isWeb) {
    getIt.registerSingleton<FlutterReactiveBle>(FlutterReactiveBle());
    getIt.registerLazySingleton<BleReactorOps>(
        () => BleReactorOps(getIt<FlutterReactiveBle>()));
    getIt.registerLazySingleton<BleConnectorOps>(
        () => BleConnectorOps(getIt<FlutterReactiveBle>()));
    getIt.registerLazySingleton<BleScannerOps>(
        () => BleScannerOps(getIt<FlutterReactiveBle>()));
    getIt.registerLazySingleton<BleDeviceManager>(() => BleDeviceManager());
  }

  getIt.registerSingleton<FirebaseMessagingManager>(
    FirebaseMessagingManagerImpl(
      localNotificationManager: getIt<LocalNotificationManager>(),
      notificationBadgeNotifier: getIt<NotificationBadgeNotifier>(),
      repository: getIt<Repository>(),
    ),
  );
}

class GuvenSettings {
  String appName;
  String packageName;
  String version;
  String buildNumber;
  String? appDocDirectory;

  GuvenSettings(
      {required this.appName,
      required this.packageName,
      required this.version,
      required this.buildNumber,
      this.appDocDirectory});
}

Future<void> registerStorage() async {
  Hive.registerAdapter<TreatmentModel>(TreatmentModelAdapter());
  Hive.registerAdapter<ScaleUnit>(ScaleUnitAdapter());

  Hive.registerAdapter<Person>(PersonAdapter());
  Hive.registerAdapter<GlucoseData>(GlucoseDataAdapter());
  Hive.registerAdapter<ScaleModel>(ScaleModelAdapter());
  Hive.registerAdapter<BloodPressureModel>(BloodPressureModelAdapter());

  await getIt<ProfileStorageImpl>().init();
  await getIt<GlucoseStorageImpl>().init();
  await getIt<ScaleStorageImpl>().init();
  await getIt<BloodPressureStorageImpl>().init();
}

Future<void> clearStorage() async {
  Hive.deleteBoxFromDisk(getIt<ProfileStorageImpl>().boxKey);
  Hive.deleteBoxFromDisk(getIt<GlucoseStorageImpl>().boxKey);
  Hive.deleteBoxFromDisk(getIt<BloodPressureStorageImpl>().boxKey);
  Hive.deleteBoxFromDisk(getIt<ProfileStorageImpl>().boxKey);
  Hive.deleteFromDisk();
}
