import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'data/helper/dio_helper.dart';
import 'data/repository/repository.dart';
import 'data/service/api_service.dart';
import 'data/service/local_cache_service.dart';
import 'manager/shared_preferences_manager.dart';
import 'manager/user_manager.dart';
import 'utils/user_info.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
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
  getIt.registerSingleton<Repository>(Repository(
      apiService: getIt<ApiService>(),
      localCacheService: getIt<LocalCacheService>()));

  await getIt<ISharedPreferencesManager>().init();
  await getIt<LocalCacheService>().init();

  getIt.registerSingleton<UserInfo>(
      UserInfo(getIt<ISharedPreferencesManager>()));
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
