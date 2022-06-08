// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_diet_list_add_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScaleDietListAddRequest _$$_ScaleDietListAddRequestFromJson(
        Map<String, dynamic> json) =>
    _$_ScaleDietListAddRequest(
      title: json['title'] as String?,
      breakfast: json['breakfast'] as String?,
      refreshmentBreakfast: json['refreshmentBreakfast'] as String?,
      lunch: json['lunch'] as String?,
      refreshmentLunch: json['refreshmentLunch'] as String?,
      dinner: json['dinner'] as String?,
      refreshmentDinner: json['refreshmentDinner'] as String?,
    );

Map<String, dynamic> _$$_ScaleDietListAddRequestToJson(
        _$_ScaleDietListAddRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'breakfast': instance.breakfast,
      'refreshmentBreakfast': instance.refreshmentBreakfast,
      'lunch': instance.lunch,
      'refreshmentLunch': instance.refreshmentLunch,
      'dinner': instance.dinner,
      'refreshmentDinner': instance.refreshmentDinner,
    };
