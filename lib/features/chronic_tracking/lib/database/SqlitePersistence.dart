import 'dart:io';

import '../../../../core/core.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'datamodels/scale_data.dart';

final table = 'userlogininfo';

final columnUser = 'username';
final columnPass = 'password';
final columnToken = 'token';

// SQL code to upgrade tables
final initialScript = [
  '''
    CREATE TABLE IF NOT EXISTS $table (
      $columnUser String PRIMARY KEY,
      $columnPass String NOT NULL,
      $columnToken String NOT NULL
    )
  ''',
  '''
    CREATE TABLE IF NOT EXISTS ${ScaleModel.TABLE} (
      ${ScaleModel.TIME} integer primary key not null,
      ${ScaleModel.DEVICE} string,
      ${ScaleModel.BMI} real not null,
      ${ScaleModel.BODY_FAT} real ,
      ${ScaleModel.BONE_MASS} real,
      ${ScaleModel.DATE_TIME} text not null,
      ${ScaleModel.HEIGHT} real not null,
      ${ScaleModel.MANUEL} int not null,
      ${ScaleModel.MEASUREMENT_ID} int not null,
      ${ScaleModel.VISCERAL_FAT} real,
      ${ScaleModel.WATER} real ,
      ${ScaleModel.MUSCLE} real,
      ${ScaleModel.IS_DELETED} int not null,
      ${ScaleModel.WEIGHT} real not null,
      ${ScaleModel.USER_ID} text not null,
      ${ScaleModel.IMAGE_ONE} text,
      ${ScaleModel.IMAGE_TWO} text,
      ${ScaleModel.IMAGE_THREE} text,
      ${ScaleModel.NOTE} text not null
    );
  ''',
  '''
    CREATE TABLE IF NOT EXISTS ${GlucoseData.TABLE} (
      ${GlucoseData.TIME} integer primary key not null,
      ${GlucoseData.LEVEL} text not null,
      ${GlucoseData.TAG} integer,
      ${GlucoseData.NOTE} text,
      ${GlucoseData.DEVICE} integer,
      ${GlucoseData.MANUAL} boolean,
      ${GlucoseData.DEVICE_UUID} text not null,
      ${GlucoseData.DEVICE_NAME} text not null,
      ${GlucoseData.IMAGE_URL} text,
      ${GlucoseData.IS_DELETED} boolean,
      ${GlucoseData.USER_ID} integer,
      ${GlucoseData.MEASUREMENT_ID} integer
    );
  ''',
  '''
    CREATE TABLE IF NOT EXISTS ${Person.TABLE} (
      ${Person.ID} integer primary key autoincrement not null,
      ${Person.HEIGHT} integer,
      ${Person.WEIGHT} integer,
      ${Person.HYPO} integer,
      ${Person.RANGE_MIN} integer,
      ${Person.RANGE_MAX} integer,
      ${Person.HYPER} integer,
      ${Person.DEVICE_UUID} text,
      ${Person.IMAGE_URL} text,
      ${Person.BIRTH_DATE} text,
      ${Person.NAME} text,
      ${Person.GENDER} text,
      ${Person.DIABETES_TYPE} text,
      ${Person.YEAR_OF_DIGANOSIS} text,
      ${Person.SMOKER} boolean,
      ${Person.MANUFACTURER_ID} integer
    );
  '''
];

var dropPerson = "DROP TABLE ${Person.TABLE}";
var createPerson = initialScript[2];

var dropTables = "DROP TABLE ${Person.TABLE}";

final migrationScripts = [dropPerson, createPerson];

class DatabaseHelper {
  static final _databaseName = "onedosesugar.db";
  static final _databaseVersion = 3;

  static final table = 'userlogininfo';

  static final columnUser = 'username';
  static final columnPass = 'password';
  static final columnToken = 'token';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)

  //final config = MigrationConfig(initializationScript: initialScript, migrationScripts: migrationScripts);

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    //return await openDatabase(path,version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    for (var i = 0; i < initialScript.length; i++) {
      await db.execute(initialScript[i]);
    }
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    initialScript.forEach((script) async {
      try {
        await db.execute(script);
      } catch (_) {}
    });
  }
  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<String> getJwtToken() async {
    Database db = await instance.database;
    List<Map> list = await db.rawQuery("select token from $table");
    String jwtToken = "";
    jwtToken = list[0]["token"];
    return jwtToken;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String id = row[columnUser];
    return await db
        .update(table, row, where: '$columnUser = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<void> delete(String id) async {
    Database db = await instance.database;
    return await db.execute("Delete from " + table);
  }

  Future<int> insertGlucoseMeasurement(
      int level, int time, int tag, String note) async {
    Map<String, dynamic> row = {
      "level": level,
      "time": time,
      "tag": tag,
      "note": note
    };

    Database db = await instance.database;
    return await db.insert("glucose", row);
  }

  Future<int> addNewGlucoseData(GlucoseData glucoseData) async {
    Map<String, dynamic> row = {
      GlucoseData.LEVEL: glucoseData.level,
      GlucoseData.NOTE: glucoseData.note,
      GlucoseData.TAG: glucoseData.tag,
      GlucoseData.TIME: glucoseData.time
    };
    Database db = await DatabaseHelper.instance.database;
    final id = await db.insert(GlucoseData.TABLE, row);
    //DatabaseHelper.instance.queryAllRows();
    print('INSERTED new GLUCOSE id: $id Data: $glucoseData');
    print('time: ${glucoseData.time}');
    return id;
  }
}
