import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:onedosehealth/model/treatment_model/treatment_model.dart';

import 'diabet_type.dart';

class DoctorPatientDetailModel {
  String name;
  String birthDay;
  String gender;
  String height;
  String weight;
  DiabetType diabetType;
  int rangeMin;
  int rangeMax;
  int hyper;
  int hypo;
  int target;
  String imageUrl;
  String deviceUuid;
  int entegrationId;
  bool smoker;
  int yearOfDiagnosis;
  int stripCount;
  int id;
  String phoneNumber;
  String identification_number;
  List<TreatmentModel> treatmentModelList;
  DoctorPatientDetailModel({
    this.name,
    this.birthDay,
    this.gender,
    this.height,
    this.weight,
    this.diabetType,
    this.rangeMin,
    this.rangeMax,
    this.hyper,
    this.hypo,
    this.target,
    this.imageUrl,
    this.deviceUuid,
    this.entegrationId,
    this.smoker,
    this.yearOfDiagnosis,
    this.stripCount,
    this.id,
    this.phoneNumber,
    this.identification_number,
    this.treatmentModelList,
  });

  DoctorPatientDetailModel copyWith({
    String name,
    String birthDay,
    String gender,
    String height,
    String weight,
    DiabetType diabetType,
    int rangeMin,
    int rangeMax,
    int hyper,
    int hypo,
    int target,
    String imageUrl,
    String deviceUuid,
    int entegrationId,
    bool smoker,
    int yearOfDiagnosis,
    int stripCount,
    int id,
    String phoneNumber,
    String identification_number,
    List<TreatmentModel> treatmentModelList,
  }) {
    return DoctorPatientDetailModel(
      name: name ?? this.name,
      birthDay: birthDay ?? this.birthDay,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      diabetType: diabetType ?? this.diabetType,
      rangeMin: rangeMin ?? this.rangeMin,
      rangeMax: rangeMax ?? this.rangeMax,
      hyper: hyper ?? this.hyper,
      hypo: hypo ?? this.hypo,
      target: target ?? this.target,
      imageUrl: imageUrl ?? this.imageUrl,
      deviceUuid: deviceUuid ?? this.deviceUuid,
      entegrationId: entegrationId ?? this.entegrationId,
      smoker: smoker ?? this.smoker,
      yearOfDiagnosis: yearOfDiagnosis ?? this.yearOfDiagnosis,
      stripCount: stripCount ?? this.stripCount,
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      identification_number:
          identification_number ?? this.identification_number,
      treatmentModelList: treatmentModelList ?? this.treatmentModelList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'birthDay': birthDay,
      'gender': gender,
      'height': height,
      'weight': weight,
      'diabetType': diabetType.toJson(),
      'rangeMin': rangeMin,
      'rangeMax': rangeMax,
      'hyper': hyper,
      'hypo': hypo,
      'target': target,
      'imageUrl': imageUrl,
      'deviceUuid': deviceUuid,
      'entegrationId': entegrationId,
      'smoker': smoker,
      'yearOfDiagnosis': yearOfDiagnosis,
      'stripCount': stripCount,
      'id': id,
      'phoneNumber': phoneNumber,
      'identification_number': identification_number,
      'treatmentModelList': treatmentModelList.map((x) => x.toJson()).toList(),
    };
  }

  factory DoctorPatientDetailModel.fromMap(Map<String, dynamic> map) {
    return DoctorPatientDetailModel(
      name: map['name'] ?? '',
      birthDay: map['birthDay'] ?? '',
      gender: map['gender'] ?? '',
      height: map['height'] ?? '',
      weight: map['weight'] ?? '',
      diabetType: DiabetType.fromJson(map['diabetType']),
      rangeMin: map['rangeMin']?.toInt() ?? 0,
      rangeMax: map['rangeMax']?.toInt() ?? 0,
      hyper: map['hyper']?.toInt() ?? 0,
      hypo: map['hypo']?.toInt() ?? 0,
      target: map['target']?.toInt() ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      deviceUuid: map['deviceUuid'] ?? '',
      entegrationId: map['entegrationId']?.toInt() ?? 0,
      smoker: map['smoker'] ?? false,
      yearOfDiagnosis: map['yearOfDiagnosis']?.toInt() ?? 0,
      stripCount: map['stripCount']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      phoneNumber: map['phoneNumber'] ?? '',
      identification_number: map['identification_number'] ?? '',
      treatmentModelList: List<TreatmentModel>.from(
          map['treatmentModelList']?.map((x) => TreatmentModel.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorPatientDetailModel.fromJson(String source) =>
      DoctorPatientDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DoctorPatientDetailModel(name: $name, birthDay: $birthDay, gender: $gender, height: $height, weight: $weight, diabetType: $diabetType, rangeMin: $rangeMin, rangeMax: $rangeMax, hyper: $hyper, hypo: $hypo, target: $target, imageUrl: $imageUrl, deviceUuid: $deviceUuid, entegrationId: $entegrationId, smoker: $smoker, yearOfDiagnosis: $yearOfDiagnosis, stripCount: $stripCount, id: $id, phoneNumber: $phoneNumber, identification_number: $identification_number, treatmentModelList: $treatmentModelList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DoctorPatientDetailModel &&
        other.name == name &&
        other.birthDay == birthDay &&
        other.gender == gender &&
        other.height == height &&
        other.weight == weight &&
        other.diabetType == diabetType &&
        other.rangeMin == rangeMin &&
        other.rangeMax == rangeMax &&
        other.hyper == hyper &&
        other.hypo == hypo &&
        other.target == target &&
        other.imageUrl == imageUrl &&
        other.deviceUuid == deviceUuid &&
        other.entegrationId == entegrationId &&
        other.smoker == smoker &&
        other.yearOfDiagnosis == yearOfDiagnosis &&
        other.stripCount == stripCount &&
        other.id == id &&
        other.phoneNumber == phoneNumber &&
        other.identification_number == identification_number &&
        listEquals(other.treatmentModelList, treatmentModelList);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        birthDay.hashCode ^
        gender.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        diabetType.hashCode ^
        rangeMin.hashCode ^
        rangeMax.hashCode ^
        hyper.hashCode ^
        hypo.hashCode ^
        target.hashCode ^
        imageUrl.hashCode ^
        deviceUuid.hashCode ^
        entegrationId.hashCode ^
        smoker.hashCode ^
        yearOfDiagnosis.hashCode ^
        stripCount.hashCode ^
        id.hashCode ^
        phoneNumber.hashCode ^
        identification_number.hashCode ^
        treatmentModelList.hashCode;
  }
}
