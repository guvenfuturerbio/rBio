import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:pub_semver/pub_semver.dart';

import '../../config/config.dart';
import '../core.dart';

abstract class LocalCacheManager {
  Future<void> init();
  Future<String> get(String url);
  Future<bool> write(String url, String data, Duration time);
  Future<bool> remove(String url);
  Future<bool> removeAll();
}

class LocalCacheManagerImpl extends LocalCacheManager {
  final _boxKey = 'network_cache';
  late Box box;

  @override
  Future<void> init() async {
    box = await Hive.openBox(_boxKey);
  }

  @override
  Future<String> get(String url) async {
    final jsonString = box.get(url) as String?;

    if (jsonString != null && jsonString != '') {
      final jsonModel = jsonDecode(jsonString) as Map<String, dynamic>;
      final cacheModel = NetworkCacheModel.fromJson(jsonModel);
      final now = DateTime.now();

      if (jsonModel['appVersion'] == null) {
        await remove(url);
        return "";
      } else {
        final appVersion = getIt<GuvenSettings>().version;
        if ((now.isBefore(cacheModel.expirationTime)) &&
            (Version.parse(appVersion) <=
                Version.parse(cacheModel.appVersion))) {
          return cacheModel.data;
        } else {
          await remove(url);
          return "";
        }
      }
    }

    return "";
  }

  @override
  Future<bool> write(String url, String data, Duration time) async {
    try {
      final cacheModel = NetworkCacheModel(
        data: data,
        expirationTime: DateTime.now().add(time),
        appVersion: getIt<GuvenSettings>().version,
      );
      final jsonString = jsonEncode(cacheModel.toJson());
      await box.put(url, jsonString);
      return true;
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  @override
  Future<bool> remove(String url) async {
    try {
      await box.delete(url);
      return true;
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  @override
  Future<bool> removeAll() async {
    try {
      await box.clear();
      return true;
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return false;
    }
  }
}

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
