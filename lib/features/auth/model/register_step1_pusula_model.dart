class RegisterStep1PusulaModel {
  String? birthDate;
  String? email;
  String? firstName;
  String? gender;
  String? gsm;
  bool? hasETKApproval;
  bool? hasKVKKApproval;
  int? id;
  String? identityNumber;
  String? lastName;
  int? nationalityId;
  String? passportNumber;
  int? patientType;

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
    birthDate = json['birthDate'] as String;
    email = json['email'] as String;
    firstName = json['firstName'] as String;
    gender = json['gender'] as String;
    gsm = json['gsm'] as String;
    hasETKApproval = json['hasETKApproval'] as bool;
    hasKVKKApproval = json['hasKVKKApproval'] as bool;
    id = json['id'] as int;
    identityNumber = json['identityNumber'] as String;
    lastName = json['lastName'] as String;
    nationalityId = json['nationalityId'] as int;
    passportNumber = json['passportNumber'] as String;
    patientType = json['patientType'] as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birthDate'] = birthDate;
    data['email'] = email;
    data['firstName'] = firstName;
    data['gender'] = gender;
    data['gsm'] = gsm;
    data['hasETKApproval'] = hasETKApproval;
    data['hasKVKKApproval'] = hasKVKKApproval;
    data['identityNumber'] = identityNumber;
    data['lastName'] = lastName;
    data['nationalityId'] = nationalityId;
    data['passportNumber'] = passportNumber;
    data['patientType'] = patientType;
    return data;
  }
}
