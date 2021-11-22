import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';

import 'notifiers/ble_operators/ble_connector.dart';
import 'notifiers/ble_operators/ble_reactor.dart';
import 'notifiers/ble_operators/ble_scanner.dart';
import 'notifiers/shared_pref_notifiers.dart';
import 'notifiers/user_notifier.dart';
import 'notifiers/user_profiles_notifier.dart';
import 'notifiers/login_view_model.dart';

GetIt locator = GetIt.I; // GetIt.I -  GetIt.instance - nin kisaltmasidir

void setupLocator({FlutterReactiveBle ble}) {
  locator.registerLazySingleton(() => UserNotifier());
  locator.registerLazySingleton(() => LoginViewModel());
  locator.registerLazySingleton(() => UserProfilesNotifier());
  locator.registerLazySingleton(() => BleReactorOps(ble: ble));
  locator.registerLazySingleton(() => BleConnectorOps(ble: ble));
  locator.registerLazySingleton(() => BleScannerOps(ble: ble));
  locator.registerLazySingleton(() => SharedPrefNotifiers());
}
