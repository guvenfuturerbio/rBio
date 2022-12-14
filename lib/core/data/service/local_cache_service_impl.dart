part of 'local_cache_service.dart';

class LocalCacheServiceImpl extends LocalCacheService {
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
      } else {
        final appVersion = getIt<GuvenSettings>().version;
        if ((now.isBefore(cacheModel.expirationTime)) &&
            (Version.parse(appVersion) <=
                Version.parse(cacheModel.appVersion))) {
          return cacheModel.data;
        } else {
          await remove(url);
        }
      }
    }

    throw Exception("$url local cache null");
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
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> remove(String url) async {
    try {
      await box.delete(url);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> removeAll() async {
    try {
      await box.clear();
      return true;
    } catch (_) {
      return false;
    }
  }
}
