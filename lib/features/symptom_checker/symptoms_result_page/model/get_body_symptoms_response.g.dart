// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_body_symptoms_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBodySymptomsResponse _$GetBodySymptomsResponseFromJson(
        Map<String, dynamic> json) =>
    GetBodySymptomsResponse(
      id: json['ID'] as int?,
      name: json['Name'] as String?,
      hasRedFlag: json['HasRedFlag'] as bool?,
      healthSymptomLocationIDs:
          (json['HealthSymptomLocationIDs'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),
      profName: json['ProfName'] as String?,
      synonyms: (json['Synonyms'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$GetBodySymptomsResponseToJson(
        GetBodySymptomsResponse instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Name': instance.name,
      'HasRedFlag': instance.hasRedFlag,
      'HealthSymptomLocationIDs': instance.healthSymptomLocationIDs,
      'ProfName': instance.profName,
      'Synonyms': instance.synonyms,
    };
