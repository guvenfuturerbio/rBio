import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class RelativesVm extends ChangeNotifier {
  LoadingProgress _state = LoadingProgress.loading;
  LoadingProgress get state => _state;
  set state(LoadingProgress value) {
    _state = value;
    notifyListeners();
  }

  late PatientRelativeInfoResponse response;

  Future<void> getAll() async {
    state = LoadingProgress.loading;

    try {
      response = await getIt<Repository>().getAllRelatives();
      if (response.patientRelatives == []) {
        response = PatientRelativeInfoResponse([]);
      }
      state = LoadingProgress.done;
    } catch (e) {
      state = LoadingProgress.error;
    }
  }
}
