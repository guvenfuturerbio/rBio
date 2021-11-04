import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class RelativesVm extends ChangeNotifier {
  LoadingProgress _state = LoadingProgress.LOADING;
  LoadingProgress get state => _state;
  set state(LoadingProgress value) {
    _state = value;
    notifyListeners();
  }

  List<PatientRelative> relatives;

  Future<void> getAll() async {
    state = LoadingProgress.LOADING;
    await Future.delayed(Duration(seconds: 1));
    relatives = [
      PatientRelative("Ahmet", "Yıldırım", "1", "1"),
      PatientRelative("Aylin", "Yıldırım", "2", "2"),
    ];
    state = LoadingProgress.DONE;
  }
}
