// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_treatment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScaleTreatmentResponse _$$_ScaleTreatmentResponseFromJson(
        Map<String, dynamic> json) =>
    _$_ScaleTreatmentResponse(
      treatmentNoteList: (json['treatmentNoteList'] as List<dynamic>?)
          ?.map((e) => ScaleTreatmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dietList: (json['dietList'] as List<dynamic>?)
          ?.map((e) =>
              ScaleTreatmentDietModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      doctorNoteList: (json['doctorNoteList'] as List<dynamic>?)
          ?.map((e) =>
              ScaleTreatmentDoctorNoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ScaleTreatmentResponseToJson(
        _$_ScaleTreatmentResponse instance) =>
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
      createdByName: json['createdByName'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$$_ScaleTreatmentModelToJson(
        _$_ScaleTreatmentModel instance) =>
    <String, dynamic>{
      'treatmentNoteTitle': instance.treatmentNoteTitle,
      'treatmentNoteCreateDate':
          instance.treatmentNoteCreateDate?.toIso8601String(),
      'createdByName': instance.createdByName,
      'id': instance.id,
    };

_$_ScaleTreatmentDoctorNoteModel _$$_ScaleTreatmentDoctorNoteModelFromJson(
        Map<String, dynamic> json) =>
    _$_ScaleTreatmentDoctorNoteModel(
      treatmentNoteTitle: json['treatmentNoteTitle'] as String?,
      treatmentNoteCreateDate: json['treatmentNoteCreateDate'] == null
          ? null
          : DateTime.parse(json['treatmentNoteCreateDate'] as String),
      createdByName: json['createdByName'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$$_ScaleTreatmentDoctorNoteModelToJson(
        _$_ScaleTreatmentDoctorNoteModel instance) =>
    <String, dynamic>{
      'treatmentNoteTitle': instance.treatmentNoteTitle,
      'treatmentNoteCreateDate':
          instance.treatmentNoteCreateDate?.toIso8601String(),
      'createdByName': instance.createdByName,
      'id': instance.id,
    };

_$_ScaleTreatmentDietModel _$$_ScaleTreatmentDietModelFromJson(
        Map<String, dynamic> json) =>
    _$_ScaleTreatmentDietModel(
      dietTitle: json['dietTitle'] as String?,
      dietCreateDate: json['dietCreateDate'] == null
          ? null
          : DateTime.parse(json['dietCreateDate'] as String),
      createdByName: json['createdByName'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$$_ScaleTreatmentDietModelToJson(
        _$_ScaleTreatmentDietModel instance) =>
    <String, dynamic>{
      'dietTitle': instance.dietTitle,
      'dietCreateDate': instance.dietCreateDate?.toIso8601String(),
      'createdByName': instance.createdByName,
      'id': instance.id,
    };
