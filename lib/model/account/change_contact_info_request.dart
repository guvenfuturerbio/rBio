class ChangeContactInfoRequest {
  int patientId;
  int patientType;
  int nationalityId;
  String firstName;
  String lastName;
  String gender;
  String identityNumber;
  String gsm;
  String gsmCountryCode;
  String email;
  bool hasETKApproval;
  bool hasKVKKApproval;
  String passportNumber;
  
  ChangeContactInfoRequest({
    this.patientId,
    this.patientType,
    this.nationalityId,
    this.firstName,
    this.lastName,
    this.gender,
    this.identityNumber,
    this.gsm,
    this.gsmCountryCode,
    this.email,
    this.hasETKApproval,
    this.hasKVKKApproval,
    this.passportNumber,
  });

  factory ChangeContactInfoRequest.fromJson(Map<String, dynamic> json) =>
      ChangeContactInfoRequest(
        patientId: json['patientId'] as int,
        patientType: json['patientType'] as int,
        nationalityId: json['nationalityId'] as int,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        gender: json['gender'] as String,
        identityNumber: json['identityNumber'] as String,
        gsm: json['gsm'] as String,
        gsmCountryCode: json['gsmCountryCode'] as String,
        email: json['email'] as String,
        hasETKApproval: json['hasETKApproval'] as bool,
        hasKVKKApproval: json['hasKVKKApproval'] as bool,
        passportNumber: json['passportNumber'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'patientId': patientId,
        'patientType': patientType,
        'nationalityId': nationalityId,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'identityNumber': identityNumber,
        'gsm': gsm,
        'gsmCountryCode': gsmCountryCode,
        'email': email,
        'hasETKApproval': hasETKApproval,
        'hasKVKKApproval': hasKVKKApproval,
        'passportNumber': passportNumber,
      };
}
