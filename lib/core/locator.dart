import 'package:get_it/get_it.dart';

import 'utils/user_info.dart';
import 'data/helper/dio_helper.dart';
import 'data/repository/repository.dart';
import 'data/service/api_service.dart';
import 'data/service/local_cache_service.dart';
import 'manager/shared_preferences_manager.dart';
import 'manager/user_manager.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton<IDioHelper>(DioHelper());
  getIt.registerSingleton<ISharedPreferencesManager>(SharedPreferencesManager());
  getIt.registerSingleton<UserManager>(UserManagerImpl());

  getIt.registerSingleton<LocalCacheService>(LocalCacheServiceImpl());
  getIt.registerSingleton<ApiService>(ApiServiceImpl(getIt<IDioHelper>()));
  getIt.registerSingleton<Repository>(Repository(apiService: getIt<ApiService>(), localCacheService: getIt<LocalCacheService>()));

  await getIt<ISharedPreferencesManager>().init();
  await getIt<LocalCacheService>().init();

  getIt.registerSingleton<UserInfo>(UserInfo(getIt<ISharedPreferencesManager>()));
}
