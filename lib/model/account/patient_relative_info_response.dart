class PatientRelativeInfoResponse {
  List<PatientRelative> patientRelatives = [];

  PatientRelativeInfoResponse();

  PatientRelativeInfoResponse.fromJson(Map<String, dynamic> json) {
    var data = json['data'];

    for (var patient in data) {
      if (this.patientRelatives == null) {
        this.patientRelatives = [];
      }
      String name = patient["patient"]["user"]["name"].toString();
      String surname = patient["patient"]["user"]["surname"].toString();
      String tcNo =
          patient["patient"]["user"]["identification_number"].toString();
      String id = patient["patient"]["id"].toString();
      this.patientRelatives.add(new PatientRelative(name, surname, tcNo, id));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class PatientRelative {
  String name;
  String surname;
  String tcNo;
  String id;

  PatientRelative(String name, String surname, String tcNo, String id) {
    this.name = name;
    this.surname = surname;
    this.tcNo = tcNo;
    this.id = id;
  }
}
