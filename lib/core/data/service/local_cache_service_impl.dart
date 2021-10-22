part of 'local_cache_service.dart';

class LocalCacheServiceImpl extends LocalCacheService {
  final _boxKey = 'network_cache';
  Box box;

  @override
  Future<void> init() async {
    if (!kIsWeb) {
      final appDocumentDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
    }

    box = await Hive.openBox(_boxKey);
  }

  @override
  Future<String> get(String url) async {
    final jsonString = box.get(url);

    if (jsonString != null && jsonString != '') {
      final jsonModel = jsonDecode(jsonString);
      final cacheModel = NetworkCacheModel.fromJson(jsonModel);
      final now = DateTime.now();
      if (now.isBefore(cacheModel.expirationTime)) {
        return cacheModel.data;
      } else {
        await remove(url);
      }
    }

    return null;
  }

  @override
  Future<bool> write(String url, String data, Duration time) async {
    try {
      final cacheModel = NetworkCacheModel(
          data: data, expirationTime: DateTime.now().add(time));
      final jsonString = jsonEncode(cacheModel.toJson());
      if (jsonString != null) {
        await box.put(url, jsonString);
      }
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Future<bool> remove(String url) async {
    try {
      await box.delete(url);
      return true;
    } on Exception {
      return false;
    }
  }
}

// void test(){
//   final exampleUrl = 'https://www.google.com.t/';
//   final exampleMap = {
//     "userId": 1,
//     "id": 1,
//     "title": "delectus aut autem",
//     "completed": false
//   };
//   final exampleData = jsonEncode(exampleMap);

//   final result = await getIt<LocalCacheService>().get(exampleUrl);
//   LoggerUtils.instance.i('Hive - Get');
//   LoggerUtils.instance.i(result);

//   final writeResult = await getIt<LocalCacheService>().write(
//     exampleUrl,
//     exampleData,
//     Duration(seconds: 1),
//   );
//   LoggerUtils.instance.i('Hive - Write');
//   LoggerUtils.instance.i(writeResult);

//   await Future.delayed(Duration(seconds: 10));

//   final result2 = await getIt<LocalCacheService>().get(exampleUrl);
//   LoggerUtils.instance.i('Hive - Get2');
//   LoggerUtils.instance.i(result2);

//   final result3 = await getIt<LocalCacheService>().remove(exampleUrl);
//   LoggerUtils.instance.i('Hive - Remove');
//   LoggerUtils.instance.i(result3);

//   final result4 = await getIt<LocalCacheService>().get(exampleUrl);
//   LoggerUtils.instance.i('Hive - Get3');
//   LoggerUtils.instance.i(result4);
// }