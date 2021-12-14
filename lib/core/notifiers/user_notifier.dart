import 'package:flutter/material.dart';

import '../../model/model.dart';

enum UserType { doctor, chronic_user, basic_user }

class UserNotifier extends ChangeNotifier {
  PatientResponse patient;
  List<UserType> _userType = [];

  bool get isDoctor => _userType.contains(UserType.doctor);
  bool get isCronic => _userType.contains(UserType.chronic_user);
  bool get isPatient => _userType.contains(UserType.basic_user);

  userTypeFetcher(RbioLoginResponse rsp) {
    if (rsp.roles.contains("Doctor")) {
      _userType.add(UserType.doctor);
    }
    if (rsp.roles.contains("cronicPatient")) {
      _userType.add(UserType.chronic_user);
    }
    if (rsp.roles.contains("AllMain")) {
      _userType.add(UserType.basic_user);
    }
  }

  void clear() {
    patient = null;
    _userType = [];
  }
}
