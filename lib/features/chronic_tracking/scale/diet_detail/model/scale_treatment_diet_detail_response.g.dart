// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_treatment_diet_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScaleTreatmentDietDetailResponse
    _$$_ScaleTreatmentDietDetailResponseFromJson(Map<String, dynamic> json) =>
        _$_ScaleTreatmentDietDetailResponse(
          dietTitle: json['dietTitle'] as String?,
          dietCreateDate: json['dietCreateDate'] as String?,
          createdByName: json['createdByName'] as String?,
          dietBreakfast: json['dietBreakfast'] as String?,
          dietRefreshment: json['dietRefreshment'] as String?,
          dietLunch: json['dietLunch'] as String?,
          dietDinner: json['dietDinner'] as String?,
          id: json['id'] as int?,
        );

Map<String, dynamic> _$$_ScaleTreatmentDietDetailResponseToJson(
        _$_ScaleTreatmentDietDetailResponse instance) =>
    <String, dynamic>{
      'dietTitle': instance.dietTitle,
      'dietCreateDate': instance.dietCreateDate,
      'createdByName': instance.createdByName,
      'dietBreakfast': instance.dietBreakfast,
      'dietRefreshment': instance.dietRefreshment,
      'dietLunch': instance.dietLunch,
      'dietDinner': instance.dietDinner,
      'id': instance.id,
    };
