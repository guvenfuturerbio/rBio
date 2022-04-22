// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../model/treatment_model/treatment_model.dart';
import '../../core/core.dart';

part 'person_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Person extends HiveObject {
  static const ID = "id";
  static const USER_ID = 'entegration_id';
  static const IMAGE_URL = "image_url";
  static const NAME = "name";
  static const BIRTH_DATE = "birth_day";
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
  @JsonKey(name: ID)
  int? userId;

  @HiveField(1)
  @JsonKey(name: USER_ID)
  int? id;

  @HiveField(2)
  @JsonKey(name: IMAGE_URL)
  String? imageURL;

  @HiveField(3)
  @JsonKey(name: NAME)
  String? name;

  @HiveField(4)
  @JsonKey(name: BIRTH_DATE)
  String? birthDate;

  @HiveField(5)
  @JsonKey(name: GENDER)
  String? gender;

  @HiveField(6)
  @JsonKey(name: HEIGHT)
  String? height;

  @HiveField(7)
  @JsonKey(name: WEIGHT)
  String? weight;

  @HiveField(8)
  @JsonKey(name: DIABETES_TYPE)
  String? diabetesType;

  @HiveField(9)
  @JsonKey(name: HYPO)
  int? hypo;

  @HiveField(10)
  @JsonKey(name: RANGE_MIN)
  int? rangeMin;

  @HiveField(11)
  @JsonKey(name: 'target')
  int? target;

  @HiveField(12)
  @JsonKey(name: RANGE_MAX)
  int? rangeMax;

  @HiveField(13)
  @JsonKey(name: HYPER)
  int? hyper;

  @HiveField(14)
  @JsonKey(name: DEVICE_UUID)
  String? deviceUUID;

  @HiveField(15)
  @JsonKey(name: MANUFACTURER_ID)
  int? manufacturerId;

  @HiveField(16)
  @JsonKey(name: YEAR_OF_DIGANOSIS)
  int? yearOfDiagnosis;

  @HiveField(17)
  @JsonKey(name: SMOKER)
  bool?
      smoker; // 0 non smoker , 1 smoker, 2 smokes occasionally, 3 smokes often

  @HiveField(18)
  @JsonKey(ignore: true)
  bool? isFirstUser;

  @HiveField(19)
  @JsonKey(name: 'treatment_list')
  List<TreatmentModel>? treatmentList;

  @JsonKey(ignore: true)
  File profileImage = File("");

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  Map<String, dynamic> getRequestBody() {
    final diabetesType = this.diabetesType.xGetDiabetesType.xRawValue;
    final json = _$PersonToJson(this);
    json['diabetes_type'] = diabetesType;
    return json;
  }

  Person fromDefault({
    String name = 'First',
    String lastName = 'Last Name',
    String birthDate = '01.01.1980',
    String gender = 'Unspesified',
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
        name: '$name $lastName',
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
    final person = Person.fromJson(_jsonDecode as Map<String, dynamic>);
    return person;
  }

  @override
  bool operator ==(Object other) =>
      other is Person && other.userId == userId && other.id == id;

  bool isEqual(Person other) {
    return jsonEncode(toJson()) == jsonEncode(other.toJson());
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
/* 
Person _$PersonFromJson(Map<String, dynamic> json) => Person(
    id: json['entegration_id'] as int,
    imageURL: json['image_url'] as String,
    name: json['name'] as String,
    gender: json['gender'] as String,
    birthDate: json['birth_day'] as String,
    weight: json['weight'] as String,
    height: json['height'] as String,
    diabetesType: json['diabetes_type'] as String,
    rangeMin: json['range_min'] as int,
    rangeMax: json['range_max'] as int,
    hyper: json['hyper'] as int,
    hypo: json['hypo'] as int,
    target: json['target'] as int,
    userId: json['id'] as int,
    deviceUUID: json['device_uuid'] as String,
    manufacturerId: json['manufacturer_id'] as int,
    yearOfDiagnosis: json['year_of_diagnosis'] as int,
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
            .map((e) => TreatmentModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : []);

Map<String, dynamic> _$PersonToJson(Person instance, String? treatment) {
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
} */
