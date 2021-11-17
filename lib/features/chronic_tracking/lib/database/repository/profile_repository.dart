import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/user_profiles/person.dart';
import '../../widgets/utils/base_provider_repository.dart';
import '../SqlitePersistence.dart';
import 'glucose_repository.dart';

class ProfileRepository with ChangeNotifier {
  static final ProfileRepository _instance = ProfileRepository._internal();
  BuildContext context;

  factory ProfileRepository() {
    return _instance;
  }
  ProfileRepository._internal() {
    _activeProfile = new Person().fromDefault();
  }

  Person _activeProfile;
  Person get activeProfile => _activeProfile;

  Future<List<Person>> getAllProfiles() async {
    Database db = await DatabaseHelper.instance.database;
    var queryResult = await db.rawQuery('SELECT * FROM ${Person.TABLE}');
    if (queryResult.isEmpty) {
      return null;
    } else {
      List<Person> allData = [];
      for (var n in queryResult) {
        //print("lel $n");
        allData.add(new Person().fromMap(n));
      }
      return allData;
    }
  }

  void refresh() {
    print("REfreshing");
    notifyListeners();
  }

  Future<List<Person>> getProfileDataByUserId(int userId) async {
    Database db = await DatabaseHelper.instance.database;
    var queryResult = await db
        .rawQuery('SELECT * FROM ${Person.TABLE} WHERE ${Person.ID} = $userId');
    if (queryResult.isEmpty) {
      return null;
    } else {
      List<Person> allData = [];
      for (var n in queryResult) {
        //print("lel $n");
        allData.add(new Person().fromMap(n));
      }
      if (allData.length > 0) {
        _activeProfile = allData[0];
      }
      notifyListeners();
      return allData;
    }
  }

  Future<bool> deleteAllProfiles() async {
    Database db = await DatabaseHelper.instance.database;
    var queryResult = await db.rawQuery('DELETE FROM ${Person.TABLE}');
    await GlucoseRepository().deleteAllGlucoseData();
    // await ScaleRepository().deleteAllScaleData();
    notifyListeners();
    if (queryResult.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Person>> getProfileById(int id) async {
    Database db = await DatabaseHelper.instance.database;
    var queryResult = await db
        .rawQuery('SELECT * FROM ${Person.TABLE} WHERE ${Person.ID} = $id');
    if (queryResult.isEmpty) {
      return null;
    } else {
      List<Person> allData = [];
      for (var n in queryResult) {
        //print("lel $n");
        allData.add(new Person().fromMap(n));
      }
      return allData;
    }
  }

  Future<bool> addProfile(Person person, bool shouldSendToServer) async {
    Map<String, dynamic> row = {
      Person.ID: person.id,
      Person.HEIGHT: person.height,
      Person.WEIGHT: person.weight,
      Person.HYPO: person.hypo,
      Person.RANGE_MIN: person.rangeMin,
      Person.RANGE_MAX: person.rangeMax,
      Person.HYPER: person.hyper,
      Person.DEVICE_UUID: person.deviceUUID,
      Person.IMAGE_URL: person.imageURL,
      Person.NAME: person.name,
      Person.BIRTH_DATE: person.birthDate,
      Person.YEAR_OF_DIGANOSIS: person.yearOfDiagnosis,
      Person.SMOKER: person.smoker
    };
    Database db = await DatabaseHelper.instance.database;
    var checker = await db.rawQuery(
        'SELECT * FROM ${Person.TABLE} WHERE ${Person.ID} = ${person.id}');
    if (checker.isNotEmpty) {
      _activeProfile = Person().fromMap(checker[0]);

      return true;
    }
    final id = await db.insert(Person.TABLE, row);

    var queryResult = await db
        .rawQuery('SELECT * FROM ${Person.TABLE} WHERE ${Person.ID} = $id');
    _activeProfile = Person().fromMap(queryResult[0]);
    notifyListeners();

    if (shouldSendToServer) {
      await sendToServer(person);
    }

    if (queryResult.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> sendToServer(Person person) async {
    await BaseProviderRepository().addProfile(person);
  }

  Future<bool> updateProfile(Person person) async {
    Map<String, dynamic> row = {
      Person.ID: person.id,
      Person.HEIGHT: person.height,
      Person.WEIGHT: person.weight,
      Person.HYPO: person.hypo,
      Person.RANGE_MIN: person.rangeMin,
      Person.RANGE_MAX: person.rangeMax,
      Person.HYPER: person.hyper,
      Person.DEVICE_UUID: person.deviceUUID,
      Person.IMAGE_URL: person.imageURL,
      Person.NAME: person.name,
      Person.BIRTH_DATE: person.birthDate,
      Person.YEAR_OF_DIGANOSIS: person.yearOfDiagnosis,
      Person.SMOKER: person.smoker
    };

    Database db = await DatabaseHelper.instance.database;
    await db.update(Person.TABLE, row,
        where: "${Person.ID} = ?", whereArgs: [person.id]);
    //print(await db.query(Person.TABLE));
    if (_activeProfile.id == person.id) {
      _activeProfile = person;
    }
    notifyListeners();
    return true;
  }

  /// UPDATE FUNCTIONS
  Future<bool> updateNameById(int id, String newName) async {
    Database db = await DatabaseHelper.instance.database;

    // Prevent SQL Injection
    newName = removeSqlInjectionCharacters(newName);
    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.NAME} = "$newName" WHERE ${Person.ID} = $id');
    print('-------------->$queryResult');
    if (queryResult == 0) {
      print("Name update failed! name: $newName");
      List<Person> pd = await getProfileById(id);
      _activeProfile = pd[0];
      print("Pd size ${pd.length}");
      return false;
    } else {
      print("Name update SUCCESS!");
      getProfileDataByUserId(id);
      return true;
    }
  }

  Future<bool> updateGenderById(int id, String newGender) async {
    Database db = await DatabaseHelper.instance.database;

    // Prevent SQL Injection
    newGender = removeSqlInjectionCharacters(newGender);

    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.GENDER} = "$newGender" WHERE ${Person.ID} = $id');
    if (queryResult == 0) {
      return false;
    } else {
      getProfileDataByUserId(id);
      return true;
    }
  }

  Future<bool> updateBirthDateById(int id, String birthDate) async {
    Database db = await DatabaseHelper.instance.database;

    // Prevent SQL Injection
    birthDate = removeSqlInjectionCharacters(birthDate);

    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.BIRTH_DATE} = "$birthDate" WHERE ${Person.ID} = $id');
    if (queryResult == 0) {
      return false;
    } else {
      getProfileDataByUserId(id);
      return true;
    }
  }

  Future<bool> updateHeightById(int id, int height) async {
    Database db = await DatabaseHelper.instance.database;

    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.HEIGHT} = $height WHERE ${Person.ID} = $id');
    if (queryResult == 0) {
      return false;
    } else {
      getProfileDataByUserId(id);
      return true;
    }
  }

  Future<bool> updateWeightById(int id, int weight) async {
    Database db = await DatabaseHelper.instance.database;

    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.WEIGHT} = $weight WHERE ${Person.ID} = $id');
    if (queryResult == 0) {
      return false;
    } else {
      getProfileDataByUserId(id);
      return true;
    }
  }

  Future<bool> updateDiabetesTypeById(int id, String diabetesType) async {
    Database db = await DatabaseHelper.instance.database;

    // Prevent SQL Injection
    diabetesType = removeSqlInjectionCharacters(diabetesType);

    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.DIABETES_TYPE} = "$diabetesType" WHERE ${Person.ID} = $id');
    if (queryResult == 0) {
      return false;
    } else {
      getProfileDataByUserId(id);
      return true;
    }
  }

  Future<bool> updateMinAndMax(int id, int min, int max) async {
    try {
      Database db = await DatabaseHelper.instance.database;

      var queryResult = await db.rawQuery(
          'UPDATE ${Person.TABLE} SET ${Person.RANGE_MIN} = $min WHERE ${Person.ID} = $id');
      await db.rawQuery(
          'UPDATE ${Person.TABLE} SET ${Person.RANGE_MAX} = $max WHERE ${Person.ID} = $id');

      _activeProfile.rangeMin = min;
      _activeProfile.rangeMax = max;
      if (queryResult == 0) {
        return false;
      } else {
        getProfileDataByUserId(id);

        return true;
      }
    } catch (e) {
      print(e);
      throw Exception('minMax Ex +${e.toString()}');
    }
  }

  Future<bool> updateHypo(int id, int hypo) async {
    Database db = await DatabaseHelper.instance.database;

    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.HYPO} = $hypo WHERE ${Person.ID} = $id');

    if (queryResult == 0) {
      return false;
    } else {
      getProfileDataByUserId(id);

      return true;
    }
  }

  Future<bool> updateHyper(int id, int hyper) async {
    Database db = await DatabaseHelper.instance.database;

    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.HYPER} = $hyper WHERE ${Person.ID} = $id');

    if (queryResult == 0) {
      return false;
    } else {
      getProfileDataByUserId(id);
      return true;
    }
  }

  Future<bool> updateYearOfDiagnosis(int id, int year) async {
    Database db = await DatabaseHelper.instance.database;

    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.YEAR_OF_DIGANOSIS} = $year WHERE ${Person.ID} = $id');

    if (queryResult == 0) {
      return false;
    } else {
      getProfileDataByUserId(id);
      return true;
    }
  }

  Future<bool> updateIsSmoker(int id, bool smoker) async {
    Database db = await DatabaseHelper.instance.database;

    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.SMOKER} = $smoker WHERE ${Person.ID} = $id');

    if (queryResult == 0) {
      return false;
    } else {
      getProfileDataByUserId(id);
      return true;
    }
  }

  Future<bool> updateDeviceUUIDById(int id, String deviceUUID) async {
    Database db = await DatabaseHelper.instance.database;

    // Prevent SQL Injection
    deviceUUID = removeSqlInjectionCharacters(deviceUUID);

    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.DEVICE_UUID} = "$deviceUUID" WHERE ${Person.ID} = $id');
    notifyListeners();
    if (queryResult == 0) {
      return false;
    } else {
      getProfileDataByUserId(id);
      return true;
    }
  }

  Future<bool> updateDeviceManufacturerIdById(
      int id, int manufacturerId) async {
    Database db = await DatabaseHelper.instance.database;

    var queryResult = await db.rawUpdate(
        'UPDATE ${Person.TABLE} SET ${Person.MANUFACTURER_ID} = $manufacturerId WHERE ${Person.ID} = $id');
    if (queryResult == 0) {
      return false;
    } else {
      getProfileDataByUserId(id);
      return true;
    }
  }

  String removeSqlInjectionCharacters(String word) {
    if (word == null) return word;
    String retWord = word.replaceAll("'", "");
    retWord = retWord.replaceAll("\"", "");
    retWord = retWord.replaceAll(";", "");
    return retWord;
  }

  /// END UPDATE FUNCTIONS
}
