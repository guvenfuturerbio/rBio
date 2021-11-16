import 'package:flutter/material.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/core/utils/progress_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../notifiers/user_profiles_notifier.dart';
import '../SqlitePersistence.dart';
import '../datamodels/scale_data.dart';

class ScaleRepository extends ChangeNotifier {
  BuildContext context;
  ScaleModel _lastMeasurement;
  ProgressDialog progressDialog;
  Database _db;

  List<ScaleModel> get currentUserData => _scaleDataList;

  List<ScaleModel> _scaleDataList = <ScaleModel>[];
  String _localDirectoryPath = "";
  String get localDirectory => _localDirectoryPath;

  static final ScaleRepository _instance = ScaleRepository._internal();
  factory ScaleRepository() => _instance;
  ScaleRepository._internal() {
    initialize();
  }
  Future<void> initialize() async {
    _db = await DatabaseHelper.instance.database;

    _scaleDataList.clear();
    _localDirectoryPath = (await getApplicationDocumentsDirectory()).path;
    notifyListeners();
  }

  Future<int> addNewScaleData(
      ScaleModel scaleModel, bool shouldSendToServer) async {
    Map<String, dynamic> row = scaleModel.toMap();
    if (!(await doesDataExist(scaleModel.time))) {
      final id = await _db.insert(ScaleModel.TABLE, row);
      //DatabaseHelper.instance.queryAllRows();
      print('INSERTED new Scale id: $id Data: $scaleModel');
      print('time: ${scaleModel.time}');
      _scaleDataList.add(scaleModel);
      print(_lastMeasurement);
      if (_lastMeasurement == null ||
          ((_lastMeasurement.time ?? 0) < scaleModel.time)) {
        _lastMeasurement = scaleModel;
      }
      notifyListeners();

      if (shouldSendToServer) {
        sendToServer(scaleModel);
      }

      return id;
    } else {
      return -1;
    }
  }

  Future<void> addNewScaleDataList(List<ScaleModel> scaleModelList) async {
    for (var scaleModel in scaleModelList) {
      Map<String, dynamic> row = scaleModel.toMap();
      if (!(await doesDataExist(scaleModel.time))) {
        try {
          await _db.insert(ScaleModel.TABLE, row);
        } catch (e) {
          print("Db Insert Error " + e.toString());
        }
      }
    }
  }

  Future<bool> doesDataExist(int timeKey) async {
    var queryResult = await _db
        .rawQuery('SELECT * FROM ${ScaleModel.TABLE} WHERE time="$timeKey"');
    if (queryResult.isEmpty || queryResult == null) {
      return false; // data is new
    } else {
      return true; // data exist
    }
  }

  Future<bool> updateMeasurementImageUrl(
      List<String> pathList, int timeKey) async {
    var queryResult = await _db
        .rawQuery('SELECT * FROM ${ScaleModel.TABLE} WHERE time="$timeKey"');
    if (queryResult.isEmpty) {
      notifyListeners();
      return false;
    } else {
      var imageOne = '';
      var imageTwo = '';
      var imageThree = '';
      if (pathList.isNotEmpty) {
        if (pathList.length == 1) {
          imageOne = pathList[0];
        } else if (pathList.length == 1) {
          imageOne = pathList[0];
          imageTwo = pathList[1];
        } else if (pathList.length == 2) {
          imageOne = pathList[0];
          imageTwo = pathList[1];
          imageThree = pathList[2];
        }
      }
      var qRes = await _db.rawUpdate(
          'UPDATE ${ScaleModel.TABLE} SET ${ScaleModel.IMAGE_ONE} = "$imageOne" ${ScaleModel.IMAGE_TWO} = "$imageTwo}" ${ScaleModel.IMAGE_THREE} = "$imageThree" WHERE ${ScaleModel.TIME} = $timeKey');
      print("Update Measurement Result = $qRes");
      for (int i = 0; i < _scaleDataList.length; i++) {
        if (_scaleDataList[i].time == timeKey) {
          _scaleDataList[i].images = pathList;
          break;
        }
      }
      notifyListeners();

      sendImageToServer(pathList, timeKey);
      return true;
    }
  }

  Future<bool> deleteAllScaleData() async {
    var queryResult = await _db.rawQuery('DELETE FROM ${ScaleModel.TABLE}');
    _lastMeasurement = null;
    _scaleDataList.clear();
    notifyListeners();
    if (queryResult.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ScaleModel>> getAllScaleData() async {
    int userId = UserProfilesNotifier().selection?.id ?? 0;

    var queryResult = await _db.rawQuery(
        'SELECT * FROM ${ScaleModel.TABLE} WHERE ${ScaleModel.USER_ID} = $userId ORDER BY ${ScaleModel.DATE_TIME} DESC');

    if (queryResult.isEmpty) {
      _scaleDataList.clear();
      return [];
    } else {
      List<ScaleModel> allData = [];

      for (var n in queryResult) {
        //print("QueryResult Single: $n");
        var scaleData = ScaleModel.fromMap(n);
        _scaleDataList.add(scaleData);
      }
      print("Last Measurement " + _scaleDataList[0].toString());
      notifyListeners();
      return allData;
    }
  }

  Future<bool> deleteMeasurementById(int timeKey) async {
    var queryResult = await _db.rawQuery(
        'SELECT * FROM ${ScaleModel.TABLE} WHERE ${ScaleModel.TIME}="$timeKey"');
    if (queryResult.isEmpty) {
      return false;
    } else {
      var qRes = await _db.rawUpdate(
          'Delete from ${ScaleModel.TABLE} WHERE ${ScaleModel.TIME} = $timeKey');
      print("Update Measurement Result = $qRes");
      for (int index = 0; index < _scaleDataList.length; index++) {
        if (_scaleDataList[index].time == timeKey) {
          deleteFromServer(timeKey, index);
          _scaleDataList.removeAt(index);
          getLatestMeasurement();
          break;
        }
      }
      notifyListeners();
      return true;
    }
  }

  Future<bool> updateScaleData(ScaleModel scaleModel, bool shouldUpdate) async {
    Map<String, dynamic> row = scaleModel.toMap();
    final numberOfChanges = await _db.update(ScaleModel.TABLE, row,
        where: '${ScaleModel.TIME} = ?', whereArgs: [scaleModel.time]);
    print("number of changes made $numberOfChanges");
    for (int i = 0; i < _scaleDataList.length; i++) {
      if (_scaleDataList[i].time == scaleModel.time) {
        if (shouldUpdate) {
          updateServer(scaleModel);
        }
        _scaleDataList[i] = scaleModel;
        getLatestMeasurement();
        break;
      }
    }

    notifyListeners();
    return numberOfChanges != 0;
  }

  ScaleModel get lastMeasurement => _lastMeasurement;

  Future<ScaleModel> getLatestMeasurement() async {
    int userId = UserProfilesNotifier().selection?.id ?? 0;
    print("USER ID = $userId");
    var queryResult = await _db.rawQuery(
        'SELECT * FROM ${ScaleModel.TABLE} WHERE ${ScaleModel.USER_ID} = $userId ORDER BY ${ScaleModel.TIME} DESC LIMIT 1');

    print(queryResult);
    if (queryResult.isEmpty) {
      _lastMeasurement = null;
      print("_lastMeasurement is null queryResult.isEmpty -> CAGDAS");
      notifyListeners();
      return null; // data is new
    } else {
      List<ScaleModel> allData = [];
      for (var n in queryResult) {
        allData.add(new ScaleModel.fromMap(n));
      }
      _lastMeasurement = allData.length > 0 ? allData[0] : null;
      print("_lastMeasurement is $_lastMeasurement -> CAGDAS");
      notifyListeners();
      return allData.length > 0 ? allData[0] : null; // data is old
    }
  }

  Future sendToServer(ScaleModel scaleModel) async {}
  Future sendImageToServer(List<String> pathList, int timeKey) async {}
  Future updateServer(ScaleModel scaleModel) async {}
  Future deleteFromServer(int timeKey, int index) async {}
  String getImagePathOfImageURL(String imageURL) {
    return "${_localDirectoryPath}/${imageURL}";
  }
}
