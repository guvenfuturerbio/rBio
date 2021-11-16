import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/database/SqlitePersistence.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/database/datamodels/glucose_data.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/utils/progress/progress_dialog.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/bg_measurement/blood_glucose_value_detail_model.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/bg_measurement/blood_glucose_value_model.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/bg_measurement/delete_bg_measurement_request.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/bg_measurement/update_bg_measurement_request.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/notifiers/stripcount_tracker.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/notifiers/user_profiles_notifier.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/utils/base_provider_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class GlucoseRepository extends ChangeNotifier {
  static final GlucoseRepository _instance = GlucoseRepository._internal();
  BuildContext context;
  GlucoseData _lastMeasurement;
  ProgressDialog progressDialog;
  factory GlucoseRepository() {
    return _instance;
  }

  List<GlucoseData> _glucoseDataList = [];
  GlucoseRepository._internal() {
    initialize();
  }

  List<GlucoseData> get currentUserData => _glucoseDataList;
  String _localDirectoryPath = "";
  String get localDirectory => _localDirectoryPath;

  Future initialize() async {
    _glucoseDataList.clear();
    _localDirectoryPath = (await getApplicationDocumentsDirectory()).path;
    notifyListeners();
  }

  Future<bool> deleteAllGlucoseData() async {
    Database db = await DatabaseHelper.instance.database;
    var queryResult = await db.rawQuery('DELETE FROM ${GlucoseData.TABLE}');
    _lastMeasurement = null;
    notifyListeners();
    if (queryResult.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<GlucoseData>> getAllGlucoseData() async {
    _glucoseDataList.clear();
    Database db = await DatabaseHelper.instance.database;
    int userId = UserProfilesNotifier().selection?.id ?? 0;
    var queryResult = await db.rawQuery(
        'SELECT * FROM ${GlucoseData.TABLE} WHERE ${GlucoseData.USER_ID} = $userId ORDER BY ${GlucoseData.TIME} DESC');
    if (queryResult.isEmpty) {
      _glucoseDataList.clear();
      return [];
    } else {
      List<GlucoseData> allData = [];
      for (var n in queryResult) {
        _glucoseDataList.add(new GlucoseData().fromMap(n));
        allData.add(new GlucoseData().fromMap(n));
      }
      print("Last Measurement " + _glucoseDataList[0].toString());
      notifyListeners();
      return allData;
    }
  }

  /// MG2
  /// MG3
  /// MG4
  Future<int> addNewGlucoseData(
      GlucoseData glucoseData, bool shouldSendToServer) async {
    Map<String, dynamic> row = glucoseDataToMap(glucoseData);
    Database db = await DatabaseHelper.instance.database;
    final id = await db.insert(GlucoseData.TABLE, row);
    //DatabaseHelper.instance.queryAllRows();
    print('INSERTED new GLUCOSE id: $id Data: $glucoseData');
    print('time: ${glucoseData.time}');
    _glucoseDataList.add(glucoseData);
    if (_lastMeasurement == null) {
      _lastMeasurement = glucoseData;
    } else if (_lastMeasurement.time < glucoseData.time) {
      _lastMeasurement = glucoseData;
    }
    notifyListeners();

    if (shouldSendToServer) {
      if (glucoseData.manual == false) {
        StripCountTracker.decrementAndSave(1);
      }

      sendToServer(glucoseData);
    }

    return id;
  }

  Future<void> addNewGlucoseDataList(List<GlucoseData> glucoseDataList) async {
    Database db = await DatabaseHelper.instance.database;
    for (var glucoseData in glucoseDataList) {
      Map<String, dynamic> row = glucoseDataToMap(glucoseData);
      if (!(await doesDataExist(glucoseData.time))) {
        try {
          await db.insert(GlucoseData.TABLE, row);
        } catch (e) {
          print("Db Insert Error " + e.toString());
        }
      }
    }
  }

  Future<bool> doesDataExist(int timeKey) async {
    Database db = await DatabaseHelper.instance.database;
    var queryResult = await db
        .rawQuery('SELECT * FROM ${GlucoseData.TABLE} WHERE time="$timeKey"');
    if (queryResult.isEmpty || queryResult == null) {
      return false; // data is new
    } else {
      return true; // data exist
    }
  }

  Future<bool> updateMeasurementTag(int newTag, int timeKey) async {
    Database db = await DatabaseHelper.instance.database;
    var queryResult = await db
        .rawQuery('SELECT * FROM ${GlucoseData.TABLE} WHERE time="$timeKey"');
    if (queryResult.isEmpty) {
      notifyListeners();
      return false;
    } else {
      var qRes = await db.rawUpdate(
          'UPDATE ${GlucoseData.TABLE} SET ${GlucoseData.TAG} = $newTag WHERE ${GlucoseData.TIME} = $timeKey');
      print("Update Measurement Result = $qRes");
      for (int i = 0; i < _glucoseDataList.length; i++) {
        if (_glucoseDataList[i].time == timeKey) {
          _glucoseDataList[i].tag = newTag;
          break;
        }
      }
      notifyListeners();
      return true;
    }
  }

  Future<bool> updateMeasurementImageUrl(String path, int timeKey) async {
    Database db = await DatabaseHelper.instance.database;
    var queryResult = await db
        .rawQuery('SELECT * FROM ${GlucoseData.TABLE} WHERE time="$timeKey"');
    if (queryResult.isEmpty) {
      notifyListeners();
      return false;
    } else {
      var qRes = await db.rawUpdate(
          'UPDATE ${GlucoseData.TABLE} SET ${GlucoseData.IMAGE_URL} = "$path" WHERE ${GlucoseData.TIME} = $timeKey');
      print("Update Measurement Result = $qRes");
      for (int i = 0; i < _glucoseDataList.length; i++) {
        if (_glucoseDataList[i].time == timeKey) {
          _glucoseDataList[i].imageURL = path;
          break;
        }
      }
      notifyListeners();

      sendImageToServer(path, timeKey);
      return true;
    }
  }

  Future<bool> deleteMeasurementById(int timeKey) async {
    Database db = await DatabaseHelper.instance.database;
    var queryResult = await db
        .rawQuery('SELECT * FROM ${GlucoseData.TABLE} WHERE time="$timeKey"');
    if (queryResult.isEmpty) {
      notifyListeners();
      return false;
    } else {
      var qRes = await db.rawUpdate(
          'Delete from ${GlucoseData.TABLE} WHERE ${GlucoseData.TIME} = $timeKey');
      print("Update Measurement Result = $qRes");
      for (int i = 0; i < _glucoseDataList.length; i++) {
        if (_glucoseDataList[i].time == timeKey) {
          deleteFromServer(
              timeKey,
              DeleteBloodGlucoseMeasurementRequest(
                  entegrationId: UserProfilesNotifier().selection.id,
                  measurementId: _glucoseDataList[i].measurementId));
          _glucoseDataList.removeAt(i);
          getLatestMeasurement();
          break;
        }
      }

      /// MGH1
      notifyListeners();
      return true;
    }
  }

  void setLastMeasurement(timeKey) {
    if (_lastMeasurement.time == timeKey) {
      if (_glucoseDataList.isNotEmpty) {
        int time = DateTime.now().microsecondsSinceEpoch;
        int _lowestVal = 99999999999;
        int _lowestIndex = 0;
        for (var i = 0; i < _glucoseDataList.length; i++) {
          if (time - _glucoseDataList[i].time < _lowestVal) {
            _lowestVal = time - _glucoseDataList[i].time;
            _lowestIndex = i;
          }
        }
        _lastMeasurement = _glucoseDataList[_lowestIndex];
      } else {
        _lastMeasurement = null;
      }
    }
  }

  GlucoseData get lastMeasurement => _lastMeasurement;

  Future<GlucoseData> getLatestMeasurement() async {
    int userId = UserProfilesNotifier().selection?.id ?? 0;
    print("USER ID = $userId");
    Database db = await DatabaseHelper.instance.database;
    var queryResult = await db.rawQuery(
        'SELECT * FROM ${GlucoseData.TABLE} WHERE ${GlucoseData.USER_ID} = $userId ORDER BY ${GlucoseData.TIME} DESC LIMIT 1');
    if (queryResult.isEmpty) {
      _lastMeasurement = null;
      print("_lastMeasurement is null queryResult.isEmpty -> CAGDAS");
      notifyListeners();
      return null; // data is new
    } else {
      List<GlucoseData> allData = [];
      for (var n in queryResult) {
        allData.add(new GlucoseData().fromMap(n));
      }
      _lastMeasurement = allData.length > 0 ? allData[0] : null;
      print("_lastMeasurement is $_lastMeasurement -> CAGDAS");
      notifyListeners();
      return allData.length > 0 ? allData[0] : null; // data is old
    }
  }

  Future<bool> updateGlucoseData(
      GlucoseData glucoseData, bool shouldUpdate) async {
    Database db = await DatabaseHelper.instance.database;
    Map<String, dynamic> row = glucoseDataToMap(glucoseData);
    final numberOfChanges = await db.update(GlucoseData.TABLE, row,
        where: '${GlucoseData.TIME} = ?', whereArgs: [glucoseData.time]);
    print("number of changes made $numberOfChanges");
    for (int i = 0; i < _glucoseDataList.length; i++) {
      if (_glucoseDataList[i].time == glucoseData.time) {
        if (shouldUpdate) {
          updateServer(glucoseData);
        }
        _glucoseDataList[i] = glucoseData;
        getLatestMeasurement();
        break;
      }
    }

    notifyListeners();
    return numberOfChanges != 0;
  }

  /// In class utilities
  Future sendToServer(GlucoseData glucoseData) async {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(glucoseData.time);
    int userId = UserProfilesNotifier().selection?.id ?? 0;
    String dtFrmt = dt.toString();
    BloodGlucoseValue bloodGlucoseValue = new BloodGlucoseValue(
        deviceUUID: glucoseData.deviceUUID,
        isManual: glucoseData.manual,
        id: userId,
        value: glucoseData.level,
        valueNote: glucoseData.note,
        detail:
            new BloodGlucoseValueDetail(time: dtFrmt, tag: glucoseData.tag));
    BaseProviderRepository()
        .insertNewBloodGlucoseValue(bloodGlucoseValue, glucoseData);
  }

  Future deleteFromServer(
      int timeKey,
      DeleteBloodGlucoseMeasurementRequest
          deleteBloodGlucoseMeasurementRequest) async {
    BaseProviderRepository().deleteBloodGlucose(timeKey);
    BaseProviderRepository()
        .deleteBloodGlucoseValue(deleteBloodGlucoseMeasurementRequest);
  }

  Future updateServer(GlucoseData glucoseData) async {
    await BaseProviderRepository().updateBloodGlucoseValue(
        UpdateBloodGlucoseMeasurementRequest(
            entegrationId: UserProfilesNotifier().selection.id,
            measurementId: glucoseData.measurementId,
            tag: glucoseData.tag,
            value: int.parse(glucoseData.level),
            type: "mg",
            note: glucoseData.note,
            date: glucoseData.date));
  }

  void sendImageToServer(String imagePath, int measurementId) {
    BaseProviderRepository().uploadMeasurementImage(
        imagePath, UserProfilesNotifier().selection.id ?? 0, measurementId);
  }

  String getImagePathOfImageURL(String imageURL) {
    return "${_localDirectoryPath}/${imageURL}";
  }

  notify() {
    notifyListeners();
  }

  glucoseDataToMap(GlucoseData glucoseData) {
    Map<String, dynamic> row = {
      GlucoseData.LEVEL: glucoseData.level,
      GlucoseData.NOTE: glucoseData.note,
      GlucoseData.TAG: glucoseData.tag,
      GlucoseData.TIME: glucoseData.time,
      GlucoseData.IMAGE_URL: glucoseData.imageURL,
      GlucoseData.DEVICE_UUID: glucoseData.deviceUUID,
      GlucoseData.DEVICE: glucoseData.device,
      GlucoseData.DEVICE_NAME: glucoseData.deviceName,
      GlucoseData.MANUAL: glucoseData.manual,
      GlucoseData.IS_DELETED: glucoseData.isDeleted,
      GlucoseData.USER_ID: glucoseData.userId,
      GlucoseData.MEASUREMENT_ID: glucoseData.measurementId
    };
    return row;
  }
}
