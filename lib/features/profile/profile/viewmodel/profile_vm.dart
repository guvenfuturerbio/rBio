import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
    SharedPreferencesKeys.values.forEach(
      (element) async {
        await getIt<ISharedPreferencesManager>().remove(element);
      },
    );

    getIt<Repository>().localCacheService.removeAll();

    AnalyticsManager().sendEvent(LogoutEvent());
    Atom.to(PagePaths.LOGIN, isReplacement: true);
  }
}
