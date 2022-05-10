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
}
