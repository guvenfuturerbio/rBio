import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:onedosehealth/generated/l10n.dart';

import '../../notifiers/user_notifier.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
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
  /*
     "name":"xxxxx ",
     "birth_day":"16.05.1977",
     "gender":"Male",
     "height":"277cm",
     "weight":"172kg",
     "diabetes_type":"Type 1",
     "range_min":101,
     "range_max":181,
     "hyper":15,
     "hypo":115,
     "target":121,
     "image_url":"abc1.png",
     "device_UUID":"12314",
     "id":1
   */
  @JsonKey(name: "id")
  int userId;
  @JsonKey(name: "entegration_id")
  int id;
  @JsonKey(name: IMAGE_URL)
  String imageURL;
  @JsonKey(name: NAME)
  String name;
  @JsonKey(name: "birth_day")
  String birthDate;
  @JsonKey(name: GENDER)
  String gender;
  @JsonKey(name: HEIGHT)
  String height;
  @JsonKey(name: WEIGHT)
  String weight;
  @JsonKey(name: DIABETES_TYPE)
  String diabetesType;
  @JsonKey(name: "hypo")
  int hypo;
  @JsonKey(name: "range_min")
  int rangeMin;
  @JsonKey(name: "target")
  int target;
  @JsonKey(name: "range_max")
  int rangeMax;
  @JsonKey(name: "hyper")
  int hyper;
  @JsonKey(name: "device_uuid")
  String deviceUUID;
  @JsonKey(name: MANUFACTURER_ID)
  int manufacturerId;
  @JsonKey(name: YEAR_OF_DIGANOSIS)
  int yearOfDiagnosis;
  @JsonKey(name: SMOKER)
  bool smoker; // 0 non smoker , 1 smoker, 2 smokes occasionally, 3 smokes often
  @JsonKey(name: "is_first_user")
  bool isFirstUser;

  @JsonKey(ignore: true)
  File profileImage = new File("");

  static const MAX_PERSON = 5;
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  Person(
      {this.id,
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
      this.isFirstUser = false});

  Person fromMap(Map map) {
    return Person(
        id: map[ID],
        weight: map[WEIGHT].toString(),
        height: map[HEIGHT].toString(),
        hypo: map[HYPO],
        rangeMin: map[RANGE_MIN],
        rangeMax: map[RANGE_MAX],
        hyper: map[HYPER],
        deviceUUID: map[DEVICE_UUID],
        imageURL: map[IMAGE_URL],
        name: map[NAME],
        birthDate: map[BIRTH_DATE],
        gender: map[GENDER],
        diabetesType: map[DIABETES_TYPE],
        yearOfDiagnosis: int.parse(map[YEAR_OF_DIGANOSIS]),
        smoker: map[SMOKER] == 0 ? false : true,
        isFirstUser: map["is_first_user"] == 0 ? false : true,
        manufacturerId: map[MANUFACTURER_ID]);
  }

  Map<String, dynamic> toMap() {
    return {
      ID: id,
      WEIGHT: int.parse(weight),
      HEIGHT: int.parse(height),
      HYPO: hypo,
      RANGE_MIN: rangeMin,
      RANGE_MAX: rangeMax,
      HYPER: hyper,
      DEVICE_UUID: deviceUUID,
      IMAGE_URL: imageURL,
      NAME: name,
      BIRTH_DATE: birthDate,
      GENDER: gender,
      DIABETES_TYPE: diabetesType,
      YEAR_OF_DIGANOSIS: yearOfDiagnosis.toString(),
      SMOKER: smoker,
      MANUFACTURER_ID: manufacturerId
    };
  }

  Person fromDefault() {
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
        name: UserNotifier().firebaseUser != null
            ? (UserNotifier().firebaseUser.displayName ??
                UserNotifier().firebaseUser.email)
            : "Name Surname",
        birthDate: "01.01.2020",
        gender: 'unsp',
        diabetesType: 'nondia',
        yearOfDiagnosis: 2021,
        smoker: false,
        isFirstUser: false);
  }

  bool compareTo(Person rhs) {
    print(identical(this, rhs));
    return identical(this, rhs);
  }

  static const DEFAULT_VERY_LOW = 36;
  static const DEFAULT_LOW = 91;
  static const DEFAULT_TARGET = 131;
  static const DEFAULT_HIGH = 151;
  static const DEFAULT_VERY_HIGH = 301;
}
