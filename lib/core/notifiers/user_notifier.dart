import 'package:flutter/material.dart';

import '../core.dart';

class UserNotifier extends ChangeNotifier {
  final UserFacade userFacade;
  UserNotifier(this.userFacade);

  RbioUser? user;
  String? firebaseID;
  String? firebaseEmail;
  String? firebasePassword;
  bool? isDefaultUser;

  void handleUserType(List<String>? roles) {
    if (roles?.contains(UserType.doctor.xGetRoleName) ?? false) {
      user = RbioDoctorUser();
      return;
    }

    if (roles?.contains(UserType.chronicUser.xGetRoleName) ?? false) {
      user = RbioChronicUser();
      return;
    }

    user = RbioBasicUser();
  }

  Future<void> logout(BuildContext context) async {
    await userFacade.logout(context, _setInitialState);
    notifyListeners();
  }

  void setFirebaseID(String value) {
    firebaseID = value;
  }

  void setFirebaseEmail(String? value) {
    firebaseEmail = value;
  }

  void setFirebasePassword(String? value) {
    firebasePassword = value;
  }

  void setDefaultUser(bool? value) {
    isDefaultUser = value;
  }

  void _setInitialState() {
    user = null;
  }
}

abstract class RbioUser {
  final bool chat;
  final bool chronicTracking;
  final bool healthcareEmployee;
  RbioUser({
    required this.chat,
    required this.chronicTracking,
    required this.healthcareEmployee,
  });
}

class RbioDoctorUser extends RbioUser {
  RbioDoctorUser()
      : super(
          chat: true,
          chronicTracking: false,
          healthcareEmployee: true,
        );
}

class RbioChronicUser extends RbioUser {
  RbioChronicUser()
      : super(
          chat: true,
          chronicTracking: true,
          healthcareEmployee: false,
        );
}

class RbioBasicUser extends RbioUser {
  RbioBasicUser()
      : super(
          chat: false,
          chronicTracking: false,
          healthcareEmployee: false,
        );
}

// ---------------- ---------------- ---------------- ----------------

enum UserType {
  doctor,
  chronicUser,
  basicUser,
}

extension UserTypeExt on UserType {
  String get xGetRoleName {
    switch (this) {
      case UserType.doctor:
        return "Doctor";

      case UserType.chronicUser:
        return "cronicPatient";

      case UserType.basicUser:
        throw Exception("Undefined-UserType.basicUser");
    }
  }
}

extension RbioUserBoolExtension on RbioUser? {
  bool get xGetChronicTrackingOrFalse {
    if (this == null) return false;
    return this!.chronicTracking;
  }

  bool get xGetHealthcareEmployeeOrFalse {
    if (this == null) return false;
    return this!.healthcareEmployee;
  }
}
