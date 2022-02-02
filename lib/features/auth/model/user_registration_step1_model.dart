class UserRegistrationStep1Model {
  String? name;
  String? surname;
  String? phoneNumber;
  String? identificationNumber;
  String? electronicMail;
  String? userNationality;

  UserRegistrationStep1Model({
    this.name,
    this.surname,
    this.phoneNumber,
    this.identificationNumber,
    this.electronicMail,
    this.userNationality,
  });

  factory UserRegistrationStep1Model.fromJson(Map<String, dynamic> json) =>
      UserRegistrationStep1Model(
        name: json['name'] as String,
        surname: json['surname'] as String,
        phoneNumber: json['phone_number'] as String,
        identificationNumber: json['identification_number'] as String,
        electronicMail: json['electronic_mail'] as String,
        userNationality: json['user_nationality'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'surname': surname,
        'phone_number': phoneNumber,
        'identification_number': identificationNumber,
        'electronic_mail': electronicMail,
        'user_nationality': userNationality,
      };
}
