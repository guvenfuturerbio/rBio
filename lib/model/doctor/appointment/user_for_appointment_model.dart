class UserForAppointmentModel {
  String name;
  String surname;
  String identificationNumber;
  String passportNumber;
  String phoneNumber;
  int id;

  UserForAppointmentModel({
    this.name,
    this.surname,
    this.identificationNumber,
    this.passportNumber,
    this.phoneNumber,
    this.id,
  });

  UserForAppointmentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    identificationNumber = json['identification_number'];
    passportNumber = json['passaport_number'];
    phoneNumber = json['phone_number'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['identification_number'] = this.identificationNumber;
    data['passaport_number'] = this.passportNumber;
    data['phone_number'] = this.phoneNumber;
    data['id'] = this.id;
    return data;
  }
}
