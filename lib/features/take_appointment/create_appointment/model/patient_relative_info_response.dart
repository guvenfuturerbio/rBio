// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

class PatientRelativeInfoResponse {
  List<PatientRelative> patientRelatives = [];

  PatientRelativeInfoResponse(this.patientRelatives);

  PatientRelativeInfoResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    for (final patient in data) {
      final String name = patient["patient"]["user"]["name"].toString();
      final String surname = patient["patient"]["user"]["surname"].toString();
      final String tcNo =
          patient["patient"]["user"]["identification_number"].toString();
      final String id = patient["patient"]["id"].toString();
      patientRelatives.add(
        PatientRelative(name: name, surname: surname, tcNo: tcNo, id: id),
      );
      
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

class PatientRelative {
  String? name;
  String? surname;
  String? tcNo;
  String? id;
  PatientRelative({
    this.name,
    this.surname,
    this.tcNo,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'tcNo': tcNo,
      'id': id,
    };
  }

  factory PatientRelative.fromMap(Map<String, dynamic> map) {
    return PatientRelative(
      name: map['name'] != null ? map['name'] as String : null,
      surname: map['surname'] != null ? map['surname'] as String : null,
      tcNo: map['tcNo'] != null ? map['tcNo'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientRelative.fromJson(String source) =>
      PatientRelative.fromMap(json.decode(source) as Map<String, dynamic>);
}
