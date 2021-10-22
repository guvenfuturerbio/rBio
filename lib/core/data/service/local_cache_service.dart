import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/network_cache_model.dart';

part 'local_cache_service_impl.dart';

abstract class LocalCacheService {
  Future<void> init();
  Future<String> get(String url);
  Future<bool> write(String url, String data, Duration time);
  Future<bool> remove(String url);
}
