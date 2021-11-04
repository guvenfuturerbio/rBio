import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../model/devices_model.dart';

class DevicesVm extends ChangeNotifier {
  LoadingProgress _state = LoadingProgress.LOADING;
  LoadingProgress get state => _state;
  set state(LoadingProgress value) {
    _state = value;
    notifyListeners();
  }

  List<DevicesModel> devices;

  Future<void> getAll() async {
    state = LoadingProgress.LOADING;
    await Future.delayed(Duration(seconds: 1));
    devices = [
      DevicesModel(id: '1', title: 'Accu-Check Instant', image: 'https://www.diyabetevi.com/sites/g/files/iut911/f/styles/image_205x255/public/accu-chek_instant.png?itok=5MQow0iS'),
      DevicesModel(id: '2', title: 'Contour Plus One', image: 'https://www.tr.contourplusone.com/siteassets/img-tr/slide1-meter.png'),
    ];
    state = LoadingProgress.DONE;
  }
}
