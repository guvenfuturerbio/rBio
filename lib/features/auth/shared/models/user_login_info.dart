import '../../../../core/core.dart';

class UserLoginInfo extends IBaseModel<UserLoginInfo> {
  String? username;
  String? password;
  String? token;

  UserLoginInfo({
    this.username,
    this.password,
    this.token,
  });

  @override
  UserLoginInfo fromJson(Map<String, dynamic> json) {
    return UserLoginInfo(
      username: json['username'] as String?,
      password: json['password'] as String?,
      token: json['token'] as String?,
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
