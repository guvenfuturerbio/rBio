import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/locator.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/user_profiles/user_profiles.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/notifiers/user_profiles_notifier.dart';

class SliderHandler with ChangeNotifier {
  UserProfilesNotifier _userRepository = locator<UserProfilesNotifier>();
  RangeValues currentRangeValues;
  SliderHandler() {
    currentRangeValues = RangeValues(
        _userRepository.selection.rangeMin.toDouble(),
        _userRepository.selection.rangeMax.toDouble());
  }

  changeValues(values) {
    currentRangeValues = values;
    notifyListeners();
  }
}
