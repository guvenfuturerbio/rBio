import 'package:flutter/material.dart';

class UserAccount {
  String? identificationNumber;
  String? passaportNumber;
  String? nationality;
  String? name;
  String? surname;
  String? phoneNumber;
  String? electronicMail;
  bool? isSmsCodeValidated;
  bool? isActiveEmail;
  String? smsCodeExpireDate;
  List<Patients>? patients;

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
    identificationNumber = json['identification_number'] as String?;
    passaportNumber = json['passaport_number'] as String?;
    nationality = json['nationality'] as String?;
    name = json['name'] as String?;
    surname = json['surname'] as String?;
    phoneNumber = json['phone_number'] as String?;
    electronicMail = json['electronic_mail'] as String?;
    isSmsCodeValidated = json['is_sms_code_validated'] as bool?;
    isActiveEmail = json['is_active_email'] as bool?;
    smsCodeExpireDate = json['sms_code_expire_date'] as String?;
    if (json['patients'] != null) {
      patients = <Patients>[];
      json['patients'].forEach((v) {
        patients?.add(Patients.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identification_number'] = identificationNumber;
    data['passaport_number'] = passaportNumber;
    data['nationality'] = nationality;
    data['name'] = name;
    data['surname'] = surname;
    data['phone_number'] = phoneNumber;
    data['electronic_mail'] = electronicMail;
    data['is_sms_code_validated'] = isSmsCodeValidated;
    data['is_active_email'] = isActiveEmail;
    data['sms_code_expire_date'] = smsCodeExpireDate;
    if (patients != null) {
      data['patients'] = patients?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  UserAccount copyWith({
    required String? phoneNumber,
    required String? electronicMail,
  }) {
    return UserAccount(
      phoneNumber: phoneNumber,
      electronicMail: electronicMail,
      identificationNumber: identificationNumber,
      passaportNumber: passaportNumber,
      nationality: nationality,
      name: name,
      surname: surname,
      isSmsCodeValidated: isSmsCodeValidated,
      isActiveEmail: isActiveEmail,
      smsCodeExpireDate: smsCodeExpireDate,
      patients: patients,
    );
  }
}

class Patients {
  String? birthDate;
  List<String>? patinetHealthCompanies;

  Patients({
    this.birthDate,
    this.patinetHealthCompanies,
  });

  Patients.fromJson(Map<String, dynamic> json) {
    birthDate = json['birth_date'] as String?;
    patinetHealthCompanies != null
        ? patinetHealthCompanies =
            json['patinet_health_companies'] as List<String>?
        : patinetHealthCompanies = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birth_date'] = birthDate;
    data['patinet_health_companies'] = patinetHealthCompanies;
    return data;
  }
}
