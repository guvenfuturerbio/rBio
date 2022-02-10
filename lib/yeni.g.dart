// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yeni.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YeniModel _$YeniModelFromJson(Map<String, dynamic> json) => YeniModel(
      treatmentList: (json['treatment_list'] as List<dynamic>?)
          ?.map((e) => TreatmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$YeniModelToJson(YeniModel instance) => <String, dynamic>{
      'treatment_list': instance.treatmentList,
    };
