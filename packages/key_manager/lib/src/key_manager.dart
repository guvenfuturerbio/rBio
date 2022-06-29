import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../key_manager.dart';

class KeyManager {
  final map = <Keys, String>{};

  String get(Keys key) {
    final value = map[key];
    if (value == null) {
      throw Exception("$key valu null");
    }

    return value;
  }

  Future<void> setup(
    String filePath, {
    Map<Keys, String> remote = const {},
  }) async {
    await dotenv.load(fileName: filePath);
    final local =
        dotenv.env.map((key, value) => MapEntry(_fromString(key), value));
    map.addAll({...local, ...remote});
  }

  Keys _fromString(String s) => Keys.values.firstWhere((v) => v.name == s);
}
