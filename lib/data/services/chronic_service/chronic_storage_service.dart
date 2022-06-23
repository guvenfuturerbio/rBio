import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:hive/hive.dart';

import '../../../../model/bg_measurement/blood_glucose_value_detail_model.dart';
import '../../../../model/bg_measurement/blood_glucose_value_model.dart';
import '../../../../model/bg_measurement/delete_bg_measurement_request.dart';
import '../../../../model/bg_measurement/get_blood_glucose_data_of_person.dart';
import '../../../../model/bg_measurement/update_bg_measurement_request.dart';
import '../../../../model/bp_measurement/add_bp_mesaurement.dart';
import '../../../../model/bp_measurement/delete_bp_measurement.dart';
import '../../../../model/bp_measurement/get_bp_measurement.dart';
import '../../../../model/bp_measurement/update_bp_measurement.dart';
import '../../../core/core.dart';

part 'blood_pressure_storage_impl.dart';
part 'glucose_storage_impl.dart';
part 'profile_storage_impl.dart';

abstract class ChronicStorageService<T extends HiveObject>
    extends ChangeNotifier {
  late String boxKey;
  late Box<T> box;

  Future<void> init();

  T? get(key);

  List<T> getAll();

  T? getLatestMeasurement();

  Future<bool> write(T data, {bool shouldSendToServer = false});

  Future<bool> writeAll(List<T> data);

  Future<bool> update(T data, key);

  Future<bool> delete(key);

  bool doesExist(T data);

  void clear();

  /// Remote definition
  Future deleteFromServer(
      int timeKey, Map<String, dynamic> deleteMeasurementRequest);
  Future sendToServer(T data);
  Future updateServer(T data);
}
