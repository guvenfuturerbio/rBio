class PatientIdHolder {
  static final PatientIdHolder _patientIdHolder = PatientIdHolder._internal();
  String patient_id;
  factory PatientIdHolder() {
    return _patientIdHolder;
  }

  PatientIdHolder._internal();
}
