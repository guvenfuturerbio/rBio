// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalInfoModel _$AdditionalInfoModelFromJson(Map<String, dynamic> json) {
  return AdditionalInfoModel(
    identificationNumber: json['identification_number'] as String,
    country: json['country'] as String,
    phoneNumber: json['phone_number'] as String,
  );
}

Map<String, dynamic> _$AdditionalInfoModelToJson(
        AdditionalInfoModel instance) =>
    <String, dynamic>{
      'identification_number': instance.identificationNumber,
      'country': instance.country,
      'phone_number': instance.phoneNumber,
    };
