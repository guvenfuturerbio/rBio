// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_treatment_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScaleTreatmentDetailResponse _$$_ScaleTreatmentDetailResponseFromJson(
        Map<String, dynamic> json) =>
    _$_ScaleTreatmentDetailResponse(
      treatmentNoteTitle: json['treatmentNoteTitle'] as String?,
      treatmentNoteText: json['treatmentNoteText'] as String?,
      treatmentNoteCreateDate: json['treatmentNoteCreateDate'] as String?,
      createdByName: json['createdByName'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$$_ScaleTreatmentDetailResponseToJson(
        _$_ScaleTreatmentDetailResponse instance) =>
    <String, dynamic>{
      'treatmentNoteTitle': instance.treatmentNoteTitle,
      'treatmentNoteText': instance.treatmentNoteText,
      'treatmentNoteCreateDate': instance.treatmentNoteCreateDate,
      'createdByName': instance.createdByName,
      'id': instance.id,
    };
