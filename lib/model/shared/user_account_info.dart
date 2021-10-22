class UserAccount {
  String identificationNumber;
  String passaportNumber;
  String nationality;
  String name;
  String surname;
  String phoneNumber;
  String electronicMail;
  bool isSmsCodeValidated;
  bool isActiveEmail;
  String smsCodeExpireDate;
  List<Patients> patients;

  UserAccount({
    this.identificationNumber,
    this.passaportNumber,
    this.nationality,
    this.name,
    this.surname,
    this.phoneNumber,
    this.electronicMail,
    this.isSmsCodeValidated,
    this.isActiveEmail,
    this.smsCodeExpireDate,
    this.patients,
  });

  UserAccount.fromJson(Map<String, dynamic> json) {
    identificationNumber = json['identification_number'];
    passaportNumber = json['passaport_number'];
    nationality = json['nationality'];
    name = json['name'];
    surname = json['surname'];
    phoneNumber = json['phone_number'];
    electronicMail = json['electronic_mail'];
    isSmsCodeValidated = json['is_sms_code_validated'];
    isActiveEmail = json['is_active_email'];
    smsCodeExpireDate = json['sms_code_expire_date'];
    if (json['patients'] != null) {
      patients = <Patients>[];
      json['patients'].forEach((v) {
        patients.add(new Patients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identification_number'] = this.identificationNumber;
    data['passaport_number'] = this.passaportNumber;
    data['nationality'] = this.nationality;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['phone_number'] = this.phoneNumber;
    data['electronic_mail'] = this.electronicMail;
    data['is_sms_code_validated'] = this.isSmsCodeValidated;
    data['is_active_email'] = this.isActiveEmail;
    data['sms_code_expire_date'] = this.smsCodeExpireDate;
    if (this.patients != null) {
      data['patients'] = this.patients.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Patients {
  String birthDate;
  List<String> patinetHealthCompanies;

  Patients({
    this.birthDate,
    this.patinetHealthCompanies,
  });

  Patients.fromJson(Map<String, dynamic> json) {
    birthDate = json['birth_date'];
    patinetHealthCompanies != null
        ? patinetHealthCompanies =
            json['patinet_health_companies'].cast<String>()
        : patinetHealthCompanies = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birth_date'] = this.birthDate;
    data['patinet_health_companies'] = this.patinetHealthCompanies;
    return data;
  }
}
