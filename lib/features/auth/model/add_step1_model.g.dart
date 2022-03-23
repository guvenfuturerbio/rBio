// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_step1_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddStep1Model _$AddStep1ModelFromJson(Map<String, dynamic> json) =>
    AddStep1Model(
      birthDate: json['birthDate'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      gender: json['gender'] as String?,
      gsm: json['gsm'] as String?,
      countryCode: json['countryCode'] as String?,
      hasETKApproval: json['hasETKApproval'] as bool? ?? false,
      hasKVKKApproval: json['hasKVKKApproval'] as bool? ?? false,
      id: json['id'] as int? ?? 0,
      identityNumber: json['identityNumber'] as String? ?? "",
      lastName: json['lastName'] as String?,
      nationalityId: json['nationalityId'] as int?,
      passportNumber: json['passportNumber'] as String? ?? "",
      patientType: json['patientType'] as int? ?? 1,
    );

Map<String, dynamic> _$AddStep1ModelToJson(AddStep1Model instance) =>
    <String, dynamic>{
      'birthDate': instance.birthDate,
      'email': instance.email,
      'firstName': instance.firstName,
      'gender': instance.gender,
      'gsm': instance.gsm,
      'countryCode': instance.countryCode,
      'hasETKApproval': instance.hasETKApproval,
      'hasKVKKApproval': instance.hasKVKKApproval,
      'id': instance.id,
      'identityNumber': instance.identityNumber,
      'lastName': instance.lastName,
      'nationalityId': instance.nationalityId,
      'passportNumber': instance.passportNumber,
      'patientType': instance.patientType,
    };
