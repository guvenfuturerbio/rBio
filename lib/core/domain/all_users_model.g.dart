// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllUsersModel _$AllUsersModelFromJson(Map<String, dynamic> json) =>
    AllUsersModel(
      useWidgets: (json['useWidgets'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AllUsersModelToJson(AllUsersModel instance) =>
    <String, dynamic>{
      'useWidgets': instance.useWidgets,
    };
