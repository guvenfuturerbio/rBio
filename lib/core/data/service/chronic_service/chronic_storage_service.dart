import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../features/chronic_tracking/lib/notifiers/user_profiles_notifier.dart';
import '../../../../model/bg_measurement/blood_glucose_value_detail_model.dart';
import '../../../../model/bg_measurement/blood_glucose_value_model.dart';
import '../../../../model/bg_measurement/delete_bg_measurement_request.dart';
import '../../../../model/bg_measurement/get_blood_glucose_data_of_person.dart';
import '../../../../model/bg_measurement/update_bg_measurement_request.dart';
import '../../../../model/scale_measurement/add_scale_measurement.dart';
import '../../../../model/scale_measurement/delete_scale_measurement.dart';
import '../../../../model/scale_measurement/get_scale_measurement.dart';
import '../../../../model/scale_measurement/update_scale_measurement.dart';
import '../../../core.dart';
import '../../imports/cronic_tracking.dart';

part 'glucose_storage_impl.dart';
part 'profile_storage_impl.dart';
part 'scale_storage_impl.dart';

abstract class ChronicStorageService<T extends HiveObject>
    extends ChangeNotifier {
  String boxKey;
  Box<T> box;

  Future<void> init();

  T get(key);

  List<T> getAll();

  T getLatestMeasurement();

  Future<bool> write(T data, {bool shouldSendToServer = false});

  Future<bool> writeAll(List<T> data);

  Future<bool> update(T data, key);

  Future<bool> delete(key);

  bool doesExist(T data);

  /// Remote definition
  Future deleteFromServer(
      int timeKey, Map<String, dynamic> deleteMeasurementRequest);
  Future sendToServer(T data);
  Future updateServer(T data);
}
