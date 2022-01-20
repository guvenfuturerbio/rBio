import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:onedosehealth/model/treatment_model/treatment_model.dart';

@HiveType(typeId: 2)
class Person extends HiveObject {
  static const ID = "id";
  static const USER_ID = 'entegration_id';
  static const IMAGE_URL = "image_url";
  static const NAME = "name";
  static const BIRTH_DATE = "birth_date";
  static const GENDER = "gender";
  static const HEIGHT = "height";
  static const WEIGHT = "weight";
  static const DIABETES_TYPE = "diabetes_type";
  static const HYPO = "hypo";
  static const RANGE_MIN = "range_min";
  static const RANGE_MAX = "range_max";
  static const HYPER = "hyper";
  static const DEVICE_UUID = "device_uuid";
  static const YEAR_OF_DIGANOSIS = "year_of_diagnosis";
  static const SMOKER = "smoker";
  static const MANUFACTURER_ID = "manufacturer_id";
  static const TABLE = "person";

  // Data
  static const DEFAULT_VERY_LOW = 36;
  static const DEFAULT_LOW = 91;
  static const DEFAULT_TARGET = 131;
  static const DEFAULT_HIGH = 151;
  static const DEFAULT_VERY_HIGH = 301;
  static const MAX_PERSON = 5;

  @HiveField(0)
  int userId;
  @HiveField(1)
  int id;
  @HiveField(2)
  String imageURL;
  @HiveField(3)
  String name;
  @HiveField(4)
  String birthDate;
  @HiveField(5)
  String gender;
  @HiveField(6)
  String height;
  @HiveField(7)
  String weight;
  @HiveField(8)
  String diabetesType;
  @HiveField(9)
  int hypo;
  @HiveField(10)
  int rangeMin;
  @HiveField(11)
  int target;
  @HiveField(12)
  int rangeMax;
  @HiveField(13)
  int hyper;
  @HiveField(14)
  String deviceUUID;
  @HiveField(15)
  int manufacturerId;
  @HiveField(16)
  int yearOfDiagnosis;
  @HiveField(17)
  bool smoker; // 0 non smoker , 1 smoker, 2 smokes occasionally, 3 smokes often
  @HiveField(18)
  bool isFirstUser;
  @HiveField(18)
  List<TreatmentModel> treatmentList;

  File profileImage = new File("");

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson({String treatment}) =>
      _$PersonToJson(this, treatment);

  Person fromDefault({
    @required String name,
    @required String lastName,
    @required String birthDate,
    @required String gender,
  }) {
    return Person(
        id: DateTime.now().millisecondsSinceEpoch,
        userId: -1,
        weight: "50",
        height: "170",
        hypo: DEFAULT_VERY_LOW,
        rangeMin: DEFAULT_LOW,
        target: DEFAULT_TARGET,
        rangeMax: DEFAULT_HIGH,
        hyper: DEFAULT_VERY_HIGH,
        deviceUUID: "",
        manufacturerId: 0,
        imageURL:
            "https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png",
        name: '${name} ${lastName}',
        birthDate: birthDate,
        gender: gender,
        diabetesType: 'nondia',
        yearOfDiagnosis: 2021,
        smoker: false,
        isFirstUser: false);
  }

  Person(
      {this.id = 1,
      this.imageURL = '',
      this.name = "",
      this.gender = '',
      this.birthDate = '',
      this.weight = '',
      this.height = '',
      this.diabetesType = '',
      this.rangeMin = 90,
      this.rangeMax = 160,
      this.hyper = 200,
      this.hypo = 50,
      this.target = 120,
      this.userId = 1,
      this.deviceUUID = "",
      this.manufacturerId = 0,
      this.yearOfDiagnosis = 2021,
      this.smoker = false,
      this.isFirstUser = false,
      this.treatmentList});

  Person copy() {
    final _json = toJson();
    final _jsonEncode = jsonEncode(_json);
    final _jsonDecode = jsonDecode(_jsonEncode);
    final person = Person.fromJson(_jsonDecode);
    return person;
  }

  @override
  bool operator ==(Object other) =>
      other is Person && other.userId == userId && other.id == id;

  bool isEqual(Person other) {
    return jsonEncode(this.toJson()) == jsonEncode(other.toJson());
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        id.hashCode ^
        imageURL.hashCode ^
        name.hashCode ^
        birthDate.hashCode ^
        gender.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        diabetesType.hashCode ^
        hypo.hashCode ^
        rangeMin.hashCode ^
        target.hashCode ^
        rangeMax.hashCode ^
        hyper.hashCode ^
        deviceUUID.hashCode ^
        manufacturerId.hashCode ^
        yearOfDiagnosis.hashCode ^
        smoker.hashCode ^
        isFirstUser.hashCode;
  }
}

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
    id: json['entegration_id'],
    imageURL: json['image_url'],
    name: json['name'],
    gender: json['gender'],
    birthDate: json['birth_day'],
    weight: json['weight'],
    height: json['height'],
    diabetesType: json['diabetes_type'],
    rangeMin: json['range_min'],
    rangeMax: json['range_max'],
    hyper: json['hyper'],
    hypo: json['hypo'],
    target: json['target'],
    userId: json['id'],
    deviceUUID: json['device_uuid'],
    manufacturerId: json['manufacturer_id'],
    yearOfDiagnosis: json['year_of_diagnosis'],
    smoker: json['smoker'] == null
        ? false
        : json['smoker'] == 0
            ? false
            : true,
    isFirstUser: json['is_first_user'] == null
        ? false
        : json['is_first_user'] == 0
            ? false
            : true,
    treatmentList: json['treatment_list'] != null
        ? (json['treatment_list'] as List)
            .map((e) => TreatmentModel.fromJson(e))
            .toList()
        : []);

Map<String, dynamic> _$PersonToJson(Person instance, String treatment) {
  var map = <String, dynamic>{
    'id': instance.userId,
    'entegration_id': instance.id,
    'image_url': instance.imageURL,
    'name': instance.name,
    'birth_day': instance.birthDate,
    'gender': instance.gender,
    'height': instance.height,
    'weight': instance.weight,
    'diabetes_type': instance.diabetesType,
    'hypo': instance.hypo,
    'range_min': instance.rangeMin,
    'target': instance.target,
    'range_max': instance.rangeMax,
    'hyper': instance.hyper,
    'device_uuid': instance.deviceUUID,
    'manufacturer_id': instance.manufacturerId,
    'year_of_diagnosis': instance.yearOfDiagnosis,
    'smoker': instance.smoker,
    'is_first_user': instance.isFirstUser,
  };

  if (treatment != null) {
    map['treatment'] = treatment;
  }
  return map;
}

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 2;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
        id: fields[1] as int,
        imageURL: fields[2] as String,
        name: fields[3] as String,
        gender: fields[5] as String,
        birthDate: fields[4] as String,
        weight: fields[7] as String,
        height: fields[6] as String,
        diabetesType: fields[8] as String,
        rangeMin: fields[10] as int,
        rangeMax: fields[12] as int,
        hyper: fields[13] as int,
        hypo: fields[9] as int,
        target: fields[11] as int,
        userId: fields[0] as int,
        deviceUUID: fields[14] as String,
        manufacturerId: fields[15] as int,
        yearOfDiagnosis: fields[16] as int,
        smoker: fields[17] as bool,
        isFirstUser: fields[18] as bool,
        treatmentList: (fields[19] as List<String>)
            .map((e) => TreatmentModel.fromJson(jsonDecode(e)))
            .toList());
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.imageURL)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.birthDate)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.height)
      ..writeByte(7)
      ..write(obj.weight)
      ..writeByte(8)
      ..write(obj.diabetesType)
      ..writeByte(9)
      ..write(obj.hypo)
      ..writeByte(10)
      ..write(obj.rangeMin)
      ..writeByte(11)
      ..write(obj.target)
      ..writeByte(12)
      ..write(obj.rangeMax)
      ..writeByte(13)
      ..write(obj.hyper)
      ..writeByte(14)
      ..write(obj.deviceUUID)
      ..writeByte(15)
      ..write(obj.manufacturerId)
      ..writeByte(16)
      ..write(obj.yearOfDiagnosis)
      ..writeByte(17)
      ..write(obj.smoker)
      ..writeByte(18)
      ..write(obj.isFirstUser)
      ..writeByte(19)
      ..write(obj.treatmentList.map((e) => jsonEncode(e.toJson())).toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
