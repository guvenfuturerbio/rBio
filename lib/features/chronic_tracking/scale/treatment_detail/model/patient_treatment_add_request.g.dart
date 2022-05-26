// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_add_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PatientTreatmentAddRequest _$$_PatientTreatmentAddRequestFromJson(
        Map<String, dynamic> json) =>
    _$_PatientTreatmentAddRequest(
      title: json['title'] as String?,
      text: json['text'] as String?,
      treatmentNoteTypeId: json['treatmentNoteTypeId'] as int?,
    );

Map<String, dynamic> _$$_PatientTreatmentAddRequestToJson(
        _$_PatientTreatmentAddRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
      'treatmentNoteTypeId': instance.treatmentNoteTypeId,
    };
