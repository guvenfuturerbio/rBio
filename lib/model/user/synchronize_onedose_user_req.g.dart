// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synchronize_onedose_user_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SynchronizeOneDoseUserRequest _$$_SynchronizeOneDoseUserRequestFromJson(
        Map<String, dynamic> json) =>
    _$_SynchronizeOneDoseUserRequest(
      birthDate: json['birthDate'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      gender: json['gender'] as String?,
      gsm: json['gsm'] as String?,
      countryCode: json['countryCode'] as String?,
      hasEtkApproval: json['hasEtkApproval'] as bool?,
      hasKvkkApproval: json['hasKvkkApproval'] as bool?,
      id: json['id'] as int?,
      identityNumber: json['identityNumber'] as String?,
      lastName: json['lastName'] as String?,
      nationalityId: json['nationalityId'] as int?,
      passportNumber: json['passportNumber'] as String?,
      patientType: json['patientType'] as int?,
    );

Map<String, dynamic> _$$_SynchronizeOneDoseUserRequestToJson(
        _$_SynchronizeOneDoseUserRequest instance) =>
    <String, dynamic>{
      'birthDate': instance.birthDate,
      'email': instance.email,
      'firstName': instance.firstName,
      'gender': instance.gender,
      'gsm': instance.gsm,
      'countryCode': instance.countryCode,
      'hasEtkApproval': instance.hasEtkApproval,
      'hasKvkkApproval': instance.hasKvkkApproval,
      'id': instance.id,
      'identityNumber': instance.identityNumber,
      'lastName': instance.lastName,
      'nationalityId': instance.nationalityId,
      'passportNumber': instance.passportNumber,
      'patientType': instance.patientType,
    };
