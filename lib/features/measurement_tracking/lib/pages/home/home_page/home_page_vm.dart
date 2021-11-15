import 'package:flutter/material.dart';
import 'package:onedosehealth/core/utils/pop_up/scale_tagger/scale_tagger_pop_up.dart';
import 'package:onedosehealth/database/datamodels/glucose_data.dart';
import 'package:onedosehealth/pages/ble_device_connection/ble_reading_tagger.dart';

class HomePageVm extends ChangeNotifier {
  PageController controller;
  int selectedPage = 0;
  ChangeNotifier provider;
  HomePageVm() {
    controller = PageController(initialPage: 0);
  }
  void changePage(int page) {
    selectedPage = page;
    notifyListeners();
  }

  showBleReadingTagger(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        switch (selectedPage) {
          case 0:
            return BleReadingTagger(
              lastReading: GlucoseData(
                  level: "0",
                  tag: null,
                  deviceName: "Manual",
                  time: (DateTime.now()).millisecondsSinceEpoch,
                  device: 1,
                  note: ""),
              isManual: true,
            );
          case 1:
            return ScaleTagger();
          default:
            throw Exception('Page not valid range is range must be 0:1');
        }
      },
    );
  }
}
