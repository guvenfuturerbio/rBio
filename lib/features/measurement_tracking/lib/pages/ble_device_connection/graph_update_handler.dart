import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/database/SqlitePersistence.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/database/datamodels/glucose_data.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/database/repository/glucose_repository.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/notifiers/bg_measurements_notifiers.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/ble_device_connection/ble_reading_tagger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'ble_reading_tagger_list.dart';

class GraphUpdateHandler with ChangeNotifier {
  static final GraphUpdateHandler _instance = GraphUpdateHandler._internal();

  factory GraphUpdateHandler() {
    return _instance;
  }

  GraphUpdateHandler._internal() {}

  bool _shouldRefresh = false;

  bool get shouldRefresh => _shouldRefresh;

  void setRefresh(bool newValue) {
    _shouldRefresh = newValue;
    notifyListeners();
  }
}
