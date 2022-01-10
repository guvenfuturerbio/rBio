import 'user_registration_step1_model.dart';

class UserRegistrationStep2Model {
  String password;
  String repassword;
  UserRegistrationStep1Model userRegistrationStep1;

  UserRegistrationStep2Model({
    this.password,
    this.repassword,
    this.userRegistrationStep1,
  });

  factory UserRegistrationStep2Model.fromJson(Map<String, dynamic> json) =>
      UserRegistrationStep2Model(
        password: json['password'] as String,
        repassword: json['repassword'] as String,
        userRegistrationStep1: UserRegistrationStep1Model.fromJson(
            json['user_registration_step1'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'password': password,
        'repassword': repassword,
        'user_registration_step1':userRegistrationStep1.toJson(),
      };
}
