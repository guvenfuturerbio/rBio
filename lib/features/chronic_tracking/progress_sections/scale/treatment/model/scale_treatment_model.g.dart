// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_treatment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScaleResponseModel _$$_ScaleResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_ScaleResponseModel(
      treatmentNoteList: (json['treatmentNoteList'] as List<dynamic>?)
          ?.map((e) => ScaleTreatmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dietList: (json['dietList'] as List<dynamic>?)
          ?.map((e) =>
              ScaleTreatmentDietModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      doctorNoteList: json['doctorNoteList'] as bool?,
    );

Map<String, dynamic> _$$_ScaleResponseModelToJson(
        _$_ScaleResponseModel instance) =>
    <String, dynamic>{
      'treatmentNoteList': instance.treatmentNoteList,
      'dietList': instance.dietList,
      'doctorNoteList': instance.doctorNoteList,
    };

_$_ScaleTreatmentModel _$$_ScaleTreatmentModelFromJson(
        Map<String, dynamic> json) =>
    _$_ScaleTreatmentModel(
      treatmentNoteTitle: json['treatmentNoteTitle'] as String?,
      treatmentNoteCreateDate: json['treatmentNoteCreateDate'] == null
          ? null
          : DateTime.parse(json['treatmentNoteCreateDate'] as String),
      treatmentNoteId: json['treatmentNoteId'] as int?,
      createdByName: json['createdByName'] as String?,
    );

Map<String, dynamic> _$$_ScaleTreatmentModelToJson(
        _$_ScaleTreatmentModel instance) =>
    <String, dynamic>{
      'treatmentNoteTitle': instance.treatmentNoteTitle,
      'treatmentNoteCreateDate':
          instance.treatmentNoteCreateDate?.toIso8601String(),
      'treatmentNoteId': instance.treatmentNoteId,
      'createdByName': instance.createdByName,
    };

_$_ScaleTreatmentDietModel _$$_ScaleTreatmentDietModelFromJson(
        Map<String, dynamic> json) =>
    _$_ScaleTreatmentDietModel(
      dietTitle: json['dietTitle'] as String?,
      dietCreateDate: json['dietCreateDate'] == null
          ? null
          : DateTime.parse(json['dietCreateDate'] as String),
      dietId: json['dietId'] as int?,
      createdByName: json['createdByName'] as String?,
      dietBreakfast: json['dietBreakfast'] as String?,
      dietRefreshment: json['dietRefreshment'] as String?,
      dietLunch: json['dietLunch'] as String?,
      dietDinner: json['dietDinner'] as String?,
    );

Map<String, dynamic> _$$_ScaleTreatmentDietModelToJson(
        _$_ScaleTreatmentDietModel instance) =>
    <String, dynamic>{
      'dietTitle': instance.dietTitle,
      'dietCreateDate': instance.dietCreateDate?.toIso8601String(),
      'dietId': instance.dietId,
      'createdByName': instance.createdByName,
      'dietBreakfast': instance.dietBreakfast,
      'dietRefreshment': instance.dietRefreshment,
      'dietLunch': instance.dietLunch,
      'dietDinner': instance.dietDinner,
    };
