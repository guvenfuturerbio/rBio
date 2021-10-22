import 'user_registration_step1_model.dart';

class RegisterStep1PusulaModel {
  String birthDate;
  String email;
  String firstName;
  String gender;
  String gsm;
  bool hasETKApproval;
  bool hasKVKKApproval;
  int id;
  String identityNumber;
  String lastName;
  int nationalityId;
  String passportNumber;
  int patientType;

  RegisterStep1PusulaModel({
    this.birthDate,
    this.email,
    this.firstName,
    this.gender,
    this.gsm,
    this.hasETKApproval = false,
    this.hasKVKKApproval = false,
    this.id,
    this.identityNumber = "",
    this.lastName,
    this.nationalityId,
    this.passportNumber = "",
    this.patientType = 1,
  });

  RegisterStep1PusulaModel.fromJson(Map<String, dynamic> json) {
    birthDate = json['birthDate'];
    email = json['email'];
    firstName = json['firstName'];
    gender = json['gender'];
    gsm = json['gsm'];
    hasETKApproval = json['hasETKApproval'];
    hasKVKKApproval = json['hasKVKKApproval'];
    id = json['id'];
    identityNumber = json['identityNumber'];
    lastName = json['lastName'];
    nationalityId = json['nationalityId'];
    passportNumber = json['passportNumber'];
    patientType = json['patientType'];
  }

  UserRegistrationStep1Model toOldModel() {
    var result = UserRegistrationStep1Model();
    result.name = firstName;
    result.surname = lastName;
    result.electronicMail = email;
    if (nationalityId == 213) {
      result.userNationality = 'TC';
    } else {
      result.userNationality = 'D';
    }
    result.phoneNumber = gsm;
    if (result.userNationality == 'TC')
      result.identificationNumber = identityNumber.toString();
    else {
      result.identificationNumber = passportNumber;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthDate'] = this.birthDate;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['gender'] = this.gender;
    data['gsm'] = this.gsm;
    data['hasETKApproval'] = this.hasETKApproval;
    data['hasKVKKApproval'] = this.hasKVKKApproval;
    data['identityNumber'] = this.identityNumber;
    data['lastName'] = this.lastName;
    data['nationalityId'] = this.nationalityId;
    data['passportNumber'] = this.passportNumber;
    data['patientType'] = this.patientType;
    return data;
  }
}
