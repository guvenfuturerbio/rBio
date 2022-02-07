// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rbio_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RbioLoginResponse _$RbioLoginResponseFromJson(Map<String, dynamic> json) =>
    RbioLoginResponse(
      token: json['token'] == null
          ? null
          : Token.fromJson(json['token'] as Map<String, dynamic>),
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      firebase_user_email: json['firebase_user_email'] as String?,
      firebase_user_salt: json['firebase_user_salt'] as String?,
    );

Map<String, dynamic> _$RbioLoginResponseToJson(RbioLoginResponse instance) =>
    <String, dynamic>{
      'firebase_user_email': instance.firebase_user_email,
      'firebase_user_salt': instance.firebase_user_salt,
      'token': instance.token,
      'roles': instance.roles,
    };
