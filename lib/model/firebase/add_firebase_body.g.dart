// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_firebase_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFirebaseToken _$AddFirebaseTokenFromJson(Map<String, dynamic> json) {
  return AddFirebaseToken(
    firebaseId: json['fire_base_id'] as String?,
    phoneInfo: json['phone_info'] as String?,
  );
}

Map<String, dynamic> _$AddFirebaseTokenToJson(AddFirebaseToken instance) =>
    <String, dynamic>{
      'fire_base_id': instance.firebaseId,
      'phone_info': instance.phoneInfo,
    };
