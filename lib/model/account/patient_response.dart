class PatientResponse {
  String? patientType;
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
  String? nationalityCode;
  int? nationalityId;
  String? passportNumber;

  PatientResponse({
    this.patientType,
    this.birthDate,
    this.email,
    this.firstName = '',
    this.gender,
    this.gsm,
    this.hasETKApproval,
    this.hasKVKKApproval,
    this.id,
    this.identityNumber,
    this.lastName = '',
    this.nationalityCode,
    this.nationalityId,
    this.passportNumber,
  });

  PatientResponse.fromJson(Map<String, dynamic> json) {
    patientType = json['patientType'] as String?;
    birthDate = json['birthDate'] as String?;
    email = json['email'] as String?;
    firstName = json['firstName'] as String?;
    gender = json['gender'] as String?;
    gsm = json['gsm'] as String?;
    hasETKApproval = json['hasETKApproval'] as bool?;
    hasKVKKApproval = json['hasKVKKApproval'] as bool?;
    id = int.parse(json['id'].toString());
    identityNumber = json['identityNumber'] as String?;
    lastName = json['lastName'] as String?;
    nationalityCode = json['nationalityCode'] as String?;
    nationalityId = int.parse(json['nationalityId'].toString());
    passportNumber = json['passportNumber'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientType'] = patientType;
    data['birthDate'] = birthDate;
    data['email'] = email;
    data['firstName'] = firstName;
    data['gender'] = gender;
    data['gsm'] = gsm;
    data['hasETKApproval'] = hasETKApproval;
    data['hasKVKKApproval'] = hasKVKKApproval;
    data['id'] = id;
    data['identityNumber'] = identityNumber;
    data['lastName'] = lastName;
    data['nationalityCode'] = nationalityCode;
    data['nationalityId'] = nationalityId;
    data['passportNumber'] = passportNumber;
    return data;
  }

  @override
  String toString() {
    return 'PatientResponse(patientType: $patientType, birthDate: $birthDate, email: $email, firstName: $firstName, gender: $gender, gsm: $gsm, hasETKApproval: $hasETKApproval, hasKVKKApproval: $hasKVKKApproval, id: $id, identityNumber: $identityNumber, lastName: $lastName, nationalityCode: $nationalityCode, nationalityId: $nationalityId, passportNumber: $passportNumber)';
  }
}
