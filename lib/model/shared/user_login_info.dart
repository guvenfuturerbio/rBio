import '../../core/domain/base_model.dart';

class UserLoginInfo extends IBaseModel<UserLoginInfo> {
  String username;
  String password;
  String token;

  UserLoginInfo({
    this.username,
    this.password,
    this.token,
  });

  @override
  UserLoginInfo fromJson(Map<String, dynamic> json) {
    return UserLoginInfo(
      username: json['username'],
      password: json['password'],
      token: json['token'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'token': token,
    };
  }
}
