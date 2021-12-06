class PatientResponse {
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
  String nationalityCode;
  int nationalityId;
  String passportNumber;

  PatientResponse({
    this.birthDate,
    this.email,
    this.firstName,
    this.gender,
    this.gsm,
    this.hasETKApproval,
    this.hasKVKKApproval,
    this.id,
    this.identityNumber,
    this.lastName,
    this.nationalityCode,
    this.nationalityId,
    this.passportNumber,
  });

  PatientResponse.fromJson(Map<String, dynamic> json) {
    birthDate = json['birthDate'];
    email = json['email'];
    firstName = json['firstName'];
    gender = json['gender'];
    gsm = json['gsm'];
    hasETKApproval = json['hasETKApproval'];
    hasKVKKApproval = json['hasKVKKApproval'];
    id = int.parse(json['id'].toString());
    identityNumber = json['identityNumber'];
    lastName = json['lastName'];
    nationalityCode = json['nationalityCode'];
    nationalityId = int.parse(json['nationalityId'].toString());
    passportNumber = json['passportNumber'];
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
    data['id'] = this.id;
    data['identityNumber'] = this.identityNumber;
    data['lastName'] = this.lastName;
    data['nationalityCode'] = this.nationalityCode;
    data['nationalityId'] = this.nationalityId;
    data['passportNumber'] = this.passportNumber;
    return data;
  }

  @override
  String toString() {
    return 'PatientResponse(birthDate: $birthDate, email: $email, firstName: $firstName, gender: $gender, gsm: $gsm, hasETKApproval: $hasETKApproval, hasKVKKApproval: $hasKVKKApproval, id: $id, identityNumber: $identityNumber, lastName: $lastName, nationalityCode: $nationalityCode, nationalityId: $nationalityId, passportNumber: $passportNumber)';
  }
}
