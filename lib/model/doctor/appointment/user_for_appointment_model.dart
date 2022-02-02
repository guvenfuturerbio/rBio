class UserForAppointmentModel {
  String? name;
  String? surname;
  String? identificationNumber;
  String? passportNumber;
  String? phoneNumber;
  int? id;

  UserForAppointmentModel({
    this.name,
    this.surname,
    this.identificationNumber,
    this.passportNumber,
    this.phoneNumber,
    this.id,
  });

  UserForAppointmentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    surname = json['surname'] as String?;
    identificationNumber = json['identification_number'] as String?;
    passportNumber = json['passaport_number'] as String?;
    phoneNumber = json['phone_number'] as String?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['identification_number'] = identificationNumber;
    data['passaport_number'] = passportNumber;
    data['phone_number'] = phoneNumber;
    data['id'] = id;
    return data;
  }
}
