import 'dart:io';

class PersonModel {
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

  int userId;
  int id;
  String imageURL;
  String name;
  String birthDate;
  String gender;
  String height;
  String weight;
  String diabetesType;
  int hypo;
  int rangeMin;
  int target;
  int rangeMax;
  int hyper;
  String deviceUUID;
  int manufacturerId;
  int yearOfDiagnosis;
  bool smoker; // 0 non smoker , 1 smoker, 2 smokes occasionally, 3 smokes often
  bool isFirstUser;

  File profileImage = File("");
  static const MAX_PERSON = 5;

  PersonModel({
    this.id,
    this.imageURL,
    this.name = "",
    this.gender,
    this.birthDate,
    this.weight,
    this.height,
    this.diabetesType,
    this.rangeMin = 90,
    this.rangeMax = 160,
    this.hyper = 200,
    this.hypo = 50,
    this.target = 120,
    this.userId,
    this.deviceUUID = "",
    this.manufacturerId = 0,
    this.yearOfDiagnosis = 2021,
    this.smoker = false,
    this.isFirstUser = false,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        userId: json['id'] as int,
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
        deviceUUID: json['device_uuid'] as String,
        manufacturerId: json['manufacturer_id'] as int,
        yearOfDiagnosis: json['year_of_diagnosis'] as int,
        smoker: json['smoker'] as bool,
        isFirstUser: json['is_first_user'] as bool,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': userId,
        'entegration_id': id,
        'image_url': imageURL,
        'name': name,
        'birth_day': birthDate,
        'gender': gender,
        'height': height,
        'weight': weight,
        'diabetes_type': diabetesType,
        'hypo': hypo,
        'range_min': rangeMin,
        'target': target,
        'range_max':rangeMax,
        'hyper': hyper,
        'device_uuid': deviceUUID,
        'manufacturer_id': manufacturerId,
        'year_of_diagnosis': yearOfDiagnosis,
        'smoker': smoker,
        'is_first_user': isFirstUser,
      };

  bool compareTo(PersonModel rhs) => identical(this, rhs);

  @override
  String toString() {
    return 'Person(userId: $userId, id: $id, imageURL: $imageURL, name: $name, birthDate: $birthDate, gender: $gender, height: $height, weight: $weight, diabetesType: $diabetesType, hypo: $hypo, rangeMin: $rangeMin, target: $target, rangeMax: $rangeMax, hyper: $hyper, deviceUUID: $deviceUUID, manufacturerId: $manufacturerId, yearOfDiagnosis: $yearOfDiagnosis, smoker: $smoker, isFirstUser: $isFirstUser)';
  }
}
