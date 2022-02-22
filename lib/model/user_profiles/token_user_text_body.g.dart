// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_user_text_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenUserTextBody _$TokenUserTextBodyFromJson(Map<String, dynamic> json) =>
    TokenUserTextBody(
      id: json['Id'] as String?,
      name: json['NameSurname'] as String?,
      email: json['ElectronicMail'] as String?,
    );

Map<String, dynamic> _$TokenUserTextBodyToJson(TokenUserTextBody instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'NameSurname': instance.name,
      'ElectronicMail': instance.email,
    };
