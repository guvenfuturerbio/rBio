import 'package:flutter/material.dart';

import 'base_model.dart';

class NetworkCacheModel extends IBaseModel<NetworkCacheModel> {
  String data;
  DateTime expirationTime;

  NetworkCacheModel({
    this.data,
    @required this.expirationTime,
  });

  factory NetworkCacheModel.fromJson(Map<String, dynamic> json) =>
      NetworkCacheModel(
        data: json['data'] as String,
        expirationTime: DateTime.parse(json['expirationTime'] as String),
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
        'expirationTime': expirationTime.toIso8601String(),
      };

  @override
  NetworkCacheModel fromJson(Map<String, dynamic> json) =>
      NetworkCacheModel.fromJson(json);
}
