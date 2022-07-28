import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:hive/hive.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../../features/auth/shared/shared.dart';
import '../../../features/chronic_tracking/blood_glucose/model/model.dart';
import '../../../features/chronic_tracking/blood_pressure/model/model.dart';

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
