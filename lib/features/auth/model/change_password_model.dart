class ChangePasswordModel {
  String identificationNumber;
  String oldPassword;
  String newPassword;
  String newPasswordConfirmation;

  ChangePasswordModel({
    this.identificationNumber,
    this.oldPassword,
    this.newPassword,
    this.newPasswordConfirmation,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordModel(
        identificationNumber: json['identification_number'] as String,
        oldPassword: json['old_password'] as String,
        newPassword: json['new_password'] as String,
        newPasswordConfirmation: json['new_password_confirmation'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'identification_number': identificationNumber,
        'old_password': oldPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      };
}
