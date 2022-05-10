class AddPatientRelativeRequest {
  String? birthDate;
  String? email;
  String? firstName;
  String? gender;
  String? gsm;
  bool? hasETKApproval;
  bool? hasKVKKApproval;
  String? identityNumber;
  String? lastName;
  int? nationalityId;
  int? nationalityCode;
  String? passportNumber;
  int? patientType;
  List<PatinetHealthCompanies>? patinetHealthCompanies;

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
    birthDate = json['birthDate'] as String?;
    email = json['email'] as String?;
    firstName = json['firstName'] as String?;
    gender = json['gender'] as String?;
    gsm = json['gsm'] as String?;
    hasETKApproval = json['hasETKApproval'] as bool?;
    hasKVKKApproval = json['hasKVKKApproval'] as bool?;
    identityNumber = json['identityNumber'] as String?;
    lastName = json['lastName'] as String?;
    nationalityId = json['nationalityId'] as int?;
    nationalityCode = json['nationalityCode'] as int?;
    passportNumber = json['passportNumber'] as String?;
    patientType = json['patientType'] as int?;
    if (json['patinet_health_companies'] != null) {
      patinetHealthCompanies = <PatinetHealthCompanies>[];
      json['patinet_health_companies'].forEach((v) {
        patinetHealthCompanies
            ?.add(PatinetHealthCompanies.fromJson(v as Map<String, dynamic>));
      });
    }
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
    data['nationalityCode'] = nationalityCode;
    data['passportNumber'] = passportNumber;
    data['patientType'] = patientType;
    if (patinetHealthCompanies != null) {
      data['patinet_health_companies'] =
          patinetHealthCompanies?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatinetHealthCompanies {
  HealthCompany? healthCompany;

  PatinetHealthCompanies({this.healthCompany});

  PatinetHealthCompanies.fromJson(Map<String, dynamic> json) {
    healthCompany = json['health_company'] != null
        ? HealthCompany.fromJson(json['health_company'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (healthCompany != null) {
      data['health_company'] = healthCompany?.toJson();
    }
    return data;
  }
}

class HealthCompany {
  int? id;

  HealthCompany({this.id});

  HealthCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
