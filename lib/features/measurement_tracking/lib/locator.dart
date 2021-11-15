import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';
import 'package:onedosehealth/doctor/notifiers/user_notifiers.dart';
import 'package:onedosehealth/models/sharedpref.dart';
import 'package:onedosehealth/notifiers/ble_operators/ble_connector.dart';
import 'package:onedosehealth/notifiers/ble_operators/ble_reactor.dart';
import 'package:onedosehealth/notifiers/ble_operators/ble_scanner.dart';
import 'package:onedosehealth/notifiers/shared_pref_notifiers.dart';
import 'package:onedosehealth/notifiers/stripcount_tracker.dart';
import 'package:onedosehealth/notifiers/user_notifier.dart';
import 'package:onedosehealth/notifiers/user_profiles_notifier.dart';
import 'package:onedosehealth/services/auth_service/login_view_model.dart';

GetIt locator = GetIt.I; // GetIt.I -  GetIt.instance - nin kisaltmasidir

void setupLocator({FlutterReactiveBle ble}) {
  locator.registerLazySingleton(() => UserNotifier());
  locator.registerLazySingleton(() => LoginViewModel());
  locator.registerLazySingleton(() => UserProfilesNotifier());
  locator.registerLazySingleton(() => UserNotifiers());
  locator.registerLazySingleton(() => BleReactorOps(ble: ble));
  locator.registerLazySingleton(() => BleConnectorOps(ble: ble));
  locator.registerLazySingleton(() => BleScannerOps(ble: ble));
  locator.registerLazySingleton(() => SharedPrefNotifiers());
}
