// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rbio_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RbioLoginResponse _$RbioLoginResponseFromJson(Map<String, dynamic> json) =>
    RbioLoginResponse(
      ssoResponse: json['sso_response'] == null
          ? null
          : SsoResponse.fromJson(json['sso_response'] as Map<String, dynamic>),
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      firebaseUserEmail: json['firebase_user_email'] as String?,
      firebaseUserSalt: json['firebase_user_salt'] as String?,
    );

Map<String, dynamic> _$RbioLoginResponseToJson(RbioLoginResponse instance) =>
    <String, dynamic>{
      'sso_response': instance.ssoResponse,
      'roles': instance.roles,
      'firebase_user_email': instance.firebaseUserEmail,
      'firebase_user_salt': instance.firebaseUserSalt,
    };

SsoResponse _$SsoResponseFromJson(Map<String, dynamic> json) => SsoResponse(
      accessToken: json['access_token'] as String?,
      error: json['error'] as String?,
      errorDescription: json['error_description'] as String?,
      httpStatusCode: json['http_status_code'] as int?,
    );

Map<String, dynamic> _$SsoResponseToJson(SsoResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'error': instance.error,
      'error_description': instance.errorDescription,
      'http_status_code': instance.httpStatusCode,
    };
