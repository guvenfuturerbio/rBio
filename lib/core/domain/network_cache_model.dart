import 'package:flutter/material.dart';

import 'base_model.dart';

class NetworkCacheModel extends IBaseModel<NetworkCacheModel> {
  String data;
  DateTime expirationTime;
  String appVersion;

  NetworkCacheModel({
    required this.data,
    required this.expirationTime,
    required this.appVersion,
  });

  factory NetworkCacheModel.fromJson(Map<String, dynamic> json) =>
      NetworkCacheModel(
        data: json['data'] as String,
        expirationTime: DateTime.parse(json['expirationTime'] as String),
        appVersion: json['appVersion'] as String,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
        'expirationTime': expirationTime.toIso8601String(),
        'appVersion': appVersion,
      };

  @override
  NetworkCacheModel fromJson(Map<String, dynamic> json) =>
      NetworkCacheModel.fromJson(json);
}
