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
}