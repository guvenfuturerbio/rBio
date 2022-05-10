import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../features/chronic_tracking/treatment/treatment_detail/model/treatment_model.dart';

import 'diabet_type.dart';

class DoctorPatientDetailModel {
  String? name;
  String? birthDay;
  String? gender;
  String? height;
  String? weight;
  DiabetType? diabetType;
  int? rangeMin;
  int? rangeMax;
  int? hyper;
  int? hypo;
  int? target;
  String? imageUrl;
  String? deviceUuid;
  int? entegrationId;
  bool? smoker;
  int? yearOfDiagnosis;
  int? stripCount;
  int? id;
  String? phoneNumber;
  String? identificationNumber;
  List<TreatmentModel>? treatmentModelList;

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
    this.identificationNumber,
    this.treatmentModelList,
  });

  DoctorPatientDetailModel copyWith({
    String? name,
    String? birthDay,
    String? gender,
    String? height,
    String? weight,
    DiabetType? diabetType,
    int? rangeMin,
    int? rangeMax,
    int? hyper,
    int? hypo,
    int? target,
    String? imageUrl,
    String? deviceUuid,
    int? entegrationId,
    bool? smoker,
    int? yearOfDiagnosis,
    int? stripCount,
    int? id,
    String? phoneNumber,
    String? identificationNumber,
    List<TreatmentModel>? treatmentModelList,
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
      identificationNumber:
          identificationNumber ?? this.identificationNumber,
      treatmentModelList: treatmentModelList ?? this.treatmentModelList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'birth_day': birthDay,
      'gender': gender,
      'height': height,
      'weight': weight,
      'diabet_type': diabetType?.toJson(),
      'range_min': rangeMin,
      'range_max': rangeMax,
      'hyper': hyper,
      'hypo': hypo,
      'target': target,
      'image_url': imageUrl,
      'device_uuid': deviceUuid,
      'entegration_id': entegrationId,
      'smoker': smoker,
      'year_of_diagnosis': yearOfDiagnosis,
      'strip_count': stripCount,
      'id': id,
      'phone_number': phoneNumber,
      'identification_number': identificationNumber,
      'treatment_List': treatmentModelList?.map((x) => x.toJson()).toList(),
    };
  }

  factory DoctorPatientDetailModel.fromMap(Map<String, dynamic> map) {
    return DoctorPatientDetailModel(
      name: map['name'] as String?,
      birthDay: map['birth_day'] as String?,
      gender: map['gender'] as String?,
      height: map['height'] as String?,
      weight: map['weight'] as String?,
      diabetType:
          DiabetType.fromJson(map['diabet_type'] as Map<String, dynamic>),
      rangeMin: map['range_min'] as int?,
      rangeMax: map['range_max'] as int?,
      hyper: map['hyper'] as int?,
      hypo: map['hypo'] as int?,
      target: map['target'] as int?,
      imageUrl: map['image_url'] as String?,
      deviceUuid: map['device_uuid'] as String?,
      entegrationId: map['entegrationId'] as int?,
      smoker: map['smoker'] as bool?,
      yearOfDiagnosis: map['year_of_diagnosis'] as int?,
      stripCount: map['strip_count'] as int?,
      id: map['id'] as int?,
      phoneNumber: map['phone_number'] as String?,
      identificationNumber: map['identification_number'] as String?,
      treatmentModelList: List<TreatmentModel>.from(
        map['treatment_list']
                ?.map((x) => TreatmentModel.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorPatientDetailModel.fromJson(Map<String, dynamic> source) =>
      DoctorPatientDetailModel.fromMap(source);

  @override
  String toString() {
    return 'DoctorPatientDetailModel(name: $name, birthDay: $birthDay, gender: $gender, height: $height, weight: $weight, diabetType: $diabetType, rangeMin: $rangeMin, rangeMax: $rangeMax, hyper: $hyper, hypo: $hypo, target: $target, imageUrl: $imageUrl, deviceUuid: $deviceUuid, entegrationId: $entegrationId, smoker: $smoker, yearOfDiagnosis: $yearOfDiagnosis, stripCount: $stripCount, id: $id, phoneNumber: $phoneNumber, identification_number: $identificationNumber, treatmentModelList: $treatmentModelList)';
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
        other.identificationNumber == identificationNumber &&
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
        identificationNumber.hashCode ^
        treatmentModelList.hashCode;
  }
}
