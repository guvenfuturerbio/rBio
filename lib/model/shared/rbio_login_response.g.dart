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
      firebaseUserEmail: json['firebase_user_email'] as String?,
      firebaseUserSalt: json['firebase_user_salt'] as String?,
    );

Map<String, dynamic> _$RbioLoginResponseToJson(RbioLoginResponse instance) =>
    <String, dynamic>{
      'firebase_user_email': instance.firebaseUserEmail,
      'firebase_user_salt': instance.firebaseUserSalt,
      'token': instance.token,
      'roles': instance.roles,
    };

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      accessToken: json['access_token'] as String?,
      expiresIn: json['expires_in'] as int?,
      refreshExpiresIn: json['refresh_expires_in'] as int?,
      refreshToken: json['refresh_token'] as String?,
      tokenType: json['token_type'] as String?,
      sessionState: json['session_state'] as String?,
      scope: json['scope'] as String?,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn,
      'refresh_expires_in': instance.refreshExpiresIn,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'session_state': instance.sessionState,
      'scope': instance.scope,
    };
