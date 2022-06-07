import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:pub_semver/pub_semver.dart';

import '../../core/core.dart';

part 'local_cache_service_impl.dart';

abstract class LocalCacheService {
  Future<void> init();
  Future<String> get(String url);
  Future<bool> write(String url, String data, Duration time);
  Future<bool> remove(String url);
  Future<bool> removeAll();
}
