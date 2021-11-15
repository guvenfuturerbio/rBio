class DoctorChecker {
  static final DoctorChecker _doctorChecker = DoctorChecker._internal();
  bool doctor=false;
  factory DoctorChecker() {
    return _doctorChecker;
  }

  DoctorChecker._internal();
}
