import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefInit {
  static final SharedPrefInit _sharePrefInit = SharedPrefInit._internal();

  SharedPreferences sharedPreferences;
  factory SharedPrefInit() {
    return _sharePrefInit;
  }

  SharedPrefInit._internal();
  load() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
