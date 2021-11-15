class CurrentWindowTracker {
  static final CurrentWindowTracker _patientIdHolder = CurrentWindowTracker._internal();
  String currentwindow;
  factory CurrentWindowTracker() {
    return _patientIdHolder;
  }

  CurrentWindowTracker._internal();
}
