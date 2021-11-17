import 'map_convertable.dart';

class UserLoginInfo extends MapConvertible {
  String username;
  String password;
  String token;

  @override
  UserLoginInfo({this.username, this.password, this.token});
  @override
  factory UserLoginInfo.fromMap(Map map) => UserLoginInfo(
      username: map['username'],
      password: map['password'],
      token: map['token']);

  @override
  UserLoginInfo fromMap(Map map) {
    return UserLoginInfo(
        username: map['username'],
        password: map['password'],
        token: map['token']);
  }

  @override
  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password, 'token': token};
  }
}
