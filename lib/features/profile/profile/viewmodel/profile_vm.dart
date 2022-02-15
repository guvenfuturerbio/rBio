import 'package:flutter/material.dart';

import '../../../../core/core.dart';

part '../model/profile_numbers.dart';

class ProfileVm extends ChangeNotifier {
  LoadingProgress _state = LoadingProgress.loading;
  LoadingProgress get state => _state;
  set state(LoadingProgress value) {
    _state = value;
    notifyListeners();
  }

  bool _showProgressOverlay = false;
  bool get showProgressOverlay => _showProgressOverlay;
  set showProgressOverlay(bool value) {
    _showProgressOverlay = value;
    notifyListeners();
  }

  ProfileNumbers? numbers;

  Future<void> getNumbers() async {
    try {
      state = LoadingProgress.loading;
      await Future.delayed(const Duration(seconds: 1));
      numbers = ProfileNumbers(relatives: 3, followers: 10, subscriptions: 50);
      state = LoadingProgress.done;
    } catch (e) {
      state = LoadingProgress.error;
    }
  }

  Future<void> logout(BuildContext context) async {
    await getIt<UserNotifier>().logout();
  }
}
