import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../key_manager.dart';

class KeyManager {
  final _map = <Keys, String>{};

  String get(Keys key) {
    final value = _map[key];
    if (value == null) {
      throw Exception("$key valu null");
    }

    return value;
  }

  Future<void> setup(
    Environment env, {
    Map<Keys, String> remote = const {},
  }) async {
    await dotenv.load(fileName: env.xFileName);
    final local =
        dotenv.env.map((key, value) => MapEntry(_fromString(key), value));
    _map.addAll({...local, ...remote});
  }

  Keys _fromString(String s) => Keys.values.firstWhere((v) => v.name == s);
}
