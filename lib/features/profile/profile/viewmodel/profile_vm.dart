import 'package:flutter/material.dart';

import '../../../../core/core.dart';

part '../model/profile_numbers.dart';

class ProfileVm extends ChangeNotifier {
  LoadingProgress _state = LoadingProgress.LOADING;
  LoadingProgress get state => _state;
  set state(LoadingProgress value) {
    _state = value;
    notifyListeners();
  }

  ProfileNumbers numbers;

  Future<void> getNumbers() async {
    state = LoadingProgress.LOADING;
    await Future.delayed(Duration(seconds: 1));
    numbers = ProfileNumbers(relatives: 3, followers: 10, subscriptions: 50);
    state = LoadingProgress.DONE;
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseMessagingManager.instance.setTokenToServer("");

    await getIt<ISharedPreferencesManager>().clear();
    await getIt<ISharedPreferencesManager>().reload();
    await getIt<Repository>().localCacheService.removeAll();
    getIt<UserNotifier>().clear();
    FirebaseMessagingManager.handleLogout();
    // Clear all boxes
    getIt<GlucoseStorageImpl>().clear();
    getIt<ScaleStorageImpl>().clear();
    getIt<BloodPressureStorageImpl>().clear();
    getIt<ProfileStorageImpl>().clear();

    AnalyticsManager().sendEvent(LogoutEvent());
    Atom.to(PagePaths.LOGIN, isReplacement: true);
  }
}
