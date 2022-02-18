part of '../omron.dart';

class StartOmronManagerModel {
  final String hashId;
  final int categoryType;
  final int device;

  StartOmronManagerModel({
    required this.hashId,
    required this.device,
    required this.categoryType,
  });

  Map<String, dynamic> toJson() => {
        'categoryType': categoryType,
        'hashId': hashId,
        'device': device,
      };
}
