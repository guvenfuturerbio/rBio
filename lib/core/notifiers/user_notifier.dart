import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/services/user_service.dart';

import '../core.dart';
import '../../model/model.dart';

class UserNotifier extends ChangeNotifier {
  String username;
  String password;
  PatientResponse patient;

  Future<void> loginExampleUser() async {
    final widgetsBinding = WidgetsBinding.instance;
    if (widgetsBinding != null) {
      widgetsBinding.addPostFrameCallback((_) async {
        try {
          username = '18620716416';
          password = 'Numlock1234!!';
          await getIt<UserManager>().login(username, password);
          await getIt<ISharedPreferencesManager>()
              .setString(SharedPreferencesKeys.LOGIN_USERNAME, username);
          await getIt<ISharedPreferencesManager>()
              .setString(SharedPreferencesKeys.LOGIN_PASSWORD, password);
          patient = await getIt<Repository>().getPatientDetail();
          await getIt<UserManager>().getUserProfile();

          final response = await getIt<Repository>().getProfilePicture();
          if (response != null && response != '') {
            await getIt<ISharedPreferencesManager>()
                .setString(SharedPreferencesKeys.PROFILE_IMAGE, response);
          }
        } catch (e) {
          print(e);
        } finally {
          notifyListeners();
        }
      });
    }
  }
}
