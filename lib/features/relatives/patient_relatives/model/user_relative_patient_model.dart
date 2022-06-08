import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserRelativePatientModel {
  final String? birthDate;
  final String? email;
  final String? gender;
  final String? gsm;
  final String? identityNumber;
  final String? firstName;
  final String? lastName;
  final String? nationalityId;

  UserRelativePatientModel({
    this.birthDate,
    this.email,
    this.gender,
    this.gsm,
    this.identityNumber,
    this.firstName,
    this.lastName,
    this.nationalityId,
  });

  UserRelativePatientModel copyWith({
    String? birthDate,
    String? email,
    String? gender,
    String? gsm,
    String? identityNumber,
    String? firstName,
    String? lastName,
    String? nationalityId,
  }) {
    return UserRelativePatientModel(
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      gsm: gsm ?? this.gsm,
      identityNumber: identityNumber ?? this.identityNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nationalityId: nationalityId ?? this.nationalityId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'birthDate': birthDate,
      'email': email,
      'gender': gender,
      'gsm': gsm,
      'identityNumber': identityNumber,
      'firstName': firstName,
      'lastName': lastName,
      'nationalityId': nationalityId,
    };
  }

  factory UserRelativePatientModel.fromMap(Map<String, dynamic> map) {
    return UserRelativePatientModel(
      birthDate: map['birthDate'] != null ? map['birthDate'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      gsm: map['gsm'] != null ? map['gsm'] as String : null,
      identityNumber: map['identityNumber'] != null
          ? map['identityNumber'] as String
          : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      nationalityId:
          map['nationalityId'] != null ? map['nationalityId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRelativePatientModel.fromJson(String source) =>
      UserRelativePatientModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserRelativePatientModel(birthDate: $birthDate, email: $email, gender: $gender, gsm: $gsm, identityNumber: $identityNumber, firstName: $firstName, lastName: $lastName, nationalityId: $nationalityId)';
  }
}
