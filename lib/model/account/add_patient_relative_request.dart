class AddPatientRelativeRequest {
  String birthDate;
  String email;
  String firstName;
  String gender;
  String gsm;
  bool hasETKApproval;
  bool hasKVKKApproval;
  String identityNumber;
  String lastName;
  int nationalityId;
  int nationalityCode;
  String passportNumber;
  int patientType;
  List<PatinetHealthCompanies> patinetHealthCompanies;

  AddPatientRelativeRequest({
    this.birthDate,
    this.email,
    this.firstName,
    this.gender,
    this.gsm,
    this.hasETKApproval,
    this.hasKVKKApproval,
    this.identityNumber,
    this.lastName,
    this.nationalityId,
    this.nationalityCode,
    this.passportNumber,
    this.patientType,
    this.patinetHealthCompanies,
  });

  AddPatientRelativeRequest.fromJson(Map<String, dynamic> json) {
    birthDate = json['birthDate'];
    email = json['email'];
    firstName = json['firstName'];
    gender = json['gender'];
    gsm = json['gsm'];
    hasETKApproval = json['hasETKApproval'];
    hasKVKKApproval = json['hasKVKKApproval'];
    identityNumber = json['identityNumber'];
    lastName = json['lastName'];
    nationalityId = json['nationalityId'];
    nationalityCode = json['nationalityCode'];
    passportNumber = json['passportNumber'];
    patientType = json['patientType'];
    if (json['patinet_health_companies'] != null) {
      patinetHealthCompanies = new List<PatinetHealthCompanies>();
      json['patinet_health_companies'].forEach((v) {
        patinetHealthCompanies.add(new PatinetHealthCompanies.fromJson(v));
      });
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
    data['nationalityCode'] = this.nationalityCode;
    data['passportNumber'] = this.passportNumber;
    data['patientType'] = this.patientType;
    if (this.patinetHealthCompanies != null) {
      data['patinet_health_companies'] =
          this.patinetHealthCompanies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatinetHealthCompanies {
  HealthCompany healthCompany;

  PatinetHealthCompanies({this.healthCompany});

  PatinetHealthCompanies.fromJson(Map<String, dynamic> json) {
    healthCompany = json['health_company'] != null
        ? new HealthCompany.fromJson(json['health_company'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.healthCompany != null) {
      data['health_company'] = this.healthCompany.toJson();
    }
    return data;
  }
}

class HealthCompany {
  int id;

  HealthCompany({this.id});

  HealthCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
