import 'package:cache/cache.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scale_health_impl/scale_health_impl.dart';
import 'package:scale_hive_impl/scale_hive_impl.dart';
import 'package:scale_repository/scale_repository.dart';

import '../app/bluetooth_v2/bluetooth_v2.dart';
import '../features/mediminder/managers/reminder_notifications_manager.dart';
import '../model/treatment_model/treatment_model.dart';
import 'core.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

Future<void> setupLocator(AppConfig appConfig) async {
  getIt.registerSingleton<KeyManager>(KeyManager());
  await getIt<KeyManager>().setup(Environment.prod);

  getIt.registerSingleton<AppConfig>(appConfig);
  getIt.registerSingleton<CacheClient>(CacheClient());

  getIt.registerSingleton<DeviceLocalDataSource>(BluetoothDeviceLocalDataSourceImpl());
  getIt.registerFactory<DeviceRepository>(() => DeviceRepositoryImpl(getIt()));
  getIt.registerFactory<DisconnectDeviceUseCase>(() => DisconnectDeviceUseCase(getIt()));
  getIt.registerFactory<ConnectDeviceUseCase>(() => ConnectDeviceUseCase(getIt()));
  getIt.registerFactory<SearchDeviceUseCase>(() => SearchDeviceUseCase(getIt()));
  getIt.registerFactory<ReadValuesUseCase>(() => ReadValuesUseCase(getIt()));
  getIt.registerFactory<ReadStatusDeviceUseCase>(() => ReadStatusDeviceUseCase(getIt()));
  getIt.registerFactory<StopScanUseCase>(() => StopScanUseCase(getIt()));
  getIt.registerFactory<BluetoothStatusUseCase>(() => BluetoothStatusUseCase(getIt()));
  getIt.registerFactory<MiScaleStopUseCase>(() => MiScaleStopUseCase(getIt()));
  getIt.registerFactory<DeviceLastStatusUseCase>(() => DeviceLastStatusUseCase(getIt()));
  getIt.registerLazySingleton<BluetoothLocalManager>(() => BluetoothLocalManager(getIt()));

  // #region !isWeb
  String? directory;
  if (!Atom.isWeb) {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    directory = appDocumentDirectory.path;
    Hive.init(directory);

    final ble = FlutterReactiveBle();
    getIt.registerSingleton<BleScanner>(BleScanner(ble));
    getIt.registerSingleton<BleConnector>(BleConnector(ble));
    getIt.registerLazySingleton<FlutterReactiveBle>(
      () => FlutterReactiveBle(),
    );
    getIt.registerLazySingleton<BleReactorOps>(
      () => BleReactorOps(
        getIt<FlutterReactiveBle>(),
      ),
    );
    getIt.registerLazySingleton<BleDeviceManager>(
      () => BleDeviceManager(
        getIt<BleScanner>(),
        getIt<BleConnector>(),
        getIt<ISharedPreferencesManager>(),
      ),
    );
  }
  // #endregion

  // #region GuvenSettings
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  GuvenSettings settings = GuvenSettings(
    appName: packageInfo.appName,
    buildNumber: packageInfo.buildNumber,
    packageName: packageInfo.packageName,
    version: packageInfo.version,
    appDocDirectory: directory,
  );
  getIt.registerLazySingleton<GuvenSettings>(
    () => settings,
  );
  // #endregion

  // #region Manager
  getIt.registerLazySingleton<ReminderNotificationsManager>(
    () => ReminderNotificationsManagerImpl(
      getIt<LocalNotificationManager>(),
    ),
  );
  getIt.registerLazySingleton<FirebaseMessagingManager>(
    () => FirebaseMessagingManagerImpl(
      localNotificationManager: getIt<LocalNotificationManager>(),
      notificationBadgeNotifier: getIt<NotificationBadgeNotifier>(),
      repository: getIt<Repository>(),
    ),
  );
  getIt.registerLazySingleton<LocalNotificationManager>(
    () => LocalNotificationManagerImpl(
      (message) {
        LoggerUtils.instance.i(message);
      },
    ),
  );
  getIt.registerLazySingleton<ISharedPreferencesManager>(
    () => SharedPreferencesManager(),
  );
  getIt.registerLazySingleton<UserManager>(
    () => UserManagerImpl(),
  );
  // #endregion

  // #region Helper
  getIt.registerSingleton<IDioHelper>(DioHelper());
  // #endregion

  // #region Service
  getIt.registerLazySingleton<ProfileStorageImpl>(
    () => ProfileStorageImpl(),
  );
  getIt.registerLazySingleton<GlucoseStorageImpl>(
    () => GlucoseStorageImpl(),
  );
  getIt.registerLazySingleton<BloodPressureStorageImpl>(
    () => BloodPressureStorageImpl(),
  );
  getIt.registerLazySingleton<ApiService>(
    () => ApiServiceImpl(getIt<IDioHelper>()),
  );
  getIt.registerLazySingleton<ChronicTrackingApiService>(
    () => ChronicTrackingApiServiceImpl(
      getIt<IDioHelper>(),
    ),
  );
  getIt.registerLazySingleton<DoctorApiService>(
    () => DoctorApiServiceImpl(
      getIt<IDioHelper>(),
    ),
  );
  getIt.registerLazySingleton<FirestoreManager>(
    () => FirestoreManager(),
  );
  getIt.registerLazySingleton<LocalCacheService>(
    () => LocalCacheServiceImpl(),
  );
  getIt.registerLazySingleton<SymptomApiService>(
    () => SymptomApiServiceImpl(
      getIt<IDioHelper>(),
    ),
  );
  // #endregion

  // #region Repository
  getIt.registerLazySingleton(
    () => ChronicTrackingRepository(
      apiService: getIt<ChronicTrackingApiService>(),
      localCacheService: getIt<LocalCacheService>(),
    ),
  );
  getIt.registerSingleton<DoctorRepository>(
    DoctorRepository(
      apiService: getIt<DoctorApiService>(),
      localCacheService: getIt<LocalCacheService>(),
    ),
  );
  getIt.registerSingleton<Repository>(
    Repository(
      apiService: getIt<ApiService>(),
      localCacheService: getIt<LocalCacheService>(),
    ),
  );
  getIt.registerSingleton<SymptomRepository>(
    SymptomRepository(
      getIt<SymptomApiService>(),
    ),
  );
  // #endregion

  // #region Notifiers
  getIt.registerLazySingleton<LocaleNotifier>(
    () => LocaleNotifier(),
  );
  getIt.registerLazySingleton<NotificationBadgeNotifier>(
    () => NotificationBadgeNotifier(),
  );
  getIt.registerLazySingleton<UserNotifier>(
    () => UserNotifier(),
  );
  // #endregion

  try {
    await registerStorage();
  } catch (_) {
    clearStorage();
    await registerStorage();
  }

  getIt.registerSingleton<GuvenService>(
    GuvenService(
      getIt<IDioHelper>(),
      getIt<KeyManager>(),
      getIt<ISharedPreferencesManager>(),
    ),
  );
  getIt.registerSingleton<ScaleRepository>(
    ScaleRepository(
      getIt<GuvenService>(),
      ScaleHiveImpl(),
      ScaleHealthImpl(),
      getIt<BleReactorOps>(),
    ),
  );

  // #region Init
  await getIt<ScaleRepository>().init("hive_scale");
  await getIt<ISharedPreferencesManager>().init();
  await getIt<LocalCacheService>().init();
  await getIt<LocaleNotifier>().init();
  await getIt<LocalNotificationManager>().init();
  await getIt<FirebaseMessagingManager>().init();
  await getIt<ReminderNotificationsManager>().checkOneTimeNotifications();
  // #endregion
}

class GuvenSettings {
  String appName;
  String packageName;
  String version;
  String buildNumber;
  String? appDocDirectory;

  GuvenSettings({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
    this.appDocDirectory,
  });
}

Future<void> registerStorage() async {
  Hive.registerAdapter<TreatmentModel>(TreatmentModelAdapter());
  Hive.registerAdapter<ScaleUnit>(ScaleUnitAdapter());

  Hive.registerAdapter<Person>(PersonAdapter());
  Hive.registerAdapter<GlucoseData>(GlucoseDataAdapter());
  Hive.registerAdapter<ScaleModel>(ScaleModelAdapter());
  Hive.registerAdapter<BloodPressureModel>(BloodPressureModelAdapter());

  Hive.registerAdapter<ScaleHiveModel>(ScaleHiveModelAdapter());

  await getIt<ProfileStorageImpl>().init();
  await getIt<GlucoseStorageImpl>().init();
  await getIt<BloodPressureStorageImpl>().init();
}

Future<void> clearStorage() async {
  Hive.deleteBoxFromDisk(getIt<ProfileStorageImpl>().boxKey);
  Hive.deleteBoxFromDisk(getIt<GlucoseStorageImpl>().boxKey);
  Hive.deleteBoxFromDisk(getIt<BloodPressureStorageImpl>().boxKey);
  Hive.deleteBoxFromDisk(getIt<ProfileStorageImpl>().boxKey);
  Hive.deleteFromDisk();
}
