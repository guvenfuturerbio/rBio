import 'user_registration_step2_model.dart';

class UserRegistrationStep3Model {
  String sms;
  UserRegistrationStep2Model userRegistrationStep2;

  UserRegistrationStep3Model({
    this.sms,
    this.userRegistrationStep2,
  });

  factory UserRegistrationStep3Model.fromJson(Map<String, dynamic> json) =>
      UserRegistrationStep3Model(
        sms: json['sms'] as String,
        userRegistrationStep2: UserRegistrationStep2Model.fromJson(
            json['user_registration_step2'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sms': sms,
        'user_registration_step2': userRegistrationStep2,
      };
}
